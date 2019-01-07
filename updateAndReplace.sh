#!/usr/bin/env bash

#I assume that this is in $HOME/workspace/termux/
TERMUX_HOME=$(cd ../..; pwd)

set -e

inform () {
    printf "  [ \033[00;34m..\033[0m ] $1\n"
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

check_clean () {
    if [ -z "$(git status --porcelain)" ]; then 
        return "true"
    else 
        return "false"
    fi
}

update () {
    local folder=$1
    inform "about to update $folder"
    cd "$folder"
    local clean=check_clean
    if [ clean == "true" ]
    then
        git pull origin master
    else
        pwd
        #fail "skipped $folder due to unclean status"
    fi
    cd ..
    success "updated $folder"
}

update_scripts () {
    inform 'updating scripts'
    for folder in $(find "$TERMUX_HOME/workspace/" -maxdepth 1 -name '*')
    do
        if [ "$folder" != "$TERMUX_HOME/workspace/" ]
        then
            update "$folder"
        fi
    done
    success 'updated all scripts'
}

replace_scripts () {
    inform "about to replacing scripts"
    for src in $(find "$TERMUX_HOME/workspace/" -maxdepth 3 -name '*.py')
    do
        inform "about to move $src"
        dst="$TERMUX_HOME/.termux/tasker/$(basename "${src%.*}").py"
        cp "$src" "$dst"
        success "copied $src to $dst"
    done
    success 'replaced all scripts'
}

setup () {
    inform "setup $TERMUX_HOME"
    update_scripts
    replace_scripts
    success 'finished setup'
}

setup
