#include "MotoControl.h"

void RunM1(void){
  HAL_GPIO_WritePin(m1_1APort,m1_1APin,LowPin);
  HAL_GPIO_WritePin(m1_2APort,m1_2APin,HighPin);
}

void RunM2(void){
  HAL_GPIO_WritePin(m2_1APort,m2_1APin,LowPin);
  HAL_GPIO_WritePin(m2_2APort,m2_2APin,HighPin);
}

void BackM1(void){
  HAL_GPIO_WritePin(m1_1APort,m1_1APin,HighPin);
  HAL_GPIO_WritePin(m1_2APort,m1_2APin,LowPin);
}
void BackM2(void){
  HAL_GPIO_WritePin(m2_1APort,m2_1APin,HighPin);
  HAL_GPIO_WritePin(m2_2APort,m2_2APin,LowPin);
}

void StopM1(void){
  HAL_GPIO_WritePin(m1_1APort,m1_1APin,LowPin);
  HAL_GPIO_WritePin(m1_2APort,m1_2APin,LowPin);
}

void StopM2(void){
  HAL_GPIO_WritePin(m2_1APort,m1_1APin,LowPin);
  HAL_GPIO_WritePin(m2_2APort,m1_2APin,LowPin);
}

void Run(void){
  RunM1();
  RunM2();
}

void Back(void){
  BackM1();
  BackM2();
}

void Stop(void){
  StopM1();
  StopM2();
}

void EnableM1(void){
  HAL_GPIO_WritePin(m1_ENPort,m1_ENPin,HighPin);
}

void EnableM2(void){
  HAL_GPIO_WritePin(m2_ENPort,m2_ENPin,HighPin);
}

void EnableM(void){
  EnableM1();
  EnableM2();
}

void DisableM1(void){
  HAL_GPIO_WritePin(m1_ENPort,m1_ENPin,LowPin);
}

void DisableM2(void){
  HAL_GPIO_WritePin(m2_ENPort,m2_ENPin,LowPin);
}

void DisableM(void){
  DisableM1();
  DisableM2();
}
/*
* angle:
* dir <0: stand; 1: Go; 2: Back; 3: Left; 4: Right>
*/
void MotoControl(double m_ang, uint8_t dir){
  double controlAngle;
  switch (dir){
    case 0:
      controlAngle = 0;
    break;
    case 1:
      controlAngle = 0.5;
    break;
    case 2:
      controlAngle = -0.5;
    break;
  }
  if(m_ang > controlAngle){
      RunM1();
      RunM2();
    }else{
      BackM1();
      BackM2();
    }
}
void InterruptMoto(bool isOn){
  if (isOn) EnableM();
  else DisableM();
}

