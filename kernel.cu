
#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>

__global__ void kernel_func() {
	printf("gridIdx: %d, gridIdy: %d, gridIdz: %d, blockIdx: %d, blockIdy: %d, blockIdz: %d, threadIdx: %d, threadIdy: %d, threadIdz: %d\n", gridDim.x, gridDim.y, gridDim.z, blockIdx.x, blockIdx.y, blockIdx.z, threadIdx.x, threadIdx.y, threadIdx.z);
}

//int main() {
//	dim3 grid(2, 2, 1);
//	dim3 block(4, 2, 1);
//
//	kernel_func <<<grid, block>>>();
//
//	cudaDeviceSynchronize();
//
//	cudaDeviceReset();
//
//	return 0;
//
//}
