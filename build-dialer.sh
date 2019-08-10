#!/bin/bash

LINUXDEPLOY_TOOL=$PWD/linuxdeploy-tool


#Sources
KIRIGAMI_SRCS=git://anongit.kde.org/kirigami
MAUIKIT_SRCS=git://anongit.kde.org/mauikit
DIALER_SRCS=git://anongit.kde.org/maui-dialer

wget -Nc https://github.com/probonopd/linuxdeployqt/releases/download/6/linuxdeployqt-6-x86_64.AppImage -O $LINUXDEPLOY_TOOL

chmod +x linuxdeploy*

sudo apt-get install ecm qtbase5-dev build-essential git gcc g++ qtdeclarative5-dev qml-module-qtquick-controls libqt5svg5-dev qtmultimedia5-dev automake cmake qtquickcontrols2-5-dev libkf5config-dev libkf5service-dev libkf5notifications-dev libkf5kiocore5 libkf5kio-dev qml-module-qtwebengine gettext extra-cmake-modules libkf5wallet-dev qtbase5-private-dev qtwebengine5-dev libkf5wallet-dev qt5-default qt5-default libqt5websockets5-dev libtag1-dev libkf5people-dev libkf5contacts-dev

[ ! -d "kirigami" ] && git clone $KIRIGAMI_SRCS "kirigami" && [ -d "kirigami" ] && git pull origin master
pushd ./kirigami && [ ! -d "build" ] && mkdir build
cd ./build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr
sudo make install

popd
[ ! -d "mauikit" ] && git clone $MAUIKIT_SRCS "mauikit" && [ -d "mauikit" ] && git pull origin master
pushd ./mauikit && [ ! -d "build" ] && mkdir build
cd ./build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr
sudo make install

popd
[ ! -d "dialer" ] && git clone $DIALER_SRCS "dialer" && [ -d "dialer" ] && git pull origin master
pushd ./dialer && [ ! -d "build" ] && mkdir build
cd ./build
cmake .. -DCMAKE_INSTALL_PREFIX=./AppDir
make install
cp ../assets/96.png ./smartphone.png
find $HOME/build-*-*_Qt_* \( -name "moc_*" -or -name "*.o" -or -name "qrc_*" -or -name "Makefile*" -or -name "*.a" \) -exec rm {} \;
# $1 ./AppDir/share/applications/org.kde.index.desktop -appimage -unsupported-allow-new-glibc -qmldir=/usr/lib/x86_64-linux-gnu/qt5/qml/QtQuick -qmldir=/usr/lib/x86_64-linux-gnu/qt5/qml/org/kde/kirigami.2 -qmldir=/usr/lib/x86_64-linux-gnu/qt5/qml/org/kde/mauikit -qmldir=/usr/lib/x86_64-linux-gnu/qt5/qml/QtQuick/Controls.2/org.kde.desktop -qmldir=/usr/lib/x86_64-linux-gnu/qt5/qml/QMLTermWidget 

$LINUXDEPLOY_TOOL ./AppDir/share/applications/org.kde.dialer.desktop -appimage -unsupported-allow-new-glibc -extra-plugins=iconengines -qmake=/usr/lib/x86_64-linux-gnu/qt5/bin/qmake -qmldir=/usr/lib/x86_64-linux-gnu/qt5/qml/QtQuick/Controls -qmldir=/usr/lib/x86_64-linux-gnu/qt5/qml/QtQuick/Templates.2 -qmldir=/usr/lib/x86_64-linux-gnu/qt5/qml/QtQuick/Controls.2 -qmldir=/usr/lib/x86_64-linux-gnu/qt5/qml/QtQuick/Layouts -qmldir=/usr/lib/x86_64-linux-gnu/qt5/qml/org/kde/kirigami.2 -qmldir=/usr/lib/x86_64-linux-gnu/qt5/qml/org/kde/mauikit -qmldir=/usr/lib/x86_64-linux-gnu/qt5/qml/QtQuick/Controls.2/org.kde.desktop
