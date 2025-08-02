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

struct test create_struct() {
    struct test cs = {
        100, 3.14f, 2.718, 4, 5, 6.28f, 7, 1.414, 'X', 1000
    };
    return cs;
}

int main() {
    struct test s = create_struct();
    return 0;
}