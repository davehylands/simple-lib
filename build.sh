#!/bin/sh
set -e
if [ "$1" == "--release" ]; then
  BUILD_TYPE="release"
  CARGO_ARGS="--release"
else
  BUILD_TYPE="debug"
fi
TARGET_DIR=target
rm -rf ${TARGET_DIR}
RUSTFLAGS="-Z embed-bitcode" cargo build -v ${CARGO_ARGS}

cd ${TARGET_DIR}/${BUILD_TYPE}
ar x libsimple_lib.a

for obj in *.o; do
  if otool -l ${obj} | grep bitcode > /dev/null ; then
    echo "${obj} has bitcode"
  else
    echo "${obj} DOES NOT have bitcode"
  fi
done
