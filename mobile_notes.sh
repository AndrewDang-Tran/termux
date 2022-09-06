#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

cd ~/storage/shared/obsidian-notes;
git add .;
git commit -m "Save mobile notes";
git push origin main;

