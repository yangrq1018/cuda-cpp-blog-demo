#include <iostream>
#include "timer.h"

// Kernel function to add the elements of two arrays
__global__ void _add(int n, float *x, float *y)
{
    int index = blockIdx.x * blockDim.x + threadIdx.x;
    int stride = blockDim.x * gridDim.x;
    for (int i = index; i < n; i += stride)
        y[i] = x[i] + y[i];
}

void add(int n, float *x, float *y)
{
    float *temp_x, *temp_y;
    cudaMalloc(&temp_x, n * sizeof(float));
    cudaMalloc(&temp_y, n * sizeof(float));

    // copy input to device memory
    cudaMemcpy(temp_x, x, n * sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(temp_y, y, n * sizeof(float), cudaMemcpyHostToDevice);

    // Run kernel on 1M elements on the GPU
    int blockSize = 256;
    int numBlocks = (n + blockSize - 1) / blockSize; // round up in case N is not a multiple of blockSize

    {
        Timer timer("kernel");
        _add<<<numBlocks, blockSize>>>(n, temp_x, temp_y);
    }

    // Wait for GPU to finish before accessing on host
    cudaDeviceSynchronize();

    // copy result back
    cudaMemcpy(y, temp_y, n * sizeof(float), cudaMemcpyDeviceToHost);

    // Free memory
    cudaFree(temp_x);
    cudaFree(temp_y);
}