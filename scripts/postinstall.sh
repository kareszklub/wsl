#!/bin/sh

# only run as root
if (($(id -u) == 0)); then
    echo "user is root"
else
    echo "you must run this script as root"
    exit
fi

SCRIPT_DIR=$(dirname $(readlink -f "$0"))
COUNTRY_CODE=$(curl -sL ipinfo.io/country)

# create default user
# (sudo will need a password later, this is userful for the installer)
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >/etc/sudoers.d/wheel
useradd -mG wheel -s /bin/bash diak -p '$6$nI/Ya5wm4s9xzbWL$3bmSK4Y.vqFnxDQCof.sMlDmnNHzh/7pUGUoJO9RUu4l9ZA.De/MebzGCDBP9iiJ0y1NHYfORX2D.APIbjnlx1'

# pacman setup
pacman-key --init && pacman-key --populate

# generate mirrorlist
pacman -Sy --noconfirm reflector
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.old
reflector -c $COUNTRY_CODE -p https --sort rate --save /etc/pacman.d/mirrorlist

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
    python2-pip

# run user script
sudo -u diak bash "$SCRIPT_DIR/userspace.sh"

# sudo requires password
echo "%wheel ALL=(ALL) ALL" >/etc/sudoers.d/wheel
