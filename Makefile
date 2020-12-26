.PHONY: all build benchmark

all: build benchmark

build:
	#rm -rf ./build/ || true
	cmake -DCMAKE_BUILD_TYPE=Debug -B./build/ -S./
	cmake --build ./build/ --target \
		calculation-cuda calculation-proc \
		vector-add-cuda vector-add-proc

benchmark:
	echo '--------------------------------------------------'
	time ./build/samples/calculation/cuda/calculation-cuda
	echo '--------------------------------------------------'
	time ./build/samples/calculation/proc/calculation-proc
	echo '--------------------------------------------------'
	time ./build/samples/vector-add/cuda/vector-add-cuda
	echo '--------------------------------------------------'
	time ./build/samples/vector-add/proc/vector-add-proc

profiling:
	echo '--------------------------------------------------'
	sudo /usr/local/cuda/bin/nvprof ./build/samples/calculation/cuda/calculation-cuda
	echo '--------------------------------------------------'
	sudo /usr/local/cuda/bin/nvprof ./build/samples/vector-add/cuda/vector-add-cuda
