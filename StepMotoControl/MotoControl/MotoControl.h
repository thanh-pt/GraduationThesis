#ifndef __MOTOCONTROL_H_
#define __MOTOCONTROL_H_

//#ifdef __cplusplus
// extern "C" {
//#endif 
 /* Includes */
#include<stdbool.h> 
#include<stdint.h> 
#include "stm32f1xx_hal.h"
//#include "stdint.h"
//#include "stdlib.h"
//Define pin port of moto 1
#define m1_ENPort GPIOA
#define m1_1APort GPIOA
#define m1_2APort GPIOA
#define m1_ENPin GPIO_PIN_1
#define m1_1APin GPIO_PIN_0
#define m1_2APin GPIO_PIN_2
//define pin port of moto 2
#define m2_ENPort GPIOA
#define m2_2APort GPIOA
#define m2_1APort GPIOA
#define m2_ENPin GPIO_PIN_5
#define m2_1APin GPIO_PIN_4
#define m2_2APin GPIO_PIN_3
//define high and low
#define HighPin GPIO_PIN_SET
#define LowPin GPIO_PIN_RESET

void RunM1(void);
void RunM2(void);
void BackM1(void);
void BackM2(void);
void StopM1(void);
void StopM2(void);
void Run(void);
void Back(void);
void Stop(void);
void EnableM1(void);
void EnableM2(void);
void EnableM(void);
void DisableM1(void);
void DisableM2(void);
void DisableM(void);
void MotoControl(uint8_t angle, uint8_t dir);
#endif /* __MOTOCONTROL_H */
