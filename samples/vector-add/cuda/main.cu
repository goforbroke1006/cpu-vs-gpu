//
// Created by goforbroke on 26.12.2020.
//

#include <iostream>
#include <cstdlib>
#include <cuda_profiler_api.h>

__global__ void vector_add(float *out, float *a, float *b, int n) {
    size_t index = threadIdx.x;
    size_t stride = blockDim.x;

    for (int load = index; load < n; load += stride) { // fake addition load
        for (int i = index; i < n; i += stride) {
            out[i] = a[i] + b[i];
        }
    }
}

int main(int argc, char **argv) {
    size_t NSAMPLES = atoi(argv[1]);

    float *a, *b, *out;
    float *d_a, *d_b, *d_out;

    // Allocate memory
    a = (float *) malloc(sizeof(float) * NSAMPLES);
    b = (float *) malloc(sizeof(float) * NSAMPLES);
    out = (float *) malloc(sizeof(float) * NSAMPLES);

    cudaMalloc((void **) &d_a, sizeof(float) * NSAMPLES);
    cudaMalloc((void **) &d_b, sizeof(float) * NSAMPLES);
    cudaMalloc((void **) &d_out, sizeof(float) * NSAMPLES);

    // Initialize array
    for (long i = 0; i < NSAMPLES; i++) {
        a[i] = 1.0f;
        b[i] = 2.0f;
    }

    cudaMemcpy(d_a, a, sizeof(float) * NSAMPLES, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, sizeof(float) * NSAMPLES, cudaMemcpyHostToDevice);

    vector_add<<<256, 256>>>(d_out, d_a, d_b, NSAMPLES);

    cudaError_t err = cudaGetLastError();  // add
    if (err != cudaSuccess)
        std::cout << "CUDA error: " << cudaGetErrorString(err) << std::endl; // add
    cudaProfilerStop();

    cudaMemcpy(out, d_out, sizeof(float) * NSAMPLES, cudaMemcpyDeviceToHost);

    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_out);

    free(a);
    free(b);
    free(out);
}