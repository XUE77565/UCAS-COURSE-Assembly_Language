#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N 4096
#define BLOCK 128  // 经验值，视cache大小调整

void matrixmultiply(int n, int **A, int **B, int **C) {
    for (int ii = 0; ii < n; ii += BLOCK)
        for (int jj = 0; jj < n; jj += BLOCK)
            for (int kk = 0; kk < n; kk += BLOCK)
                for (int i = ii; i < ii + BLOCK && i < N; ++i)
                    for (int j = jj; j < jj + BLOCK && j < N; ++j) {
                        int sum = 0;
                        for (int k = kk; k < kk + BLOCK && k < N; ++k)
                            sum += A[i][k] * B[k][j];
                        C[i][j] += sum;
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
    clock_t start = clock();
    matrixmultiply(N, A, B, C);
    clock_t end = clock();
    printf("blocking time: %.2f seconds\n", (double)(end - start) / CLOCKS_PER_SEC);
    // 释放内存
    for (int i = 0; i < N; ++i) {
        free(A[i]); free(B[i]); free(C[i]);
    }
    free(A); free(B); free(C);
}