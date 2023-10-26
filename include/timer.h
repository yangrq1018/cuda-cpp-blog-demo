#ifndef TIMER_H
#define TIMER_H

#include <string>
#include <iostream>
#include <chrono>

class Timer
{
private:
    std::chrono::steady_clock::time_point begin;
    std::string_view func_name;

public:
    Timer(std::string_view func)
    {
        func_name = func;
        begin = std::chrono::steady_clock::now();
    }
    ~Timer()
    {
        const std::chrono::steady_clock::time_point end = std::chrono::steady_clock::now();
        std::cout << func_name << " time: "
                  << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count()
                  << " microseconds " << std::endl;
    }
};

#endif // TIMER_H