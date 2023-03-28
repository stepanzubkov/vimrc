#!/bin/bash
VERSION=1.0

function help {
    echo "Usage: $0 (config_name) [OPTIONS]"
    echo "    Vim config installer, Version $VERSION" 
    echo "Options:"
    echo "    --editor, -e STRING        install config for specified editor (vim, nvim). Defaults to nvim."
    echo "    --no-install-scripts, -n   do not install .sh scripts to config directory"
    echo
}

editor=
install_scripts=1

function parse_args {
    case $1 in
        -e | --editor)
            editor=$2
            ;;
        -n | --no-install-scripts)
            install_scripts=
            ;;
        *)
            help
            exit 1
            ;;
    esac
}

while [[ "$#" -ge 3 ]]; do
    parse_args "$1" "$2"
    shift 2
done


if [[ $1 == --help ]]; then
    help
elif [[ -z $1 ]]; then
    echo "Config is not specified!" >&2
    exit 1
elif [[ ! -e $1 ]]; then
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

    echo "Installing config '$1' to '$config_dir'"
    read -p "ATTENTION: Your current config in $config_dir' will be lost! Continue? (y/n): " continue_install
    if [[ $continue_install != y ]]; then
        exit 1
    fi

    rm -rf "$config_dir/*.lua" "$config_dir/*.vim" "$config_dir/lua"
    cp -r "$1"/* "$config_dir"

    if [[ -n $install_scripts ]]; then
        echo "Installing .sh scripts to '$config_dir'"
        cp "update.sh" "$config_dir/update.sh"
    fi


    echo "Config '$1' was successfuly installed!"
fi

