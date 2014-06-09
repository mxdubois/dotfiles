#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory 
# to any desired dotfiles in ~/dotfiles
# adapted from: http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/
############################

########## Variables

# dotfiles directory
CWD=$(pwd)
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
gitdir=$( cd $DIR;git rev-parse --show-toplevel )
dir=$gitdir/src                   
# old dotfiles backup directory
olddir=$CWD/dotfiles_old             
# list of files/folders to symlink in homedir
files="bashrc vimrc vim gitignore gitconfig tmux.conf"    

##########

# create dotfiles_old in cwd
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in cwd to dotfiles_old directory, 
# then create symlinks 
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv $CWD/.$file $olddir/ 
    echo "Creating symlink to $dir/$file in home directory."
    ln -s $dir/$file $CWD/.$file
done
