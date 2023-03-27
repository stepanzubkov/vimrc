#!/bin/bhsh

VERSION=1.0

function help {
    echo "Usage: $0 [OPTIONS] (config_name) (repo_path)"
    echo "    Vim config updater, Version $VERSION" 
    echo "Options:"
    echo "    --editor, -e STRING     update config for specified editor (vim, nvim). Defaults to nvim."
    echo
}

function parse_args {
    case $1 in
        -e | --editor)
            editor=$2
            ;;
        -r | --repo-path)
            repo_path=$2
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
elif [[ -z $2/$1 ]]; then
    echo "Config is not specified!" >&2
    exit 1
elif [[ ! -e $2/$1 ]]; then
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

    cp -r $config_dir/*.vim $config_dir/*.lua $config_dir/lua $2/$1 &> /dev/null
    cd $2/$1
    git add .
    read -p "Git commit message: " git_commit_message
    git commit -m "$git_commit_message"
    git push > /dev/null
    cd -
    echo "Your config was successfully updated!"
fi
