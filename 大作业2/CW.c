#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#define N       4096
#define THRESHOLD 64  // 小于此尺寸时用普通乘法

void classic_multiply(int n, int **A, int **B, int **C) {
    for (int i=0; i<n; ++i)
        for (int j=0; j<n; ++j)
            for (int k=0; k<n; ++k)
                C[i][j] += A[i][k] * B[k][j];
}

void add(int n, int **A, int **B, int **C) {
    for (int i=0; i<n; ++i)
        for (int j=0; j<n; ++j)
            C[i][j] = A[i][j] + B[i][j];
}

void sub(int n, int **A, int **B, int **C) {
    for (int i=0; i<n; ++i)
        for (int j=0; j<n; ++j)
            C[i][j] = A[i][j] - B[i][j];
}

void strassen(int n, int **A, int **B, int **C) {
    if (n <= THRESHOLD) {
        classic_multiply(n, A, B, C);
        return;
    }
    int k = n/2;
    // Allocate submatrices
    int **A11 = malloc(k*sizeof(int*));
    int **A12 = malloc(k*sizeof(int*));
    int **A21 = malloc(k*sizeof(int*));
    int **A22 = malloc(k*sizeof(int*));
    int **B11 = malloc(k*sizeof(int*));
    int **B12 = malloc(k*sizeof(int*));
    int **B21 = malloc(k*sizeof(int*));
    int **B22 = malloc(k*sizeof(int*));
    int **C11 = malloc(k*sizeof(int*));
    int **C12 = malloc(k*sizeof(int*));
    int **C21 = malloc(k*sizeof(int*));
    int **C22 = malloc(k*sizeof(int*));
    for (int i=0; i<k; ++i) {
        A11[i] = A[i];
        A12[i] = A[i] + k;
        A21[i] = A[i+k];
        A22[i] = A[i+k] + k;
        B11[i] = B[i];
        B12[i] = B[i] + k;
        B21[i] = B[i+k];
        B22[i] = B[i+k] + k;
        C11[i] = C[i];
        C12[i] = C[i] + k;
        C21[i] = C[i+k];
        C22[i] = C[i+k] + k;
    }
    // Allocate temp matrices
    int **M1 = malloc(k*sizeof(int*));
    int **M2 = malloc(k*sizeof(int*));
    int **M3 = malloc(k*sizeof(int*));
    int **M4 = malloc(k*sizeof(int*));
    int **M5 = malloc(k*sizeof(int*));
    int **M6 = malloc(k*sizeof(int*));
    int **M7 = malloc(k*sizeof(int*));
    int **T1 = malloc(k*sizeof(int*));
    int **T2 = malloc(k*sizeof(int*));
    for (int i=0; i<k; ++i) {
        M1[i] = calloc(k, sizeof(int));
        M2[i] = calloc(k, sizeof(int));
        M3[i] = calloc(k, sizeof(int));
        M4[i] = calloc(k, sizeof(int));
        M5[i] = calloc(k, sizeof(int));
        M6[i] = calloc(k, sizeof(int));
        M7[i] = calloc(k, sizeof(int));
        T1[i] = calloc(k, sizeof(int));
        T2[i] = calloc(k, sizeof(int));
    }
    // M1 = (A11 + A22)*(B11 + B22)
    add(k, A11, A22, T1);
    add(k, B11, B22, T2);
    strassen(k, T1, T2, M1);
    // M2 = (A21 + A22)*B11
    add(k, A21, A22, T1);
    strassen(k, T1, B11, M2);
    // M3 = A11*(B12 - B22)
    sub(k, B12, B22, T2);
    strassen(k, A11, T2, M3);
    // M4 = A22*(B21 - B11)
    sub(k, B21, B11, T2);
    strassen(k, A22, T2, M4);
    // M5 = (A11 + A12)*B22
    add(k, A11, A12, T1);
    strassen(k, T1, B22, M5);
    // M6 = (A21 - A11)*(B11 + B12)
    sub(k, A21, A11, T1);
    add(k, B11, B12, T2);
    strassen(k, T1, T2, M6);
    // M7 = (A12 - A22)*(B21 + B22)
    sub(k, A12, A22, T1);
    add(k, B21, B22, T2);
    strassen(k, T1, T2, M7);
    // C11 = M1 + M4 - M5 + M7
    for (int i=0; i<k; ++i)
        for (int j=0; j<k; ++j)
            C11[i][j] = M1[i][j] + M4[i][j] - M5[i][j] + M7[i][j];
    // C12 = M3 + M5
    for (int i=0; i<k; ++i)
        for (int j=0; j<k; ++j)
            C12[i][j] = M3[i][j] + M5[i][j];
    // C21 = M2 + M4
    for (int i=0; i<k; ++i)
        for (int j=0; j<k; ++j)
            C21[i][j] = M2[i][j] + M4[i][j];
    // C22 = M1 - M2 + M3 + M6
    for (int i=0; i<k; ++i)
        for (int j=0; j<k; ++j)
            C22[i][j] = M1[i][j] - M2[i][j] + M3[i][j] + M6[i][j];
    // Free allocated memory
    for (int i=0; i<k; ++i) {
        free(M1[i]); free(M2[i]); free(M3[i]); free(M4[i]);
        free(M5[i]); free(M6[i]); free(M7[i]);
        free(T1[i]); free(T2[i]);
    }
    free(A11); free(A12); free(A21); free(A22);
    free(B11); free(B12); free(B21); free(B22);
    free(C11); free(C12); free(C21); free(C22);
    free(M1); free(M2); free(M3); free(M4); free(M5); free(M6); free(M7);
    free(T1); free(T2);
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
    strassen(N, A, B, C);
    clock_t end = clock();
    printf("SW: %.2f seconds\n", (double)(end - start) / CLOCKS_PER_SEC);
    // 释放内存
    for (int i = 0; i < N; ++i) {
        free(A[i]); free(B[i]); free(C[i]);
    }
    free(A); free(B); free(C);
}