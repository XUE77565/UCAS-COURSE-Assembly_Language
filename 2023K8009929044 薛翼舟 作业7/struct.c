#include<stdio.h>

struct test {
    int a;
    float b;
    double c;
    short d;
    long e;
    float f;
    int g;
    double h;
    char i;
    long long j;
};

void process_struct(struct test cs) {
    cs.a = 100;
    cs.b = 3.14f;
    // 修改结构体成员
}

int main() {
    struct test s = {
        1, 2.0f, 3.0, 4, 5, 6.0f, 7, 8.0, '9', 10
    };
    process_struct(s);
    return 0;
}