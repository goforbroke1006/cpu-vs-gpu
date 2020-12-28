#!/bin/bash

set -e

EXECUTABLE="./"$(basename $1)
ARGUMENTS="${@:2}"
WORKING_DIR=$(dirname "$1")

printf "\n\n---------- ---------- ---------- ---------- ----------\n"

echo "Date:        $(date +"%Y-%m-%d %H:%M:%S")"
echo "Executable:  ${EXECUTABLE}"
echo "Args:        ${ARGUMENTS}"
echo "Working dir: ${WORKING_DIR}"

printf "\n\n---------- ---------- ---------- ---------- ----------\n"

cd "${WORKING_DIR}"
rm -f gmon.out callgrind.out
ls

printf "\n\n---------- ---------- TIME ---------- ---------- ----------\n"

time "${EXECUTABLE}" ${ARGUMENTS}

printf "\n\n---------- ---------- STRACE ---------- ---------- ----------\n"

strace -c "${EXECUTABLE}" ${ARGUMENTS}

printf "\n\n---------- ---------- LTRACE ---------- ---------- ----------\n"

ltrace -c "${EXECUTABLE}" ${ARGUMENTS}

printf "\n\n---------- ---------- PROFILE ---------- ---------- ----------\n"

eval "${EXECUTABLE} ${ARGUMENTS}"
gprof -p -b "${EXECUTABLE}" ./gmon.out

#printf "\n\n---------- ---------- VALGRID ---------- ---------- ----------\n"

#valgrind --tool=callgrind \
#  --dump-instr=yes \
#  --simulate-cache=yes \
#  --collect-jumps=yes \
#  --callgrind-out-file=./callgrind.out \
#  "${EXECUTABLE}" ${ARGUMENTS}

#while true; do
#  read -r -p "Do you wish to run debug ingo visualization tool [Y/N]?" yn
#  case $yn in
#  [Yy]*) kcachegrind ./callgrind.out ;;
#  [Nn]*) exit ;;
#  *) echo "Please answer yes or no." ;;
#  esac
#done
