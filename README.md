# Zsh Configuration

Zshrc files are contained in dotfiles - zshrc contains aliases, ezshrc contains
complicated prompt and oh-my-zsh related things.

Either use the dotfiles/setup.sh script or sym-link them yourself using:  
```
devenv $> ln -s ${PWD}/dotfiles/zshrc ${HOME}/.zshrc
```

# Development Docker Containers

A docker-contained development environment based on Ubuntu 20.04 and Vim. Modern
clang and python development tools are installed as well as language servers and
vim-compatible clients.

Inspired by [this great repo](https://github.com/mmorse1217/terraform) among
others.

## Building

Build the development container with:

```devenv$> docker build --tag devenv:latest --file Dockerfile.vim . ```

## Using

Use the container by running it with your source code mounted as a volume:

```src$> docker run --rm -it -v ${PWD}:/src devenv:latest```

## Vim

We use the latest Vim master branch and Vim 8's default package management
features. Packages are maintained in a separate
[repo](https://github.com/uncomplete/devpacks) as submodules.

Coc.nvim is used as the base language-server-client in vim. Plugins for Coc can
be added by editing the vimrc file.

* check vim compile options with ```:version```

## C++

The full LLVM-project release is included in the development image. This
includes the clang compilers, which are used by default for compiling tools in
the image, and the clangd language server which is by default used for
development in vim.

## Python

For Python we use Ubuntu 20.04's default python3 apt-get packages
(Python 3.8.10). We use Jedi as a language-server for Python.

## To-Do

* Make a lightweight version for use as a default vim editor
* Use alias


## Python

Use these notebooks for quick python work: `https://github.com/jupyter/docker-stacks/blob/main/images/docker-stacks-foundation/Dockerfile`  

```
$> docker build --rm --tag jupyter:latest .
```

Store your API keys as env variables.  

```
docker run -it --rm \
    -p 8888:8888 \
    --user root \
    -e NB_USER=$(whoami) \
    -e NB_UID=$(id -u) \
    -e NB_GID=$(id -g) \
    -e CHOWN_HOME=yes \
    -e CHOWN_HOME_OPTS="-R" \
    -e BLS_API_KEY="${BLS_API_KEY}" \
    -e FRED_API_KEY="${FRED_API_KEY}" \
    -e PG_API_KEY="${PG_API_KEY}" \
    -e BEA_API_KEY="${BEA_API_KEY}" \
    -e FH_API_KEY="${FH_API_KEY}" \
    -e E_API_KEY="${E_API_KEY}" \
    -e E_API_SECRET="${E_API_SECRET}" \
    -w "/home/$(whoami)" \
    -v "${PWD}":/home/$(whoami) \
    jupyter:latest
```
