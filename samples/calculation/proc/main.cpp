//
// Created by goforbroke on 25.12.2020.
//

#include <cstdio>
#include <cstdlib>
#include "../init.h"

int main(int argc, char **argv) {
    size_t NSAMPLES = atoi(argv[1]);

    float data[NSAMPLES];
    for (int i = 0; i < NSAMPLES; i++) {
        data[i] = 1.0f * i / NSAMPLES;
        for (int j = 0; j < M; j++) { // fake addition load
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
