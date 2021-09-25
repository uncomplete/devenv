# Development Docker Containers

A docker-contained development environment based on ubuntu 18.04 and vim. Both vim- and neovim-based images are provided. Both have modern clang and python development tools installed as well as language servers and vim-compatible clients.

Inspired by [this great repo.](https://github.com/mmorse1217/terraform)

## Building

Build the development container with:

```devenv$> docker build --tag devenv:latest . ```

## Using

Use the container by running it with your source code mounted as a volume:

```src$> docker run -it -v ${PWD}:/home/quser/src devenv:latest```

## NeoVim

We use the NeoVim fork, vim-plug for plugin management, and the coc.vim language server client plugin.

* check compile options with ```:version```


## C++

For the C++ language server we use CCLS (other option is clangd).

## Python

For Python we use Palantir's python-language-server.