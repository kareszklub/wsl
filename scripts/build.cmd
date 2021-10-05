mkdir build
cd build

:: set wsl version (just in case)
wsl --set-default-version 1

:: download archwsl https://github.com/yuk7/ArchWSL
curl.exe -LO https://github.com/yuk7/ArchWSL/releases/latest/download/Arch.zip
tar -xvf Arch.zip

Arch.exe help
Arch.exe install
Arch.exe help

:: run post-install script
Arch.exe runp ../scripts/postinstall.sh
Arch.exe config --default-user diak

Arch.exe backup --tgz
move backup.tar.gz kareszwsl.tar.gz

Arch.exe clean -y
