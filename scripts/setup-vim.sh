#!/bin/bash
set -eou pipefail

vim_dir="${HOME}/.vim"

echo "${vim_dir}"

mkdir -p ${vim_dir}
mkdir -p $vim_dir/undodir

cd $vim_dir
git clone --recursive https://github.com/uncomplete/devpacks.git ${vim_dir}/pack
