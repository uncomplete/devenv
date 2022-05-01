#!/usr/bin/env bash
set -eou pipefail

mkdir /tmp/folly-install
cd /tmp/folly-install
git clone https://github.com/facebook/folly
cd folly
cmake -S . -B bb
cmake --build bb
cmake --build bb --target install
cd /
rm -rf /tmp/folly-install
