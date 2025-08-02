import numpy as np
import time

N = 4096
A = np.random.randint(0, 10, (N, N), dtype=np.int32)
B = np.random.randint(0, 10, (N, N), dtype=np.int32)
C = np.zeros((N, N), dtype=np.int32)

start = time.time()
for i in range(N):
    for j in range(N):
        for k in range(N):
            C[i, j] += A[i, k] * B[k, j]
end = time.time()
print("Python naive time:", end - start)