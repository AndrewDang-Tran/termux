#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

if [ $1 == "push" ]
    cd ~/storage/shared/obsidian-notes;
    git add .;
    git commit -m "Save mobile notes";
    git push origin main;
fi

if [ $1 == "pull" ]
    cd ~/storage/shared/obsidian-notes;
    git pull origin main;
fi

