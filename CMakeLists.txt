cmake_minimum_required(VERSION 3.12)
project(cpu-vs-gpu)

set(CMAKE_CUDA_STANDARD 14)

add_subdirectory(samples/calculation/cuda)
add_subdirectory(samples/calculation/proc)

add_subdirectory(samples/vector-add/cuda)
add_subdirectory(samples/vector-add/proc)