
#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>

__global__ void kernel_exercise() {
	printf("gridX: %d, gridY: %d, gridZ: %d, blockIdx: %d, blockIdy: %d, blockIdz: %d, threadIdx: %d, threadIdy: %d, threadIdz: %d\n", gridDim.x, gridDim.y, gridDim.z, blockIdx.x, blockIdx.y, blockIdx.z, threadIdx.x, threadIdx.y, threadIdx.z);
}

//int main() {
//	int nx = 4;
//	int ny = 4;
//	int nz = 4;
//
//	dim3 block(2, 2, 2);
//	dim3 grid(nx / 2, ny / 2, nz / 2);
//
//	kernel_exercise << <grid, block >> > ();
//
//	cudaDeviceSynchronize();
//
//	cudaDeviceReset();
//
//	return 0;
//
//}
