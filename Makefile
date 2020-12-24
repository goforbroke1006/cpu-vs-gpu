.PHONY: all build benchmark

all: build benchmark

build:
	cmake -DCMAKE_BUILD_TYPE=Debug -B./build/ -S./
	cmake --build ./build/ --target sample-cuda sample-proc

benchmark:
	echo '--------------------------------------------------'
	time ./build/cuda/sample-cuda
	echo '--------------------------------------------------'
	time ./build/proc/sample-proc