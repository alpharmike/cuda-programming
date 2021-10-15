
#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>
#include <stdlib.h>

__global__ void unique_gid_calc_3d(int* data) {
	
	int blockId = blockIdx.x + blockIdx.y * gridDim.x + blockIdx.z * gridDim.x * gridDim.y;
	int globalThreadId = blockId * (blockDim.x * blockDim.y * blockDim.z) + threadIdx.y * blockDim.x + threadIdx.z * (blockDim.x * blockDim.y) + threadIdx.x;

	printf("blockIdx.x: %d, blockIdx.y: %d, blockIdx.z, gid: %d, value: %d\n", blockIdx.x, blockIdx.y, blockIdx.z, globalThreadId, data[globalThreadId]);
}



//int main() {
//	
//	const int array_size = 64;
//	int array_byte_size = array_size * sizeof(int);
//	int* h_data = (int *) malloc(array_byte_size);
//
//	for (int i = 0; i < array_size; ++i) {
//		h_data[i] = i;
//	}
//
//	int* d_data;
//	cudaMalloc((void**)&d_data, array_byte_size);
//	cudaMemcpy(d_data, h_data, array_byte_size, cudaMemcpyHostToDevice);
//
//
//
//	dim3 block(2, 2, 2);
//	dim3 grid(2, 2, 2);
//	unique_gid_calc_3d << <grid, block >> > (d_data);
//
//	cudaDeviceSynchronize();
//
//	cudaFree(d_data);
//	free(h_data);
//
//	cudaDeviceReset();
//
//	return 0;
//
//}
