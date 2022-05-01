#!/usr/bin/env bash
set -eou pipefail

mkdir /tmp/gsuite-install
cd /tmp/gsuite-install

# double-conversion
git clone https://github.com/google/double-conversion.git
cd double-conversion
cmake -S . -B build
cmake --build build
cmake --build build --target install
cd ..
rm -rf double-conversion

# glog
git clone https://github.com/google/glog.git
cd glog
cmake -S . -B build
cmake --build build
cmake --build build --target install
cd ..
rm -rf glog

# Googletest
git clone https://github.com/google/googletest.git
cd googletest
cmake -S . -B build
cmake --build build
cmake --build build --target install
cd ..
rm -rf googletest

# fmt::fmt
git clone https://github.com/fmtlib/fmt.git
cd fmt
cmake -S . -B build
cmake --build build
cmake --build build --target install
cd ..
rm -rf fmt

cd /
rm -rf /tmp/gsuite-install
