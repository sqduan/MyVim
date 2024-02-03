#!/bin/bash

# This is the installation script to install the essential
# requirements for my vim configuration, if you don't mind,
# you can directly use this as your personal vim configuration
# as well, it based on the everforest color scheme and added
# some commonly used plugins for development, I hope you enjoy
# this configuration repo ^-^

# Install the Everforest color scheme
git submodule init
git submodule update

# Folders to place the everforest color scheme
destination_folders=(
    "$HOME/.vim/autoload/"
    "$HOME/.vim/colors/"
    "$HOME/.vim/autoload/airline/themes/"
    "$HOME/.vim/autoload/lightline/colorscheme/"
    "$HOME/.vim/doc/"
)

# Check if the destination folder exists, if not, create
for folder in "${destination_folders[@]}"; do
    if [ ! -d "$folder" ]; then
        mkdir -p "$folder"
    fi
done

cp ./everforest/autoload/everforest.vim  ~/.vim/autoload/
cp ./everforest/colors/everforest.vim    ~/.vim/colors/
cp ./everforest/autoload/airline/themes/everforest.vim ~/.vim/autoload/airline/themes/
cp ./everforest/autoload/lightline/colorscheme/everforest.vim ~/.vim/autoload/lightline/colorscheme/

# copy & generate help tags
cp ./everforest/doc/everforest.txt      ~/.vim/doc/
vim -c 'helptags ~/.vim/doc/' -c 'qa!'

# Install the font, here I choose Fira Code as our default
# program font
if pacman -Qs ttf-fira-code >/dev/null 2>&1; then
    echo "Fira Code font package is installed."
else
    echo "Fira Code font package is not installed."
    sudo pacman -S ttf-fira-code
fi

# Now install the vim configuration
vimrc_file="$HOME/.vimrc"
timestamp=$(date +%Y%m%d%H%M%S)
backup_file="$HOME/.vimrc_backup_$timestamp"

if [ -f "$vimrc_file" ]; then
    mv "$vimrc_file" "$backup_file"
fi

# Install the vim awesome configuration
cp -r ./vimrc ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

#----------------------------------------------------------------
# Plug-in installation
#----------------------------------------------------------------
# Install the vim plugin manager
plug_manager="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
if [ ! -f ~/.vim/autoload/plug.vim ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs $plug_manager
fi

