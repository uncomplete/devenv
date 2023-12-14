# syntax=docker/dockerfile:1
FROM ubuntu:latest as base

RUN apt-get update --fix-missing && \
    apt-get -y upgrade && \
    apt-get install -y locales && \
    locale-gen en_US.UTF-8  
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    DEBIAN_FRONTEND=noninteractive

RUN apt-get install -qqy --no-install-recommends \
        ca-certificates \
        dpkg-dev \
        libncurses-dev \
        clang-12 clangd-12 \
        make cmake \
        wget curl \
        git \
        python3-dev python3-pip \
        libevent-dev libssl-dev \
        && \
    ln -s /usr/bin/clang-12 /usr/bin/clang && \
    ln -s /usr/bin/clang++-12 /usr/bin/clang++ && \
    ln -s /usr/bin/clangd-12 /usr/bin/clangd
        #libtinfo5 \
    #ln -s /usr/lib/aarch64-linux-gnu/libtinfo.so.6.2 /usr/lib/aarch64-linux-gnu/libtinfo.so && \

ENV CC=clang CXX=clang++

# Add python packages
RUN python3 -m pip install -U pip && \
    python3 -m pip install -U wheel setuptools && \
    python3 -m pip install -U numpy matplotlib pylint notebook

COPY scripts/install-vim.sh /installscripts/install-vim.sh
RUN  bash /installscripts/install-vim.sh
COPY scripts/install-nodejs.sh /installscripts/install-nodejs.sh
RUN  bash /installscripts/install-nodejs.sh
COPY scripts/setup-vim.sh /installscripts/setup-vim.sh
RUN  bash /installscripts/setup-vim.sh

# add a vimrc file
COPY dotfiles/vimrc.extra /root/.vimrc
COPY dotfiles/coc-settings.json /root/.vim/
COPY templates/ /root/.vim/templates/

### C++ packages
COPY scripts/install-git-repo-w-cmake.sh /installscripts/install-git-repo-w-cmake.sh
RUN bash /installscripts/install-git-repo-w-cmake.sh -u https://github.com/google/double-conversion.git
RUN bash /installscripts/install-git-repo-w-cmake.sh -u https://github.com/gflags/gflags.git
RUN bash /installscripts/install-git-repo-w-cmake.sh -u https://github.com/google/glog.git
RUN bash /installscripts/install-git-repo-w-cmake.sh -b release-1.11.0 -u https://github.com/google/googletest.git
RUN bash /installscripts/install-git-repo-w-cmake.sh -u https://github.com/fmtlib/fmt.git
RUN bash /installscripts/install-git-repo-w-cmake.sh -u https://github.com/google/flatbuffers.git
RUN bash /installscripts/install-git-repo-w-cmake.sh -b v2.13.8 -u https://github.com/catchorg/Catch2.git

COPY scripts/install-boost.sh /installscripts/install-boost.sh
RUN bash /installscripts/install-boost.sh
RUN bash /installscripts/install-git-repo-w-cmake.sh -b main -u https://github.com/facebook/folly.git

##

RUN mkdir -p /root/.config/coc && \
    rm -rf /installscripts

WORKDIR /src
