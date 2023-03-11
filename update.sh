#!/bin/bash

cp ~/.config/nvim/init.vim init.vim
git add .
read -p "Commit message: " commit_msg
git commit -m "$commit_msg"
git push
