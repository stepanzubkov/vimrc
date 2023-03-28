# Vimrc
My *neovim* and *vim* configs.

`nvim_old` - Old neovim config in Vimscript

`nvim_lua` - Neovim config in lua

To install one of this configs:

```bash
git clone git@github.com:stepan-zubkov/vimrc.git
cd vimrc/
chmod +x install.sh
./install.sh (config_name)
# For vim
# ./install.sh -e vim (config_name)
```

Also see `./install.sh --help`

To update config in repository:

```bash
chmod +x update.sh
./update.sh (сonfig_name) (repo_path)
# For vim
# ./update.sh -e vim (config_name) (repo_path)
```

You can move `update.sh` script to any directory you want. `update.sh` script by default copied to vim config dir by `install.sh` script.

Also see `./update.sh --help`

