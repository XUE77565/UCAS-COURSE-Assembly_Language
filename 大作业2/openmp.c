#include <omp.h>
#include <stdio.h>
#include <stdlib.h>

#define N 4096

void matrixmultiply(int n, int **A, int **B, int **C) {
    #pragma omp parallel for
    for (int i = 0; i < n; ++i)
        for (int j = 0; j < n; ++j) {
            int sum = 0;
            for (int k = 0; k < n; ++k)
                sum += A[i][k] * B[k][j];
            C[i][j] = sum;
        }
}

int main() {
    int **A = malloc(N * sizeof(int*));
    int **B = malloc(N * sizeof(int*));
    int **C = malloc(N * sizeof(int*));
    for (int i = 0; i < N; ++i) {
        A[i] = malloc(N * sizeof(int));
        B[i] = malloc(N * sizeof(int));
        C[i] = malloc(N * sizeof(int));
        for (int j = 0; j < N; ++j) {
            A[i][j] = rand() % 10;
            B[i][j] = rand() % 10;
        }
    }
    double start = omp_get_wtime();
    matrixmultiply(N, A, B, C);
    double end = omp_get_wtime();
    printf("OpenMP time: %.2f seconds\n", end - start);
    // 释放内存
    for (int i = 0; i < N; ++i) {
        free(A[i]); free(B[i]); free(C[i]);
    }
    free(A); free(B); free(C);
}