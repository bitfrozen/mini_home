#!/bin/bash

rm -rf $HOME/.home
mkdir $HOME/.home
git -C $HOME/.home clone -b main --bare https://github.com/bitfrozen/mini_home .git
git --git-dir="${HOME}/.home/.git" --work-tree="${HOME}" reset --hard HEAD
