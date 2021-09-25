FROM ubuntu:20.04 as base

RUN apt-get update && apt-get -y upgrade

RUN apt-get install -y locales
RUN locale-gen en_US.UTF-8  
ENV LANG=en_US.UTF-8  
ENV LANGUAGE=en_US:en  
ENV LC_ALL=en_US.UTF-8

ENV DEBIAN_FRONTEND=noninteractive
# Clang requirements
RUN apt-get install -qqy --no-install-recommends \
        ca-certificates \ 
        dpkg-dev file make patch \
        libc-dev libc++-dev libgcc-9-dev libstdc++-9-dev  \
        dirmngr gnupg wget curl lbzip2 xz-utils libtinfo5 zlib1g-dev && \
    ln -s /usr/lib/x86_64-linux-gnu/libtinfo.so.6.2 /usr/lib/x86_64-linux-gnu/libtinfo.so

# Install Clang and LLVM
# Version info
ENV LLVM_RELEASE 12
ENV LLVM_VERSION 12.0.0
COPY scripts/install-llvm.sh .
RUN bash install-llvm.sh && \
    ln /usr/local/bin/clang /usr/local/bin/cc

# Vim requirements
RUN apt-get install -y --force-yes \
        python3-dev \
        git

# Install vim
COPY scripts/install-vim.sh .
RUN bash install-vim.sh

# Install Nodejs
COPY scripts/install-nodejs.sh .
RUN bash install-nodejs.sh

# CCLS requirements
RUN apt-get install -y \
        cmake

# Build/Install ccls
COPY scripts/install-ccls.sh .
RUN bash install-ccls.sh

# Add python packages
RUN apt-get install -y python3-pip && \
    python3 -m pip install -U pip && \
    python3 -m pip install -U wheel setuptools && \
    python3 -m pip install -U numpy matplotlib && \
    python3 -m pip install -U jedi-language-server pylint && \
    python3 -m pip install -U notebook

WORKDIR /root

COPY scripts/setup-vim.sh .
RUN bash setup-vim.sh

# add a vimrc file
COPY dotfiles/vimrc /root/.vimrc
COPY dotfiles/coc-settings.json /root/.vim/

RUN mkdir -p /root/.config/coc

WORKDIR /src
