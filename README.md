# Development Docker Containers

A docker-contained development environment based on Ubuntu 20.04 and Vim. Modern clang and python development tools are installed as well as language servers and vim-compatible clients.

Inspired by [this great repo](https://github.com/mmorse1217/terraform) among others.

## Building

Build the development container with:

```devenv$> docker build --tag devenv:latest --file Dockerfile.vim . ```

## Using

Use the container by running it with your source code mounted as a volume:

```src$> docker run -it -v ${PWD}:/src devenv:latest```

## Vim

We use the latest Vim master branch and Vim 8's default package management features. Packages are maintained in a separate [repo](https://github.com/uncomplete/devpacks) as submodules.

Coc.nvim is used as the base language-server-client in vim. Plugins for Coc can be added by editing the vimrc file.

* check vim compile options with ```:version```

## C++

The full LLVM-project release is included in the development image. This includes the clang compilers, which are used by default for compiling tools in the image, and the clangd language server which is by default used for development in vim.

## Python

For Python we use Ubuntu 20.04's default python3 apt-get packages (Python 3.8.10). We use Jedi as a language-server for Python.