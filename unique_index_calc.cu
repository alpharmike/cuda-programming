
#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>

__global__ void unique_index_calc(int* data) {
	int tid = threadIdx.x;
	printf("threadIdx: %d, value: %d\n", tid, data[tid]);
}

__global__ void unique_gid_calc(int* data) {
	int tid = threadIdx.x;
	int block_offset = blockIdx.x * blockDim.x;
	int gid = tid + block_offset;
	printf("threadIdx: %d, gid: %d, value: %d\n", tid, gid, data[gid]);
}

__global__ void unique_gid_calc_2d(int* data) {
	// Note we have only one thread in y-dim for each block
	int tid = threadIdx.x;
	int block_offset = blockIdx.x * blockDim.x;
	int row_offset = gridDim.x * blockDim.x * blockIdx.y;
	int gid = tid + block_offset + row_offset;
	printf("blockIdx.x: %d, blockIdx.y: %d, threadIdx: %d, gid: %d, value: %d\n", blockIdx.x, blockIdx.y, tid, gid, data[gid]);
}

__global__ void unique_gid_calc_2d_extended(int* data) {
	int tid = threadIdx.x + threadIdx.y * blockDim.x;
	int num_threads_per_block = blockDim.x * blockDim.y;
	int block_offset = blockIdx.x * num_threads_per_block;
	int number_threads_per_row = num_threads_per_block * gridDim.x;
	int row_offset = number_threads_per_row * blockIdx.y;
	int gid = tid + block_offset + row_offset;
	printf("blockIdx.x: %d, blockIdx.y: %d, threadIdx: %d, gid: %d, value: %d\n", blockIdx.x, blockIdx.y, tid, gid, data[gid]);
}



//int main() {
//	
//	const int array_size = 16;
//	int host_data[array_size] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 };
//	int array_byte_size = array_size * sizeof(int);
//	int* device_data;
//	cudaMalloc((void**)&device_data, array_byte_size);
//	cudaMemcpy(device_data, host_data, array_byte_size, cudaMemcpyHostToDevice);
//
//
//	/*dim3 block(8);
//	dim3 grid(1);
//	unique_index_calc << <grid, block >> > (device_data);*/
//
//	/*dim3 block(4);
//	dim3 grid(2);
//	unique_gid_calc << <grid, block >> > (device_data);*/
//
//	/*dim3 block(4, 1);
//	dim3 grid(2, 2);
//	unique_gid_calc_2d << <grid, block >> > (device_data);*/
//
//	dim3 block(2, 2);
//	dim3 grid(2, 2);
//	unique_gid_calc_2d_extended << <grid, block >> > (device_data);
//
//	cudaDeviceSynchronize();
//
//	cudaDeviceReset();
//
//	return 0;
//
//}
