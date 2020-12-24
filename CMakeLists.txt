cmake_minimum_required(VERSION 3.12)
project(cpu-vs-gpu)

set(CMAKE_CUDA_STANDARD 14)

add_subdirectory(cuda)
add_subdirectory(proc)