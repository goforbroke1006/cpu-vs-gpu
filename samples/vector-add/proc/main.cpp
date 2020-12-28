//
// Created by goforbroke on 26.12.2020.
//

#include <cstdlib>

void vector_add(float *out, float *a, float *b, int n) {
    for (int load = 0; load < n; load++) { // fake addition load
        for (int i = 0; i < n; i++) {
            out[i] = a[i] + b[i];
        }
    }
}

int main(int argc, char **argv) {
    size_t NSAMPLES = atoi(argv[1]);

    float *a, *b, *out;

    // Allocate memory
    a = (float *) malloc(sizeof(float) * NSAMPLES);
    b = (float *) malloc(sizeof(float) * NSAMPLES);
    out = (float *) malloc(sizeof(float) * NSAMPLES);

    // Initialize array
    for (int i = 0; i < NSAMPLES; i++) {
        a[i] = 1.0f;
        b[i] = 2.0f;
    }

    // Main function
    vector_add(out, a, b, NSAMPLES);

    return 0;
}