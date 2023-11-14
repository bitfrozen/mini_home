#!/bin/bash
set -x -e
apt update
apt install -y ca-certificates curl gnupg2
rm -rf /etc/apt/sources.list.d/*
echo 'deb http://us.archive.ubuntu.com/ubuntu mantic main universe restricted' > /etc/apt/sources.list
echo 'deb http://us.archive.ubuntu.com/ubuntu mantic-updates main universe restricted' >> /etc/apt/sources.list
echo 'deb http://us.archive.ubuntu.com/ubuntu mantic-security main universe restricted' >> /etc/apt/sources.list
echo 'deb http://us.archive.ubuntu.com/ubuntu mantic-backports main universe restricted' >> /etc/apt/sources.list
echo 'APT::Install-Recommends "false";' > /etc/apt/apt.conf.d/02norecommends
echo 'APT::Install-Suggests "false";' >> /etc/apt/apt.conf.d/02norecommends
echo 'APT::Get::Install-Recommends "false";' >> /etc/apt/apt.conf.d/02norecommends
echo 'APT::Get::Install-Suggests "false";' >> /etc/apt/apt.conf.d/02norecommends
echo 'deb https://download.docker.com/linux/ubuntu mantic stable' >> /etc/apt/sources.list
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

export DEBIAN_FRONTEND=noninteractive

if [ -x /usr/local/sbin/unminimize ]; then yes | unminimize; fi
apt update -y
apt upgrade -y
apt-mark auto $(apt-mark showmanual)
apt-mark manual xubuntu-desktop
apt install -y software-properties-common curl

[ -e google-chrome.deb ] || curl -fL -o google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
[ -e code.deb ] || curl -fL -o code.deb 'https://az764295.vo.msecnd.net/stable/1a5daa3a0231a0fbba4f14db7ec463cf99d7768e/code_1.84.2-1699528352_amd64.deb'

apt install -y $(cat packages | sort -u) ./*.deb
apt update -y
apt upgrade -y
apt autopurge -y

echo 'fs.inotify.max_user_watches = 524288' > /etc/sysctl.d/99-goland.conf
echo 'module.nf_conntrack.parameters.hashsize = 131072' > /etc/sysctl.d/99-hashsize.conf

if ! grep -q docker /etc/group; then groupadd -r docker; fi
if ! id devops; then useradd -m -s /bin/bash -G sudo,docker,tty,adm devops; fi

rm *.deb
