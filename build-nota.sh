#!/usr/bin/env bash
set -e

# Install linuxdeploy
LINUXDEPLOY_BIN=$PWD/linuxdeploy
LINUXDEPLOY_PLUGIN_QT_BIN=$PWD/linuxdeploy-plugin-qt

wget -Nc https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage -O $LINUXDEPLOY_BIN
wget -Nc https://github.com/linuxdeploy/linuxdeploy-plugin-qt/releases/download/continuous/linuxdeploy-plugin-qt-x86_64.AppImage -O $LINUXDEPLOY_PLUGIN_QT_BIN

chmod +x linuxdeploy*

# Builds config
BUILD_TYPE=Release
INSTALL_PREFIX=$PWD/usr

# Sources
KIRIGAMI_SRCS=git://anongit.kde.org/kirigami
MAUIKIT_SRCS=https://invent.kde.org/kde/mauikit

sudo apt-get install ecm qtbase5-dev build-essential git gcc g++ qtdeclarative5-dev qml-module-qtquick-controls libqt5svg5-dev qtmultimedia5-dev automake cmake qtquickcontrols2-5-dev libkf5config-dev libkf5service-dev libkf5notifications-dev libkf5kiocore5 libkf5kio-dev qml-module-qtwebengine gettext extra-cmake-modules libkf5wallet-dev qtbase5-private-dev qtwebengine5-dev libkf5wallet-dev qt5-default qt5-default libqt5websockets5-dev libtag1-dev libkf5people-dev libkf5contacts-dev libkf5coreaddons5 qtdeclarative5-dev-tools -y

[ ! -d "kirigami" ] && git clone "$KIRIGAMI_SRCS" "kirigami" --depth 1  && [ -d "kirigami" ] && git pull origin master
pushd "./kirigami" && [ ! -d "build" ] && mkdir build
    cd ./build
    cmake .. -DCMAKE_INSTALL_PREFIX=/usr
    sudo make install
popd


[ ! -d "mauikit" ] && git clone "$MAUIKIT_SRCS"  --depth 1 && [ -d "mauikit" ] && git pull origin master
    pushd ./mauikit && [ ! -d "build" ] && mkdir build
    cd ./build
    cmake .. -DCMAKE_INSTALL_PREFIX=/usr
    sudo make install
popd


[ ! -d "nota" ] && git clone https://invent.kde.org/kde/nota --depth 1 && [ -d "nota" ] && git pull origin master
pushd ./nota && [ ! -d "build" ] && mkdir build
cd ./build
cmake  -DCMAKE_INSTALL_PREFIX="/usr" -DCMAKE_BUILD_TYPE="$BUILD_TYPE" ..

[ -d "AppDir" ] && rm -rf AppDir
DESTDIR=AppDir make install -j`nproc`

# The desktop file entry should set the right file icon name without the file extension
sed -i "s/Icon=.*/Icon=nota/g" AppDir/usr/share/applications/org.kde.nota.desktop


$LINUXDEPLOY_BIN --appdir=AppDir

export QML_MODULES_PATHS=/usr/lib/x86_64-linux-gnu/qt5/qml:$INSTALL_PREFIX/lib/x86_64-linux-gnu/qml
export QML_SOURCES_PATHS=$PWD/../src/
$LINUXDEPLOY_PLUGIN_QT_BIN --appdir=AppDir

$LINUXDEPLOY_BIN --appdir=AppDir --output appimage
exit 0
Collapse

