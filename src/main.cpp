#include <iostream>
#include <math.h>
#include "add.h"
#include "timer.h"

int main(void)
{
    int N = 1 << 20; // 1M elements
    float *x = new float[N];
    float *y = new float[N];
    // initialize x and y arrays on the host
    for (int i = 0; i < N; i++)
    {
        x[i] = 1.0f;
        y[i] = 2.0f;
    }

    {
        Timer timer{"add"};
        add(N, x, y);
    }
    // Check for errors (all values should be 3.0f)
    float maxError = 0.0f;
    for (int i = 0; i < N; i++)
        maxError = fmax(maxError, fabs(y[i] - 3.0f));
    std::cout << "Max error: " << maxError << std::endl;

    delete[] x;
    delete[] y;
    return 0;
}
