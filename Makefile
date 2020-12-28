NVPROF=/usr/local/cuda/bin/nvprof

.PHONY: all build benchmark

all: build calculation-cuda calculation-proc vector-add-cuda vector-add-proc

build:
	rm -rf ./build/ || true
	cmake -DCMAKE_BUILD_TYPE=Debug -B./build/ -S./
	cmake --build ./build/


calculation-cuda:
	./bin/benchmark-cuda.sh ./build/samples/calculation/cuda/calculation-cuda 256 2>&1 | tee calculation-cuda-2-8.log
	./bin/benchmark-cuda.sh ./build/samples/calculation/cuda/calculation-cuda 4096 2>&1 | tee calculation-cuda-2-12.log
	./bin/benchmark-cuda.sh ./build/samples/calculation/cuda/calculation-cuda 65536 2>&1 | tee calculation-cuda-2-16.log
	./bin/benchmark-cuda.sh ./build/samples/calculation/cuda/calculation-cuda 262144 2>&1 | tee calculation-cuda-2-18.log

calculation-proc:
	./bin/benchmark.sh ./build/samples/calculation/proc/calculation-proc 256 2>&1 | tee calculation-proc-2-8.log
	./bin/benchmark.sh ./build/samples/calculation/proc/calculation-proc 4096 2>&1 | tee calculation-proc-2-12.log
	./bin/benchmark.sh ./build/samples/calculation/proc/calculation-proc 65536 2>&1 | tee calculation-proc-2-16.log
	./bin/benchmark.sh ./build/samples/calculation/proc/calculation-proc 262144 2>&1 | tee calculation-proc-2-18.log

vector-add-cuda:
	./bin/benchmark-cuda.sh ./build/samples/vector-add/cuda/vector-add-cuda 256 2>&1 | tee vector-add-cuda-2-8.log
	./bin/benchmark-cuda.sh ./build/samples/vector-add/cuda/vector-add-cuda 4096 2>&1 | tee vector-add-cuda-2-12.log
	./bin/benchmark-cuda.sh ./build/samples/vector-add/cuda/vector-add-cuda 65536 2>&1 | tee vector-add-cuda-2-16.log
	./bin/benchmark-cuda.sh ./build/samples/vector-add/cuda/vector-add-cuda 262144 2>&1 | tee vector-add-cuda-2-18.log
	#./bin/benchmark-cuda.sh ./build/samples/vector-add/cuda/vector-add-cuda 16777216 2>&1 | tee vector-add-cuda-2-24.log
	#./bin/benchmark-cuda.sh ./build/samples/vector-add/cuda/vector-add-cuda 268435456 2>&1 | tee vector-add-cuda-2-28.log

vector-add-proc:
	./bin/benchmark.sh ./build/samples/vector-add/proc/vector-add-proc 256 2>&1 | tee vector-add-proc-2-8.log
	./bin/benchmark.sh ./build/samples/vector-add/proc/vector-add-proc 4096 2>&1 | tee vector-add-proc-2-12.log
	./bin/benchmark.sh ./build/samples/vector-add/proc/vector-add-proc 65536 2>&1 | tee vector-add-proc-2-16.log
	./bin/benchmark.sh ./build/samples/vector-add/proc/vector-add-proc 262144 2>&1 | tee vector-add-proc-2-18.log
	#./bin/benchmark.sh ./build/samples/vector-add/proc/vector-add-proc 16777216 2>&1 | tee vector-add-proc-2-24.log
	#./bin/benchmark.sh ./build/samples/vector-add/proc/vector-add-proc 268435456 2>&1 | tee vector-add-proc-2-28.log
