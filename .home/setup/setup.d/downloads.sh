#!/bin/bash
set -e -x

cd "$(dirname "$0")"

. common.sh

download 'https://data.services.jetbrains.com/products/download?platform=linux&code=TBA' ~/.local/jetbrains-toolbox
