FROM ubuntu:20.04 as base

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
        libtinfo5 \
        clang-12 clangd-12 \
        make cmake \
        wget curl \
        git \
        python3-dev python3-pip \
        && \
    ln -s /usr/lib/x86_64-linux-gnu/libtinfo.so.6.2 /usr/lib/x86_64-linux-gnu/libtinfo.so && \
    ln -s /usr/bin/clang-12 /usr/bin/clang && \
    ln -s /usr/bin/clang++-12 /usr/bin/clang++ && \
    ln -s /usr/bin/clangd-12 /usr/bin/clangd

COPY scripts/* /installscripts/

ENV CC=clang CXX=clang++
RUN bash /installscripts/install-vim.sh && \
    bash /installscripts/install-nodejs.sh && \
    bash /installscripts/setup-vim.sh

# Add python packages
RUN python3 -m pip install -U pip && \
    python3 -m pip install -U wheel setuptools && \
    python3 -m pip install -U numpy matplotlib && \
    python3 -m pip install -U jedi-language-server pylint && \
    python3 -m pip install -U notebook

# add a vimrc file
COPY dotfiles/vimrc /root/.vimrc
COPY dotfiles/coc-settings.json /root/.vim/
COPY templates/ /root/.vim/templates/
RUN mkdir -p /root/.config/coc && \
    rm -rf /installscripts

WORKDIR /src
