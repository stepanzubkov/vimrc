#!/bin/bash
VERSION=1.0
config_name=$1

function help {
    echo "Usage: ./install.sh config_name [OPTIONS]"
    echo "    Vim config installer, Version $VERSION" 
    echo "Options:"
    echo "    --editor, -e STRING   install config for specified editor (vim, nvim). Defaults to nvim."
    echo
}

function parse_args {
    case $1 in
        -e | --editor)
            editor=$2
            ;;
        *)
            help
            exit 1
            ;;
    esac
}

while [[ "$#" -ge 3 ]]; do
    parse_args "$2" "$3"
    shift 2
done


if [[ $config_name == --help ]]; then
    help
elif [[ -z $config_name ]]; then
    echo "Config is not specified!" >&2
    exit 1
elif [[ ! -e $config_name ]]; then
    echo "Config is not found!" >&2
    exit 1
else
    if [[ $editor == vim ]]; then
        config_dir="$HOME/.vim/"
    elif [[ $editor == nvim || -z $editor ]]; then
        config_dir="$HOME/.config/nvim/"
    else
        echo "Invalid editor! Editor can be in (nvim, vim)" >&2
        exit 1
    fi

    echo "Installing config '$config_name' to '$config_dir'"
    read -p "ATTENTION: Your current config in '$config_name' will be lost! Continue? (y/n): " continue_install
    if [[ $continue_install != y ]]; then
        exit 1
    fi

    rm -rf $config_dir/*.lua $config_dir/*.vim $config_dir/lua
    cp -r $config_name/* $config_dir

    echo "Config '$config_name' was successfuly installed!"
fi

