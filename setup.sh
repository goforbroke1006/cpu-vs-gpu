#!/bin/bash

set -e

chmod +x ./bin/benchmark.sh
chmod +x ./bin/benchmark-cuda.sh

sudo apt update
sudo apt install valgrind kcachegrind graphviz

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

DRI_PRIME=1 nvidia-smi
if [[ $(nvidia-smi | grep -c 'Driver Version') -eq 0 ]]; then
  echo 'Something went wrong, nvidia-smi cant found suitable hardware or valid and enabled driver!'
  echo 'If you have NVIDIA card and driver, try to disable "Secure boot" in BIOS or leave enabled and switch it from "Deployed" to "Audit" mode.'
  exit 1
fi

sudo apt install build-essential
sudo apt -y install gcc-7 gcc-8
sudo apt -y install g++-7 g++-8 g++-9

if [[ ! -f /usr/local/cuda/bin/gcc ]]; then
  sudo ln -s /usr/bin/gcc-8 /usr/local/cuda/bin/gcc
fi

sudo cp /etc/sudoers /root/sudoers.bak
echo '========== !!! Copy next line and paste to "sudo visudo" !!! =========='
echo "${USER} ALL = NOPASSWD: /usr/local/cuda-10.0/bin/nvprof, /usr/local/cuda/bin/nvprof"
read -n 1 -s -r -p "Press any key to continue and open visudo"
sudo visudo
echo '========== !!! You have to restart computer !!! =========='
