#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

cd ~/.termux/tasker/termux;
git pull origin master;

cp ~/.termux/tasker/termux/*.sh ../;
