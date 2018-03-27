#include <math.h>
#include <stdlib.h>
#include <string.h>
#include "main.h"
#include "stm32f1xx_hal.h"
#include "MPU6050.h"
#include "kalman.h"
#include "MotoControl.h"

// System varible
extern I2C_HandleTypeDef hi2c1;
TIM_HandleTypeDef htim2;
UART_HandleTypeDef huart1;

/*User varible*/
// Bluetooth control value
uint8_t bufferData[10] = "";
uint8_t dataIndex = 0;
uint8_t receiveData = 0;
char* sentData;
char tempString[20];
char sentString[30];
uint8_t dir = 0;
// MPU6050 data value
DataMpu6050 MPU6050data;
bool byVelocity = true;
double gx = 0;
double ax = 0;
double m_angle = 0;
// PID controler value
double e = 0;
double integral = 0;
double error_prior = 0;
double iteration_time = 0.01;
double derivative = 0;
double output = 0;
float PID_bias = 0;
float KP = 55;//6;
float KI = 55;//30;
float KD = 55;//0.2;
// Moto timer interupt
uint8_t t_timer = 0;
uint8_t t_on_time = 0;

// Function of system
void SystemClock_Config(void);
static void MX_GPIO_Init(void);
static void MX_USART1_UART_Init(void);
static void MX_TIM2_Init(void);

int main(void)
{
  //System initialize
  HAL_Init();
  SystemClock_Config();
  MX_TIM2_Init();
  MX_GPIO_Init();
  MX_USART1_UART_Init();

  /* USER CODE BEGIN 2 */
  HAL_Delay(1000);
  HAL_TIM_Base_Start_IT(&htim2);
  HAL_UART_Receive_IT(&huart1,&receiveData,1);
  MPU6050_Initialize(NT_MPU6050_Device_AD0_LOW,NT_MPU6050_Accelerometer_2G,NT_MPU6050_Gyroscope_2000s);
  HAL_Delay(1000);
  while (1)
  {
    //Getdata from MPU6050
    MPU6050_GetRawAccelTempGyro(&MPU6050data);
    MPU6050_convert(&MPU6050data);
    gx = MPU6050data.NT_MPU6050_Gx;
    ax = MPU6050data.NT_MPU6050_Ax;
    //Calculator angle
    //TODO: Write function get m_angle from by velocity or acceleration
    m_angle = m_angle + gx*iteration_time;
    //Kalman Filter
    m_angle = Kalman(m_angle,gx);
    //Calculator ouput of PID
    integral += (m_angle*iteration_time);
    derivative = (m_angle - error_prior)/iteration_time;
    output = KP*m_angle + KI*integral + KD*derivative + PID_bias;
    t_on_time = (int)(output);
    error_prior = m_angle;
    //Test sent data
//    sprintf(sentString,"%.2f",m_angle);
//    strcat(sentString," ");
//    sprintf(tempString,"%.2f",gx);
//    strcat(sentString,tempString);
//    strcat(sentString," ");
//    sprintf(tempString,"%.2f",ax);
//    strcat(sentString,tempString);
//    strcat(sentString,"\n");
//    HAL_UART_Transmit(&huart1,(uint8_t*)sentString,strlen(sentString),500);
    //Control motor
    MotoControl(m_angle, dir);
    //Delay for next sample
    HAL_Delay((int)iteration_time*1000);
  }
}

// System Clock Config
void SystemClock_Config(void){

  RCC_OscInitTypeDef RCC_OscInitStruct;
  RCC_ClkInitTypeDef RCC_ClkInitStruct;

    /**Initializes the CPU, AHB and APB busses clocks 
    */
  RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSE;
  RCC_OscInitStruct.HSEState = RCC_HSE_ON;
  RCC_OscInitStruct.HSEPredivValue = RCC_HSE_PREDIV_DIV1;
  RCC_OscInitStruct.HSIState = RCC_HSI_ON;
  RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
  RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_HSE;
  RCC_OscInitStruct.PLL.PLLMUL = RCC_PLL_MUL9;
  if (HAL_RCC_OscConfig(&RCC_OscInitStruct) != HAL_OK)
  {
    _Error_Handler(__FILE__, __LINE__);
  }

    /**Initializes the CPU, AHB and APB busses clocks 
    */
  RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK|RCC_CLOCKTYPE_SYSCLK
                              |RCC_CLOCKTYPE_PCLK1|RCC_CLOCKTYPE_PCLK2;
  RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_PLLCLK;
  RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
  RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV2;
  RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV1;

  if (HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_2) != HAL_OK)
  {
    _Error_Handler(__FILE__, __LINE__);
  }

    /**Configure the Systick interrupt time 
    */
  HAL_SYSTICK_Config(HAL_RCC_GetHCLKFreq()/1000);

    /**Configure the Systick 
    */
  HAL_SYSTICK_CLKSourceConfig(SYSTICK_CLKSOURCE_HCLK);

  /* SysTick_IRQn interrupt configuration */
  HAL_NVIC_SetPriority(SysTick_IRQn, 0, 0);
}

