//有多种降低CPE的办法, 比如利用SIMD一次处理多个元素, 比如利用循环展开
//未加速的函数如下
// void *basic_memset(void *s, int c, size_t n) {
//     size_t cnt = 0;
//     unsigned char *schar = s;
//     while (cnt < n) {
//         *schar++ = (unsigned char)c;
//         cnt++;
//     }
//     return s;
// }
//这个是一个一个操作, CPE很高, 于是, 可以采用循环展开, 比如4个4个

#include <stddef.h>
#include <stdint.h>

void *turbo_memset(void *s, int c, size_t n) {
    size_t i = 0;
    unsigned char *schar = (unsigned char *)s;
    uint64_t pattern = (unsigned char)c;
    pattern |= pattern << 8;
    pattern |= pattern << 16;
    pattern |= pattern << 32;

    // 先填充到8字节对齐
    while (((uintptr_t)(schar + i) % 8 != 0) && i < n) {
        schar[i++] = (unsigned char)c;
    }

    // 8字节块填充, 8个8个填充, 循环展开减少循环次数
    uint64_t *s64 = (uint64_t *)(schar + i);
    size_t n64 = (n - i) / 8;
    for (size_t j = 0; j < n64; ++j) {
        s64[j] = pattern;
    }
    i += n64 * 8;

    // 处理剩下不足8字节的部分
    while (i < n) {
        schar[i++] = (unsigned char)c;
    }
    return s;
}
