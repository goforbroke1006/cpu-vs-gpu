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

int main() {
    float data[N];
    for (int i = 0; i < N; i++) {
        data[i] = 1.0f * i / N;
        for (int j = 0; j < M; j++) {
            data[i] = data[i] * data[i] - 0.25f;
        }
    }

//    int sel;
//    printf("Enter an index: ");
//    scanf("%d", &sel);
//    printf("data[%d] = %f\n", sel, data[sel]);

    int sel = 100;
    printf("data[%d] = %f\n", sel, data[sel]);
}
