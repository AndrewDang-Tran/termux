#! /data/data/com.termux/files/usr/bin/bash

TERMUX_HOME=$(cd ..; pwd)

set -e

inform () {
    printf "  [ \033[00;34m..\033[0m ] $1"
}

user () {
    printf "\r  [ \033[0;33m?\033[0m ] $1 "
}

success () {
    printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
    printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
    echo ''
    exit
}

update () {
    local folder=$1
    inform "update $folder"
    cd $(folder)
    git pull origin master
    cd ..
}

update_scripts () {
    inform 'updating scripts'
    for folder in $(find "$TERMUX_HOME/" -maxdepth 1)
    do
        update folder
    done
}

replace_scripts () {
    inform "replacing scripts"
    for src in $(find "$TERMUX_HOME/" -maxdepth 3 -name '*.py')
    do
        dst="$home/.termux/tasker/$(basename "$src%.*")"
        mv "$src $dst"
    done
}

setup () {
    inform "setup $TERMUX_HOME"
    update_scripts
    replace_scripts
}

setup
