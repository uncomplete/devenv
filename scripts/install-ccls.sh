#!/usr/bin/env bash
set -eou pipefail

git clone --depth=1 --recursive https://github.com/MaskRay/ccls
pushd ccls
cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release
cmake --build Release
pushd Release
make install
popd
popd
rm -rf ccls
