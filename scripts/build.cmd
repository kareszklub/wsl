mkdir build
cd build

:: set wsl version (just in case)
wsl --set-default-version 1

:: download archwsl https://github.com/yuk7/ArchWSL
curl.exe -LO https://github.com/yuk7/ArchWSL/releases/latest/download/Arch.zip || echo ERROR && exit /b
tar -xvf Arch.zip

Arch.exe help
Arch.exe install || echo ERROR && exit /b
Arch.exe help

Arch.exe config --append-path false

:: run post-install script
Arch.exe runp ../scripts/postinstall.sh || echo ERROR && exit /b

Arch.exe backup --tgz || echo ERROR && exit /b
move backup.tar.gz kareszwsl.tar.gz

Arch.exe clean -y
