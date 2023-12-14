#!/usr/bin/env bash
set -eou pipefail

mkdir /tmp/sodium-install
cd /tmp/sodium-install
git clone --depth 1 --branch v2023.01.23.00 https://github.com/facebook/wangle.git 
cd wangle
./build/fbcode_builder/getdeps.py install-system-deps --recursive wangle
./build/fbcode_builder/getdeps.py --allow-system-packages --install-prefix /usr/local build wangle
