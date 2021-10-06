:: generate a wsldl exe with an epic icon
cd build

curl.exe -o rcedit.exe "https://github.com/electron/rcedit/releases/download/v1.1.1/rcedit-x64.exe"

mkdir wsldl
cd wsldl

curl.exe -O "https://github.com/yuk7/wsldl/releases/latest/download/wsldl.exe"

..\rcedit.exe wsldl.exe --set-icon ..\..\etc\karesz.ico

copy ..\kareszwsl.tar.gz .\rootfs.tar.gz
cd ..

powershell Compress-Archive wsldl/* wsldl.zip
