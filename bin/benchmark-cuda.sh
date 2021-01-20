#!/bin/bash

set -e

EXECUTABLE="./"$(basename $1)
ARGUMENTS="${@:2}"
WORKING_DIR=$(dirname "$1")

# setup GPU as main graphic process
export DRI_PRIME=1

printf "\n\n---------- ---------- ---------- ---------- ----------\n"

echo "Date:        $(date +"%Y-%m-%d %H:%M:%S")"
echo "Executable:  ${EXECUTABLE}"
echo "Args:        ${ARGUMENTS}"
echo "Working dir: ${WORKING_DIR}"

printf "\n\n---------- ---------- ---------- ---------- ----------\n"

cd "${WORKING_DIR}"
ls

printf "\n\n---------- ---------- TIME ---------- ---------- ----------\n"

time "${EXECUTABLE}" ${ARGUMENTS}

#printf "\n\n---------- ---------- CUDA-MEMCHECK ---------- ---------- ----------\n"
#
#cuda-memcheck "${EXECUTABLE}" ${ARGUMENTS}

printf "\n\n---------- ---------- NVPROF ---------- ---------- ----------\n"

sudo /usr/local/cuda/bin/nvprof "${EXECUTABLE}" ${ARGUMENTS}
