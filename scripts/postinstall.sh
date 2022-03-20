#!/bin/sh

# only run as root
if (($(id -u) == 0)); then
    echo "user is root"
else
    echo "you must run this script as root"
    exit
fi

SCRIPT_DIR=$(dirname $(readlink -f "$0"))

# create default user
# (sudo will need a password later, this is userful for the installer)
echo "creating user"
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >/etc/sudoers.d/wheel
chmod 440 /etc/sudoers.d/wheel
useradd -mG wheel -s /usr/bin/zsh diak -p '$6$nI/Ya5wm4s9xzbWL$3bmSK4Y.vqFnxDQCof.sMlDmnNHzh/7pUGUoJO9RUu4l9ZA.De/MebzGCDBP9iiJ0y1NHYfORX2D.APIbjnlx1'

# copy base home directory
echo "copying base home directory"
sudo -u diak cp -rvLT "$SCRIPT_DIR/../home/" "/home/diak/"

echo "installing packages"
# pacman setup
pacman-key --init && pacman-key --populate
# generate mirrorlist
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.old
echo 'Server = https://cloudflaremirrors.com/archlinux/$repo/os/$arch' >/etc/pacman.d/mirrorlist
# install some packages
pacman -Syu --noconfirm --needed \
    autoconf \
    automake \
    binutils \
    bison \
    file \
    findutils \
    flex \
    gawk \
    gcc \
    gettext \
    grep \
    groff \
    gzip \
    libtool \
    m4 \
    make \
    pacman \
    patch \
    pkgconf \
    sed \
    sudo \
    texinfo \
    which \
    man-db \
    man-pages \
    curl \
    wget \
    git \
    openssh \
    vim \
    nano \
    neofetch \
    htop \
    python \
    python2 \
    python-pip \
    bind-tools \
    tree \
    github-cli \
    zsh \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    zsh-history-substring-search \
    starship

# run user script
echo "running user script"
sudo -u diak bash "$SCRIPT_DIR/userspace.sh"

# sudo requires password
echo "%wheel ALL=(ALL) ALL" >/etc/sudoers.d/wheel
chmod 440 /etc/sudoers.d/wheel

# clear the pacman cache
echo "clearing the pacman cache ($(du -h /var/cache/pacman/pkg | awk '{print $1}'))"
pacman --noconfirm -Scc
rm /var/cache/pacman/pkg/*

echo "post-install script completed"
