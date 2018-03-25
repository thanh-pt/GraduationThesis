//this is c code

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

void Stop(void){
	StopM1();
	StopM2();
}
