//
// Created by goforbroke on 25.12.2020.
//

//#include <iostream>
//
//int main() {
//    std::cout << "Hello, World!" << std::endl;
//    return 0;
//}

#include <cstdio>

#include "../init.h"

__global__ void initCalculation(float *buf) {
    int i = threadIdx.x + blockIdx.x * blockDim.x;
    buf[i] = 1.0f * i / N;
    for (int j = 0; j < M; j++)
        buf[i] = buf[i] * buf[i] - 0.25f;
}

int main() {
    float data[N];
    float *d_data;
    cudaMalloc(&d_data, N * sizeof(float));
    initCalculation<<<N / 256, 256>>>(d_data);
    cudaMemcpy(data, d_data, N * sizeof(float), cudaMemcpyDeviceToHost);
    cudaFree(d_data);

//    int sel;
//    printf("Enter an index: ");
//    scanf("%d", &sel);
//    printf("data[%d] = %f\n", sel, data[sel]);

    int sel = 100;
    printf("data[%d] = %f\n", sel, data[sel]);
}
