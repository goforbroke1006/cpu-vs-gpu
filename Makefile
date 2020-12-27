NVPROF=/usr/local/cuda/bin/nvprof

.PHONY: all build benchmark

all: build calculation-cuda calculation-proc vector-add-cuda vector-add-proc

build:
	rm -rf ./build/ || true
	cmake -DCMAKE_BUILD_TYPE=Debug -B./build/ -S./
	cmake --build ./build/


calculation-cuda: benchmark/calculation-cuda memcheck/calculation-cuda profiling/calculation-cuda
calculation-proc: benchmark/calculation-proc profiling/calculation-proc
vector-add-cuda: benchmark/vector-add-cuda memcheck/vector-add-cuda profiling/vector-add-cuda
vector-add-proc: benchmark/vector-add-proc profiling/vector-add-proc

benchmark/calculation-cuda:
	echo '--------------------------------------------------'
	time ./build/samples/calculation/cuda/calculation-cuda

benchmark/calculation-proc:
	echo '--------------------------------------------------'
	time ./build/samples/calculation/proc/calculation-proc

benchmark/vector-add-cuda:
	echo '--------------------------------------------------'
	time ./build/samples/vector-add/cuda/vector-add-cuda

benchmark/vector-add-proc:
	echo '--------------------------------------------------'
	time ./build/samples/vector-add/proc/vector-add-proc

memcheck/calculation-cuda:
	echo '--------------------------------------------------'
	cuda-memcheck ./build/samples/calculation/cuda/calculation-cuda

memcheck/vector-add-cuda:
	echo '--------------------------------------------------'
	cuda-memcheck ./build/samples/vector-add/cuda/vector-add-cuda

profiling/calculation-cuda:
	echo '--------------------------------------------------'
	sudo $(NVPROF) ./build/samples/calculation/cuda/calculation-cuda

profiling/calculation-proc:
	echo '--------------------------------------------------'
	valgrind --tool=callgrind ./build/samples/calculation/proc/calculation-proc

profiling/vector-add-cuda:
	echo '--------------------------------------------------'
	sudo $(NVPROF) ./build/samples/vector-add/cuda/vector-add-cuda

.ONESHELL:
profiling/vector-add-proc:
	echo '--------------------------------------------------'
	strace -c ./build/samples/vector-add/proc/vector-add-proc
	ltrace -c ./build/samples/vector-add/proc/vector-add-proc
	gprof -p -b ./build/samples/vector-add/proc/vector-add-proc ./build/samples/vector-add/proc/gmon.out
	#
	./build/samples/vector-add/proc/vector-add-proc
	mv ./gmon.out ./build/samples/vector-add/proc/gmon.out
	valgrind --tool=callgrind --dump-instr=yes --simulate-cache=yes --collect-jumps=yes --callgrind-out-file=./build/samples/vector-add/proc/vector-add-proc.cgout ./build/samples/vector-add/proc/vector-add-proc
	#kcachegrind ./build/samples/vector-add/proc/vector-add-proc.cgout
