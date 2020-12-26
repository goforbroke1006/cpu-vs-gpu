//
// Created by goforbroke on 26.12.2020.
//

#include <cstdlib>

#include "../init.h"

__global__ void vector_add(float *out, float *a, float *b, int n) {
    for (int i = 0; i < n; i++) {
        out[i] = a[i] + b[i];
    }
}

int main() {
    float *a, *b, *out;
    float *d_a, *d_b;

    // Allocate memory
    a = (float *) malloc(sizeof(float) * N);
    b = (float *) malloc(sizeof(float) * N);
    out = (float *) malloc(sizeof(float) * N);

    cudaMalloc((void **) &d_a, sizeof(float) * N);
    cudaMalloc((void **) &d_b, sizeof(float) * N);

    // Initialize array
    for (int i = 0; i < N; i++) {
        a[i] = 1.0f;
        b[i] = 2.0f;
    }

    cudaMemcpy(d_a, a, sizeof(float) * N, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, sizeof(float) * N, cudaMemcpyHostToDevice);

    // Main function
    vector_add<<<256, 256>>>(out, d_a, d_b, N);

    cudaFree(d_a);
    cudaFree(d_b);
    free(a);
}