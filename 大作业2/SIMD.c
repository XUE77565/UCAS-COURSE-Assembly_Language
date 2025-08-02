#include <immintrin.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <omp.h>

#define N 4096

void matrixmultiply(int n, float **A, float **B, float **C) {
    #pragma omp parallel for
    for (int i = 0; i < n; ++i)
        for (int j = 0; j < n; ++j) {
            __m256 sum = _mm256_setzero_ps();
            for (int k = 0; k < N; k += 8) {
                __m256 a = _mm256_loadu_ps(&A[i][k]);
                __m256 b = _mm256_loadu_ps(&B[k][j]);
                sum = _mm256_fmadd_ps(a, b, sum);
            }
            float tmp[8];
            _mm256_storeu_ps(tmp, sum);
            float total = 0;
            for (int x = 0; x < 8; ++x) total += tmp[x];
            C[i][j] = total;
        }
}

int main() {
    float **A = (float**)malloc(N * sizeof(float*));
    float **B = (float**)malloc(N * sizeof(float*));
    float **C = (float**)malloc(N * sizeof(float*));
    for (int i = 0; i < N; ++i) {
        A[i] = (float*)malloc(N * sizeof(float));
        B[i] = (float*)malloc(N * sizeof(float));
        C[i] = (float*)calloc(N, sizeof(float));
        for (int j = 0; j < N; ++j) {
            A[i][j] = (float)(rand() % 10);
            B[i][j] = (float)(rand() % 10);
        }
    }
    clock_t start = clock();
    matrixmultiply(N, A, B, C);
    clock_t end = clock();
    printf("SIMD time: %.2f seconds\n", (double)(end - start) / CLOCKS_PER_SEC);

    for (int i = 0; i < N; ++i) {
        free(A[i]); free(B[i]); free(C[i]);
    }
    free(A); free(B); free(C);

    return 0;
}
