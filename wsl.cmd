@echo off
:: make sure wsl 2 is installed
echo this script requires that wsl2 is installed
echo please run `wsl -l -v` to check
echo if you get a generic help menu wsl2 is not installed
echo please quit and run `wsl --install` and `wsl --set-default-version 2`
pause
:: wsl2 is installed, we continue

:: just in case
wsl --set-default-version 2

:: install archwsl https://github.com/yuk7/ArchWSL
cd %USERPROFILE%
mkdir wsl
cd wsl
curl.exe -LO https://github.com/yuk7/ArchWSL/releases/latest/download/Arch.zip
tar -xvf Arch.zip
Arch.exe

:: post-install
wsl --set-default arch

Arch.exe run curl -sL "https://gist.githubusercontent.com/beni69/a36dd5555ea8b735933bede467d494d1/raw/postinstall.sh" | bash -s
Arch.exe config --default-user diak

echo setup done
pause
