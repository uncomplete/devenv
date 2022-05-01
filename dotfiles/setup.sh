#!/bin/bash

MY_PATH="`dirname \"$0\"`"
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"

function link_dotfile {
    dest="${HOME}/.${1}"
    dateStr=$(date +%Y-%m-%d-%H%M)

    if [ -h "${dest}" ]; then
        # Existing symlink 
        echo "Removing existing symlink: ${dest}"
        rm ${dest} 

    elif [ -f "${dest}" ]; then
        # Existing file
        echo "Backing up existing file: ${dest}"
        mv ${dest}{,.${dateStr}}

    elif [ -d "${dest}" ]; then
        # Existing dir
        echo "Backing up existing dir: ${dest}"
        mv ${dest}{,.${dateStr}}
    fi

    echo "Creating new symlink: ${dest}"
    ln -s ${MY_PATH}/${1} ${dest}
}



echo "symlinking .zshrc..."
link_dotfile zshrc

echo "symlinking .ezshrc..."
link_dotfile ezshrc
