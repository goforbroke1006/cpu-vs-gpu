//
// Created by goforbroke on 25.12.2020.
//

#include <cstdio>
#include "../init.h"

__global__ void initCalculation(float *buf, size_t n) {
    int i = threadIdx.x + blockIdx.x * blockDim.x;
    buf[i] = 1.0f * i / n;
    for (int j = 0; j < M; j++) { // fake addition load
        buf[i] = buf[i] * buf[i] - 0.25f;
    }
}

int main(int argc, char **argv) {
    size_t NSAMPLES = atoi(argv[1]);

    float data[NSAMPLES];
    float *d_data;
    cudaMalloc(&d_data, NSAMPLES * sizeof(float));
    initCalculation<<<NSAMPLES / 256, 256>>>(d_data, NSAMPLES);
    cudaMemcpy(data, d_data, NSAMPLES * sizeof(float), cudaMemcpyDeviceToHost);
    cudaFree(d_data);

//    int sel;
//    printf("Enter an index: ");
//    scanf("%d", &sel);
//    printf("data[%d] = %f\n", sel, data[sel]);

    int sel = 100;
    printf("data[%d] = %f\n", sel, data[sel]);
}
