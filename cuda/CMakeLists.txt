project(sample-cuda CUDA)

add_executable(${PROJECT_NAME} main.cu ../init.h)

set_target_properties(
        ${PROJECT_NAME}
        PROPERTIES
        CUDA_SEPARABLE_COMPILATION ON)