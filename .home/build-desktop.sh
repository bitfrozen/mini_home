#!/bin/bash
set -x -e
apt update
apt install -y ca-certificates curl gnupg2
rm -rf /etc/apt/sources.list.d/*
echo 'deb https://download.docker.com/linux/ubuntu jammy stable' >> /etc/apt/sources.list
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

export DEBIAN_FRONTEND=noninteractive

[ -e google-chrome.deb ] || curl -fL -o google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
[ -e code.deb ] || curl -fL -o code.deb 'https://az764295.vo.msecnd.net/stable/1a5daa3a0231a0fbba4f14db7ec463cf99d7768e/code_1.84.2-1699528352_amd64.deb'

# shellcheck disable=SC2046
apt install -y $(sort -u packages) ./*.deb
apt update -y
apt upgrade -y
apt autopurge -y

echo 'fs.inotify.max_user_watches = 524288' > /etc/sysctl.d/99-goland.conf
echo 'module.nf_conntrack.parameters.hashsize = 131072' > /etc/sysctl.d/99-hashsize.conf

if ! grep -q docker /etc/group; then groupadd -r docker; fi
if ! id devops; then useradd -m -s /bin/bash -G sudo,docker,tty,adm devops; fi
if ! id devops | grep -q docker; then usermod -aG docker devops; fi

rm -- *.deb
