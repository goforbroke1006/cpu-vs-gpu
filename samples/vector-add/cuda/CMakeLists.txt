project(vector-add-cuda CUDA)

add_executable(${PROJECT_NAME} main.cu)

set_target_properties(
        ${PROJECT_NAME}
        PROPERTIES
        CUDA_SEPARABLE_COMPILATION ON)
