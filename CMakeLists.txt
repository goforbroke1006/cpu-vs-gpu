cmake_minimum_required(VERSION 3.12)
project(cpu-vs-gpu)

set(CMAKE_CUDA_STANDARD 14)

set(CMAKE_CXX_FLAGS "-pg ${CMAKE_CXX_FLAGS}")
set(CMAKE_EXE_LINKER_FLAGS "-pg ${CMAKE_EXE_LINKER_FLAGS}")
set(CMAKE_SHARED_LINKER_FLAGS "-pg ${CMAKE_SHARED_LINKER_FLAGS}")

add_subdirectory(samples/calculation/cuda)
add_subdirectory(samples/calculation/proc)

add_subdirectory(samples/vector-add/cuda)
add_subdirectory(samples/vector-add/proc)