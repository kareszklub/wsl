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

# install nvm (https://github.com/nvm-sh/nvm) and the latest stable node version
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | NODE_VERSION="node" bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
# also install yarn
$(which ~/.nvm/versions/node/v*/bin/npm) i -g yarn
