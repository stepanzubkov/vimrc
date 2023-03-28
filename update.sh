#!/bin/bash

VERSION=1.0

function help {
    echo "Usage: $0 [OPTIONS] (config_name) (repo_path)"
    echo "    Vim config updater, Version $VERSION" 
    echo "Options:"
    echo "    --editor, -e STRING       update config for specified editor (vim, nvim). Defaults to nvim."
    echo "    --no-update-scripts, -n   do not update .sh scripts from config directory"
    echo
}

update_scripts=1
editor=

function parse_args {
    case $1 in
        -e | --editor)
            editor=$2
            ;;
        -n | --no-update-scripts)
            update_scripts=
            ;;
        *)
            help
            exit 1
            ;;
    esac
}

while [[ "$#" -ge 4 ]]; do
    parse_args "$1" "$2"
    shift 2
done

if [[ $1 == --help ]]; then
    help
elif [[ -z $2 ]]; then
    echo "Repository is not specified" >&2
elif [[ ! -e $2 ]]; then
    echo "Repository is not found!" >&2
    exit 1
elif [[ ! -e $2/.git ]]; then
    echo "Specified repository is not git repository!" >&2
elif [[ -z "$2/$1" ]]; then
    echo "Config is not specified!" >&2
    exit 1
elif [[ ! -e "$2/$1" ]]; then
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

    echo "Updating config '$1' in '$2' repository"
    read -p "ATTENTION: Your current config in '$2/$1' will be lost! Continue? (y/n): " continue_install
    if [[ $continue_install != y ]]; then
        exit 1
    fi

    cp -r "$config_dir/*.vim" "$config_dir/*.lua" "$config_dir/lua" "$2/$1" &> /dev/null
    if [[ -n $update_scripts ]]; then
        echo "Updating .sh scripts from '$config_dir'"
        cp "$config_dir/update.sh" "$2"
    fi

    pushd "$2" > /dev/null
    git add .
    read -p "Git commit message: " git_commit_message
    git commit -m "$git_commit_message"
    git push
    popd > /dev/null
    echo "Your config was successfully updated!"
fi
