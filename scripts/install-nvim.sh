#!/bin/bash

# Install neovim
git clone --branch=release-0.5 --depth=1 https://github.com/neovim/neovim.git
pushd neovim
make CMAKE_BUILD_TYPE=Release \
     CMAKE_INSTALL_PREFIX=/usr/local \
  install \
popd
rm -rf neovim
