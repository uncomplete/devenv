#!/bin/bash
set -eou pipefail


git clone https://github.com/vim/vim.git
pushd vim
./configure --with-features=huge \
            --enable-multibyte \
            --enable-python3interp=yes \
            --disable-gui \
            --enable-cscope \
            --prefix=/usr/local
make
make install
popd
rm -rf vim
