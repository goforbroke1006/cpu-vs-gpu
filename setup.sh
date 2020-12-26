#!/bin/bash

set -e

command_exists() {
  # check if command exists and fail otherwise
  command -v "$1" >/dev/null 2>&1
  if [[ $? -ne 0 ]]; then
    echo "I require $1 but it's not installed. Abort."
    exit 1
  fi
}

command_exists nvcc
command_exists nvidia-smi

nvcc -V
if [[ $(nvcc -V | grep -c 'NVIDIA') -eq 0 ]]; then
  echo 'CUDA is not installed!!!'
  exit 1
fi

nvidia-smi
if [[ $(nvidia-smi | grep -c 'Driver Version') -eq 0 ]]; then
  echo 'Something went wrong, nvidia-smi cant found suitable hardware or valid and enabled driver!'
  echo 'If you have NVIDIA card and driver, try to disable "Secure boot" in BIOS or leave enabled and switch it from "Deployed" to "Audit" mode.'
  exit 1
fi

sudo apt install build-essential
sudo apt -y install gcc-7 gcc-8
sudo apt -y install g++-7 g++-8 g++-9

sudo ln -s /usr/bin/gcc-8 /usr/local/cuda/bin/gcc

sudo setcap cap_sys_admin+ep /usr/local/cuda-10.1/bin/nvprof
