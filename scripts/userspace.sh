#!/bin/bash

# install yay (https://github.com/Jguer/yay)
if ! builtin type -p 'yay' >/dev/null 2>&1; then
    echo 'Install yay.'
    tmpdir="$(command mktemp -d)"
    command cd "${tmpdir}" || return 1
    dl_url="$(
        command curl -sfLS 'https://api.github.com/repos/Jguer/yay/releases/latest' |
            command grep 'browser_download_url' |
            command cut -d '"' -f 4 |
            command grep 'x86_64'
    )"
    command wget "${dl_url}"
    command tar xzvf yay_*_x86_64.tar.gz
    command cd yay_*_x86_64 || return 1
    ./yay -Sy --noconfirm yay-bin
    rm -rf "${tmpdir}"
fi

cd ~

# install oh my zsh (https://github.com/ohmyzsh/ohmyzsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
# also install some plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# install nvm (https://github.com/nvm-sh/nvm) and the latest stable node version
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | NODE_VERSION="node" bash
# also install yarn
$(which ~/.nvm/versions/node/v*/bin/npm) i -g yarn
