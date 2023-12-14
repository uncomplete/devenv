#!/usr/bin/env bash
set -eou pipefail

mkdir /tmp/zstd-install
cd /tmp/zstd-install
git clone --depth 1 --branch zstd-0.4.2 https://github.com/facebook/zstd.git
cd zstd
make && make install
cd /
rm -rf /tmp/zstd-install
