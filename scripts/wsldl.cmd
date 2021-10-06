:: generate a wsldl exe with an epic icon
cd build
mkdir wsldl

curl.exe -Lo rcedit.exe "https://github.com/electron/rcedit/releases/download/v1.1.1/rcedit-x64.exe"
curl.exe -Lo wsldl/kareszwsl.exe "https://github.com/yuk7/wsldl/releases/latest/download/wsldl.exe"

rcedit.exe wsldl\kareszwsl.exe --set-icon ..\etc\karesz.ico

copy kareszwsl.tar.gz wsldl\rootfs.tar.gz

powershell Compress-Archive wsldl/* wsldl.zip