/* TIM2 init function */
static void MX_TIM2_Init(void){

  TIM_ClockConfigTypeDef sClockSourceConfig;
  TIM_MasterConfigTypeDef sMasterConfig;

  htim2.Instance = TIM2;
  htim2.Init.Prescaler = 89;
  htim2.Init.CounterMode = TIM_COUNTERMODE_UP;
  htim2.Init.Period = 79;
  htim2.Init.ClockDivision = TIM_CLOCKDIVISION_DIV1;
  htim2.Init.AutoReloadPreload = TIM_AUTORELOAD_PRELOAD_DISABLE;
  if (HAL_TIM_Base_Init(&htim2) != HAL_OK)
  {
    _Error_Handler(__FILE__, __LINE__);
  }

  sClockSourceConfig.ClockSource = TIM_CLOCKSOURCE_INTERNAL;
  if (HAL_TIM_ConfigClockSource(&htim2, &sClockSourceConfig) != HAL_OK)
  {
    _Error_Handler(__FILE__, __LINE__);
  }

  sMasterConfig.MasterOutputTrigger = TIM_TRGO_RESET;
  sMasterConfig.MasterSlaveMode = TIM_MASTERSLAVEMODE_DISABLE;
  if (HAL_TIMEx_MasterConfigSynchronization(&htim2, &sMasterConfig) != HAL_OK)
  {
    _Error_Handler(__FILE__, __LINE__);
  }

}

/* USART1 init function */
static void MX_USART1_UART_Init(void){

  huart1.Instance = USART1;
  huart1.Init.BaudRate = 9600;
  huart1.Init.WordLength = UART_WORDLENGTH_8B;
  huart1.Init.StopBits = UART_STOPBITS_1;
  huart1.Init.Parity = UART_PARITY_NONE;
  huart1.Init.Mode = UART_MODE_TX_RX;
  huart1.Init.HwFlowCtl = UART_HWCONTROL_NONE;
  huart1.Init.OverSampling = UART_OVERSAMPLING_16;
  if (HAL_UART_Init(&huart1) != HAL_OK)
  {
    _Error_Handler(__FILE__, __LINE__);
  }

}

//Configure pins
static void MX_GPIO_Init(void){

  GPIO_InitTypeDef GPIO_InitStruct;

  /* GPIO Ports Clock Enable */
  __HAL_RCC_GPIOD_CLK_ENABLE();
  __HAL_RCC_GPIOA_CLK_ENABLE();
  __HAL_RCC_GPIOB_CLK_ENABLE();

  /*Configure GPIO pin Output Level */
  HAL_GPIO_WritePin(GPIOA, GPIO_PIN_0|GPIO_PIN_1|GPIO_PIN_2|GPIO_PIN_3|GPIO_PIN_4|GPIO_PIN_5, GPIO_PIN_RESET);

  /*Configure GPIO pins : PA0 PA1 PA2 PA3 */
  GPIO_InitStruct.Pin = GPIO_PIN_0|GPIO_PIN_1|GPIO_PIN_2|GPIO_PIN_3|GPIO_PIN_4|GPIO_PIN_5;
  GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
  GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_HIGH;
  HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);
}

//Bluetooth received data to control
void HAL_UART_RxCpltCallback(UART_HandleTypeDef *huart){
  if (huart->Instance == huart1.Instance){
    if (receiveData == '\n'){
      /*
      * 0 : check OK function
      * 1 : request angle
      */
      switch (bufferData[0]){
        case '0':
//          sentData = "OK\n";
//          HAL_UART_Transmit(&huart1,(uint8_t*)sentData,strlen(sentData),1000);
          //test
          char temp[6] = "";
          uint8_t idx = 0;
          uint8_t i = 2;
          float num = 0;
          while(i <= dataIndex){
            char ch = bufferData[i++];
            if (ch != ' ') temp[idx++] = ch;
            else{
              temp[idx] = '\0';
              if (num == 0.0){
                num = atof(temp);
              }
              else{
                KI = atof(temp);
              }
              idx = 0;
            }
          }
          KP = num;
          KD = atof(temp);
          sprintf(sentString,"%.2f",KP);
          strcat(sentString," ");
          sprintf(tempString,"%.2f",KI);
          strcat(sentString,tempString);
          strcat(sentString," ");
          sprintf(tempString,"%.2f",KD);
          strcat(sentString,tempString);
          strcat(sentString,"\n");
          HAL_UART_Transmit(&huart1,(uint8_t*)sentString,strlen(sentString),500);
          break;
        case '1':
          sprintf(sentString,"%.2f",m_angle);
          strcat(sentString," ");
          sprintf(tempString,"%.2f",gx);
          strcat(sentString,tempString);
          strcat(sentString," ");
          sprintf(tempString,"%.2f",ax);
          strcat(sentString,tempString);
          strcat(sentString,"\n");
          HAL_UART_Transmit(&huart1,(uint8_t*)sentString,strlen(sentString),500);
          break;
        case '2':
          break;
      }
      dataIndex = 0;
    }
    else{
      // Add new character to list
      bufferData[dataIndex++] = receiveData;
    }
    //Receive data
    //Check end symbol
      //When end symbol: Solve request
        //Send back data such as angle, gx, ax,...
        //Apply Setting data and send back answer OK or NOT
    //Allow receive data again
    HAL_UART_Receive_IT(&huart1, &receiveData,1);
  }
}
//Timer interupt to define 0.001 second
void HAL_TIM_PeriodElapsedCallback(TIM_HandleTypeDef *htim){
  if(htim->Instance == htim2.Instance){
    //interupt 0.001 second
    InterruptMoto(t_on_time - t_timer > 0);
    if (t_timer == 100) t_timer = 0;
  }
}

//Some function I don't know
void _Error_Handler(char * file, int line){
  while(1) 
  {
  }
}

#ifdef USE_FULL_ASSERT

void assert_failed(uint8_t* file, uint32_t line)
{
}

#endif

