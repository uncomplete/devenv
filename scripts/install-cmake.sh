#!/usr/bin/env bash
set -eou pipefail

mkdir /tmp/cmake-install
cd /tmp/cmake-install
wget "https://cmake.org/files/v3.20/cmake-3.20.5-linux-x86_64.tar.gz"
tar xzf cmake-3.20.5-linux-x86_64.tar.gz -C /usr/local --strip-components=1
cd /
rm -rf /tmp/cmake-install
