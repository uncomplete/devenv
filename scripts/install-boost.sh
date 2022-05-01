#!/usr/bin/env bash
set -eou pipefail

mkdir /tmp/boost-install
cd /tmp/boost-install
wget -nv https://boostorg.jfrog.io/artifactory/main/release/1.77.0/source/boost_1_77_0.tar.bz2
tar --bzip2 -xf boost_1_77_0.tar.bz2
cd boost_1_77_0
mkdir _build
./bootstrap.sh
./b2 --build-dir=./_build cxxflags=-std=c++14 install
cd /
rm -rf /tmp/boost-install
