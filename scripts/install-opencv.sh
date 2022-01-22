#!/usr/bin/env bash
set -eou pipefail

#apt-get install -qy git make clang cmake pkg-config \
#    libavcodec-dev libavformat-dev libswscale-dev libgtk2.0-dev

git clone https://github.com/opencv/opencv.git
cmake -D CMAKE_BUILD_TYPE=Release -D BUILD_SHARED_LIBS=NO -S opencv -B build
cmake --build build -- -j 2
cmake --install build
rm -rf opencv build
