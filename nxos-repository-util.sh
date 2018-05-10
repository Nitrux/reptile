#!/bin/sh

createAmd64Mirrors() {
  NXOS_PACKAGES="accountsservice|acl|acpi-support|acpid|adwaita-icon-theme|alsa-base|alsa-utils|appimage-desktop-integration-first-run|appimage-desktop-integration-user-apps-monitor|appimagethumbs|apport|apport-symptoms|appstream|apt-config-icons|apt-config-icons-hidpi|apt-config-icons-large|apt-config-icons-large-hidpi|apt-xapian-index|ark|aspell|aspell-en|at-spi2-core|avahi-daemon|baloo-kf5|bc|bind9-host|binutils|binutils-common|binutils-x86-64-linux-gnu|bluedevil|bluez|bluez-cups|bluez-obexd|breeze|breeze-cursor-theme|breeze-icon-theme|bsdmainutils|busybox-initramfs|busybox-static|calamares|calamares-settings-nxos|casper|catdoc|chromium-browser|chromium-browser-l10n|chromium-codecs-ffmpeg-extra|cifs-utils|colord|colord-data|console-setup|console-setup-linux|cpio|cpp|cpp-7|cracklib-runtime|crda|cryptsetup|cryptsetup-bin|cups|cups-browsed|cups-client|cups-common|cups-core-drivers|cups-daemon|cups-filters|cups-filters-core-drivers|cups-ipp-utils|cups-ppdc|cups-server-common|dbus|dbus-x11|dc|dconf-gsettings-backend|dconf-service|debconf-kde-data|dictionaries-common|discover|discover-data|distro-info-data|dmsetup|dns-root-data|dnsmasq-base|dolphin|dosfstools|drkonqi|efibootmgr|eject|emacsen-common|ethtool|file|fontconfig|fontconfig-config|fonts-dejavu-core|fonts-droid-fallback|fonts-freefont-ttf|fonts-hack|fonts-hack-ttf|fonts-lato|fonts-noto|fonts-noto-cjk|fonts-noto-hinted|fonts-noto-mono|fonts-noto-unhinted|frameworkintegration|fuse|fwupd|fwupdate|fwupdate-signed|gamin|gcc|gcc-7|gcc-7-base|gconf-service|gconf-service-backend|gconf2-common|gdb|gdbserver|gdisk|geoclue-2.0|geoip-database|gettext-base|ghostscript|gir1.2-glib-2.0|glib-networking|glib-networking-common|glib-networking-services|groff-base|grub-common|grub-efi|grub-efi-amd64|grub-efi-amd64-bin|grub2-common|grub2-theme-nomad|gsettings-desktop-schemas|gsfonts|gstreamer1.0-alsa|gstreamer1.0-plugins-base|gstreamer1.0-plugins-good|gstreamer1.0-pulseaudio|gstreamer1.0-x|gtk-update-icon-cache|gtk2-engines-murrine|gtk2-engines-pixbuf|gtk3-engines-breeze|hdparm|hicolor-icon-theme|humanity-icon-theme|hunspell-en-us|i965-va-driver|ieee-data|iio-sensor-proxy|imagemagick|imagemagick-6-common|imagemagick-6.q16|initramfs-tools|initramfs-tools-bin|initramfs-tools-core|inputattach|iproute2|iptables|iputils-arping|isc-dhcp-client|isc-dhcp-common|iso-codes|iw|javascript-common|kaccounts-providers|kactivities-bin|kactivitymanagerd|kate|kate5-data|kbd|kcalc|kde-cli-tools|kde-cli-tools-data|kde-config-gtk-style|kde-config-screenlocker|kde-config-sddm|kde-spectacle|kde-style-breeze|kde-style-breeze-qt4|kdeconnect|kded5|kdelibs5-data|kdeplasma-addons-data|kerneloops|keyboard-configuration|kgamma5|khotkeys|khotkeys-data|kinfocenter|kinit|kio|kio-extras|kio-extras-data|klibc-utils|kmenuedit|kmod|konsole|konsole-kpart|kpackagelauncherqml|kpackagetool5|krb5-locales|kross|kscreen|ksshaskpass|ksysguard|ksysguard-data|ksysguardd|ktexteditor-data|ktexteditor-katepart|kvantum|kvantum-theme-kvnomad|kwalletmanager|kwayland-data|kwayland-integration|kwin|kwin-addons|kwin-common|kwin-data|kwin-style-breeze|kwin-x11|kwrited|latte-dock|liba52-0.7.4|libaa1|libaacs0|libaccounts-glib0|libaccounts-qt5-1|libaccountsservice0|libapparmor1|libappimage|libappstream-glib8|libappstream4|libappstreamqt2|libapt-inst2.0|libarchive13|libargon2-0|libaribb24-0|libasan4|libasound2|libasound2-data|libasound2-plugins|libaspell15|libass9|libasyncns0|libatasmart4|libatk-bridge2.0-0|libatk1.0-0|libatk1.0-data|libatm1|libatomic1|libatspi2.0-0|libattica0.4|libaudio2|libauthen-sasl-perl|libavahi-client3|libavahi-common-data|libavahi-common3|libavahi-core7|libavahi-glib1|libavc1394-0|libavcodec57|libavformat57|libavutil55|libbabeltrace1|libbasicusageenvironment1|libbdplus0|libbind9-160|libbinutils|libblockdev-crypto2|libblockdev-fs2|libblockdev-loop2|libblockdev-part-err2|libblockdev-part2|libblockdev-swap2|libblockdev-utils2|libblockdev2|libbluetooth3|libbluray2|libboost-python1.65.1|libbsd0|libc-ares2|libc-dev-bin|libc6-dbg|libc6-dev|libcaca0|libcairo-gobject2|libcairo2|libcanberra0|libcap2|libcap2-bin|libcc1-0|libcddb2|libcdparanoia0|libchromaprint1|libcilkrts5|libcolorcorrect5|libcolord2|libcolorhug2|libcrack2|libcroco3|libcryptsetup12|libcrystalhd3|libcups2|libcupscgi1|libcupsfilters1|libcupsimage2|libcupsmime1|libcupsppdc1|libcurl3-gnutls|libdaemon0|libdata-dump-perl|libdatrie1|libdbus-1-3|libdbus-glib-1-2|libdbusmenu-qt2|libdbusmenu-qt5-2|libdc1394-22|libdca0|libdconf1|libdebconf-kde1|libdevmapper1.02.1|libdiscover2|libdjvulibre-text|libdjvulibre21|libdlrestrictions1|libdmtx0a|libdns-export1100|libdns1100|libdolphinvcs5|libdouble-conversion1|libdrm-amdgpu1|libdrm-common|libdrm-intel1|libdrm-nouveau2|libdrm-radeon1|libdrm2|libdv4|libdvbpsi10|libdvdnav4|libdvdread4|libdw1|libebml4v5|libedit2|libeditorconfig0|libefiboot1|libefivar1|libegl-mesa0|libegl1|libegl1-mesa|libelf1|libencode-locale-perl|libepoxy0|libepub0|libevdev2|libevent-2.1-6|libexif12|libexiv2-14|libexpat1|libfaad2|libfakekey0|libfftw3-double3|libfftw3-single3|libfile-basedir-perl|libfile-copy-recursive-perl|libfile-desktopentry-perl|libfile-listing-perl|libfile-mimeinfo-perl|libflac8|libfont-afm-perl|libfontconfig1|libfontembed1|libfontenc1|libfreetype6|libfribidi0|libfuse2|libfwup1|libfwupd2|libgail-common|libgail18|libgamin0|libgbm1|libgcab-1.0-0|libgcc-7-dev|libgconf-2-4|libgd3|libgdbm-compat4|libgdbm5|libgdk-pixbuf2.0-0|libgdk-pixbuf2.0-bin|libgdk-pixbuf2.0-common|libgeoclue-2-0|libgeoip1|libgif7|libgirepository-1.0-1|libgit2-26|libgl1|libgl1-mesa-dri|libgl1-mesa-glx|libglapi-mesa|libgles2|libglib2.0-0|libglib2.0-bin|libglib2.0-data|libglu1-mesa|libglvnd0|libglx-mesa0|libglx0|libgme0|libgomp1|libgpgme11|libgpgmepp6|libgphoto2-6|libgphoto2-l10n|libgphoto2-port12|libgpm2|libgps23|libgraphite2-3|libgroupsock8|libgs9|libgs9-common|libgsm1|libgssapi-krb5-2|libgstreamer-plugins-base1.0-0|libgstreamer-plugins-good1.0-0|libgstreamer1.0-0|libgtk-3-0|libgtk-3-bin|libgtk-3-common|libgtk2.0-0|libgtk2.0-bin|libgtk2.0-common|libgudev-1.0-0|libgusb2|libgutenprint2|libharfbuzz-icu0|libharfbuzz0b|libhfstospell9|libhtml-form-perl|libhtml-format-perl|libhtml-parser-perl|libhtml-tagset-perl|libhtml-tree-perl|libhttp-cookies-perl|libhttp-daemon-perl|libhttp-date-perl|libhttp-message-perl|libhttp-negotiate-perl|libhttp-parser2.7.1|libhunspell-1.6-0|libhyphen0|libibus-1.0-5|libical3|libice6|libicu60|libidn11|libiec61883-0|libieee1284-3|libijs-0.35|libilmbase12|libimobiledevice6|libinput-bin|libinput10|libio-html-perl|libio-socket-ssl-perl|libip4tc0|libip6tc0|libipc-system-simple-perl|libiptc0|libisc-export169|libisc169|libisccc160|libisccfg160|libisl19|libitm1|libiw30|libjack-jackd2-0|libjansson4|libjbig0|libjbig2dec0|libjpeg-turbo8|libjpeg8|libjs-jquery|libjs-underscore|libjson-c3|libjson-glib-1.0-0|libjson-glib-1.0-common|libk5crypto3|libkaccounts1|libkate1|libkdecorations2-5v5|libkdecorations2private5v5|libkdecore5|libkdeui5|libkeyutils1|libkf5activities5|libkf5activitiesstats1|libkf5archive5|libkf5attica5|libkf5auth-data|libkf5auth5|libkf5baloo5|libkf5balooengine5|libkf5baloowidgets-bin|libkf5baloowidgets-data|libkf5baloowidgets5|libkf5bluezqt-data|libkf5bluezqt6|libkf5bookmarks-data|libkf5bookmarks5|libkf5calendarevents5|libkf5codecs-data|libkf5codecs5|libkf5completion-data|libkf5completion5|libkf5config-bin|libkf5config-data|libkf5configcore5|libkf5configgui5|libkf5configwidgets-data|libkf5configwidgets5|libkf5coreaddons-data|libkf5coreaddons5|libkf5crash5|libkf5dbusaddons-bin|libkf5dbusaddons-data|libkf5dbusaddons5|libkf5declarative-data|libkf5declarative5|libkf5dnssd-data|libkf5dnssd5|libkf5doctools5|libkf5emoticons-bin|libkf5emoticons-data|libkf5emoticons5|libkf5filemetadata-bin|libkf5filemetadata-data|libkf5filemetadata3|libkf5globalaccel-bin|libkf5globalaccel-data|libkf5globalaccel5|libkf5globalaccelprivate5|libkf5guiaddons5|libkf5holidays-data|libkf5holidays5|libkf5i18n-data|libkf5i18n5|libkf5iconthemes-bin|libkf5iconthemes-data|libkf5iconthemes5|libkf5idletime5|libkf5itemmodels5|libkf5itemviews-data|libkf5itemviews5|libkf5jobwidgets-data|libkf5jobwidgets5|libkf5js5|libkf5jsembed-data|libkf5jsembed5|libkf5kcmutils-data|libkf5kcmutils5|libkf5kdelibs4support-data|libkf5kdelibs4support5|libkf5kdelibs4support5-bin|libkf5khtml-bin|libkf5khtml-data|libkf5khtml5|libkf5kiocore5|libkf5kiofilewidgets5|libkf5kiogui5|libkf5kiontlm5|libkf5kiowidgets5|libkf5kirigami2-5|libkf5krosscore5|libkf5krossui5|libkf5modemmanagerqt6|libkf5networkmanagerqt6|libkf5newstuff-data|libkf5newstuff5|libkf5newstuffcore5|libkf5notifications-data|libkf5notifications5|libkf5notifyconfig-data|libkf5notifyconfig5|libkf5package-data|libkf5package5|libkf5parts-data|libkf5parts-plugins|libkf5parts5|libkf5people-data|libkf5people5|libkf5peoplebackend5|libkf5peoplewidgets5|libkf5plasma5|libkf5plasmaquick5|libkf5prison5|libkf5pty-data|libkf5pty5|libkf5purpose-bin|libkf5purpose5|libkf5quickaddons5|libkf5runner5|libkf5screen7|libkf5service-bin|libkf5service-data|libkf5service5|libkf5solid5|libkf5solid5-data|libkf5sonnet5-data|libkf5sonnetcore5|libkf5sonnetui5|libkf5style5|libkf5su-bin|libkf5su-data|libkf5su5|libkf5syntaxhighlighting-data|libkf5syntaxhighlighting5|libkf5sysguard-bin|libkf5sysguard-data|libkf5texteditor5|libkf5texteditor5-libjs-underscore|libkf5textwidgets-data|libkf5textwidgets5|libkf5threadweaver5|libkf5unitconversion-data|libkf5unitconversion5|libkf5wallet-bin|libkf5wallet-data|libkf5wallet5|libkf5waylandclient5|libkf5waylandserver5|libkf5widgetsaddons-data|libkf5widgetsaddons5|libkf5windowsystem-data|libkf5windowsystem5|libkf5xmlgui-bin|libkf5xmlgui-data|libkf5xmlgui5|libkf5xmlrpcclient-data|libkf5xmlrpcclient5|libkfontinst5|libkfontinstui5|libklibc|libkmod2|libkpmcore7|libkrb5-3|libkrb5support0|libkscreenlocker5|libksgrd7|libksignalplotter7|libkwalletbackend5-5|libkwin4-effect-builtins1|libkwineffects11|libkwinglutils11|libkwinxrenderutils11|libkworkspace5-5|liblcms2-2|libldb1|liblirc-client0|liblivemedia62|libllvm6.0|liblmdb0|liblocale-gettext-perl|liblouis-data|liblouis14|liblouisutdml-bin|liblouisutdml-data|liblouisutdml8|liblqr-1-0|liblsan0|libltdl7|liblua5.2-0|liblwp-mediatypes-perl|liblwp-protocol-https-perl|liblwres160|liblzo2-2|libmad0|libmagic-mgc|libmagic1|libmagickcore-6.q16-3|libmagickcore-6.q16-3-extra|libmagickwand-6.q16-3|libmailtools-perl|libmatroska6v5|libmbim-glib4|libmbim-proxy|libmicrodns0|libminizip1|libmm-glib0|libmng2|libmnl0|libmp3lame0|libmpc3|libmpcdec6|libmpdec2|libmpeg2-4|libmpfr6|libmpg123-0|libmpx2|libmtdev1|libmtp-common|libmtp-runtime|libmtp9|libmysqlclient20|libndp0|libnet-dbus-perl|libnet-http-perl|libnet-smtp-ssl-perl|libnet-ssleay-perl|libnetfilter-conntrack3|libnetpbm10|libnewt0.52|libnfnetlink0|libnfs11|libnghttp2-14|libnl-3-200|libnl-genl-3-200|libnm0|libnotify4|libnspr4|libnss-mdns|libnss-systemd|libnss3|libntfs-3g88|libnuma1|libogg0|libopenconnect5|libopenexr22|libopenjp2-7|libopenmpt-modplug1|libopenmpt0|libopus0|liborc-0.4-0|libpackagekit-glib2-18|libpackagekitqt5-1|libpam-cap|libpam-kwallet5|libpam-systemd|libpango-1.0-0|libpangocairo-1.0-0|libpangoft2-1.0-0|libpaper-utils|libpaper1|libparted-fs-resize0|libparted2|libpcap0.8|libpci3|libpciaccess0|libpcre2-16-0|libpcsclite1|libperl5.26|libphonon4|libphonon4qt5-4|libpipeline1|libpixman-1-0|libplacebo4|libplasma-geolocation-interface5|libplist3|libplymouth4|libpng16-16|libpolkit-agent-1-0|libpolkit-backend-1-0|libpolkit-gobject-1-0|libpolkit-qt5-1-1|libpoppler-qt5-1|libpoppler73|libpopt0|libpostproc54|libpowerdevilcore2|libpowerdevilui5|libprocesscore7|libprocessui7|libprotobuf-lite10|libproxy-tools|libproxy1v5|libpulse-mainloop-glib0|libpulse0|libpulsedsp|libpwquality-common|libpwquality1|libpython-stdlib|libpython2.7|libpython2.7-minimal|libpython2.7-stdlib|libpython3-stdlib|libpython3.6|libpython3.6-minimal|libpython3.6-stdlib|libqalculate14|libqalculate14-data|libqapt3|libqapt3-runtime|libqca-qt5-2|libqca-qt5-2-plugins|libqca2|libqca2-plugins|libqmi-glib5|libqmi-proxy|libqpdf21|libqrencode3|libqt4-dbus|libqt4-declarative|libqt4-network|libqt4-opengl|libqt4-script|libqt4-sql|libqt4-sql-mysql|libqt4-svg|libqt4-xml|libqt4-xmlpatterns|libqt5concurrent5|libqt5core5a|libqt5dbus5|libqt5gui5|libqt5multimedia5|libqt5multimedia5-plugins|libqt5multimediagsttools5|libqt5multimediaquick5|libqt5multimediawidgets5|libqt5network5|libqt5opengl5|libqt5positioning5|libqt5printsupport5|libqt5qml5|libqt5quick5|libqt5quickcontrols2-5|libqt5quicktemplates2-5|libqt5quickwidgets5|libqt5script5|libqt5sensors5|libqt5sql5|libqt5sql5-sqlite|libqt5svg5|libqt5test5|libqt5texttospeech5|libqt5waylandclient5|libqt5waylandcompositor5|libqt5webchannel5|libqt5webengine-data|libqt5webengine5|libqt5webenginecore5|libqt5webenginewidgets5|libqt5webkit5|libqt5widgets5|libqt5x11extras5|libqt5xml5|libqt5xmlpatterns5|libqtcore4|libqtdbus4|libqtgui4|libquadmath0|libraw1394-11|libre2-4|libresid-builder0c2a|librest-0.7-0|librsvg2-2|librsvg2-common|librtmp1|libruby2.5|libsamplerate0|libsane-common|libsane1|libsbc1|libscim8v5|libsdl-image1.2|libsdl1.2debian|libsecret-1-0|libsecret-common|libsensors4|libshine3|libshout3|libsidplay2|libsignon-plugins-common1|libsignon-qt5-1|libslang2|libsm6|libsmbclient|libsmbios-c2|libsnappy1v5|libsndfile1|libsndio6.1|libsoup-gnome2.4-1|libsoup2.4-1|libsoxr0|libspectre1|libspeex1|libspeexdsp1|libssh-4|libssh-gcrypt-4|libssh2-1|libssl1.0.0|libstemmer0d|libstoken1|libswresample2|libswscale4|libtag1v5|libtag1v5-vanilla|libtalloc2|libtaskmanager6|libtdb1|libteamdctl0|libtevent0|libtext-iconv-perl|libthai-data|libthai0|libtheora0|libtie-ixhash-perl|libtiff5|libtimedate-perl|libtomcrypt1|libtommath1|libtry-tiny-perl|libtsan0|libtwolame0|libubsan0|libudisks2-0|libupnp6|libupower-glib3|liburi-perl|libusageenvironment3|libusb-0.1-4|libusb-1.0-0|libusbmuxd4|libuv1|libv4l-0|libv4lconvert0|libva-drm2|libva-wayland2|libva-x11-2|libva2|libvdpau1|libvisual-0.4-0|libvlc-bin|libvlc5|libvlccore9|libvoikko1|libvolume-key1|libvorbis0a|libvorbisenc2|libvorbisfile3|libvpx5|libvulkan1|libwacom-bin|libwacom-common|libwacom2|libwavpack1|libwayland-client0|libwayland-cursor0|libwayland-egl1-mesa|libwayland-server0|libwbclient0|libweather-ion7|libwebp6|libwebpdemux2|libwebpmux3|libwebrtc-audio-processing1|libwmf0.2-7|libwrap0|libwww-perl|libwww-robotrules-perl|libx11-6|libx11-data|libx11-protocol-perl|libx11-xcb1|libx264-152|libx265-146|libx86-1|libxapian30|libxatracker2|libxau6|libxaw7|libxcb-composite0|libxcb-cursor0|libxcb-damage0|libxcb-dpms0|libxcb-dri2-0|libxcb-dri3-0|libxcb-glx0|libxcb-icccm4|libxcb-image0|libxcb-keysyms1|libxcb-present0|libxcb-randr0|libxcb-record0|libxcb-render-util0|libxcb-render0|libxcb-shape0|libxcb-shm0|libxcb-sync1|libxcb-util1|libxcb-xfixes0|libxcb-xinerama0|libxcb-xkb1|libxcb-xv0|libxcb1|libxcomposite1|libxcursor1|libxdamage1|libxdmcp6|libxext6|libxfixes3|libxfont2|libxft2|libxi6|libxinerama1|libxkbcommon-x11-0|libxkbcommon0|libxkbfile1|libxml-parser-perl|libxml-twig-perl|libxml-xpathengine-perl|libxml2|libxmu6|libxmuu1|libxpm4|libxrandr2|libxrender1|libxshmfence1|libxslt1.1|libxss1|libxt6|libxtables12|libxtst6|libxv1|libxvidcore4|libxvmc1|libxxf86dga1|libxxf86vm1|libyaml-0-2|libyaml-cpp0.5v5|libzip4|libzvbi-common|libzvbi0|linux-base|linux-firmware|linux-image-4.15.0-20-generic|linux-image-generic|linux-libc-dev|linux-modules-4.15.0-20-generic|linux-modules-extra-4.15.0-20-generic|linux-sound-base|localechooser-data|lsb-release|lupin-casper|luv-icon-theme|lzma|make|man-db|manpages|manpages-dev|media-player-info|memtest86+|mesa-va-drivers|mesa-vdpau-drivers|milou|mime-support|mobile-broadband-provider-info|modemmanager|mscompress|multiarch-support|muon-notifier|muon-updater|mysql-common|netbase|netpbm|netstat-nat|network-manager|network-manager-pptp|networkd-dispatcher|nodejs|nodejs-doc|nomad-clock-applet|nomad-desktop-settings|nomad-firewall|nomad-gtk-themes|nomad-networkmanagement-applet|nomad-notifications-applet|nomad-plasma-look-and-feel|nomad-systemtray|notification-daemon|ntfs-3g|nx-software-center|nx-software-updater|nxos-desktop|openssh-client|os-prober|oxygen-icon-theme|oxygen-sounds|p7zip|p7zip-full|packagekit|packagekit-tools|pam-kwallet-init|parted|pciutils|pcmciautils|perl|perl-modules-5.26|perl-openssl-defaults|phonon-backend-gstreamer|phonon-backend-gstreamer-common|phonon4qt5|phonon4qt5-backend-vlc|plasma-dataengines-addons|plasma-desktop|plasma-desktop-data|plasma-discover|plasma-discover-common|plasma-discover-private|plasma-discover-updater|plasma-framework|plasma-integration|plasma-look-and-feel-org-kde-breezedark-desktop|plasma-nm|plasma-pa|plasma-widget-nomad-simplemenu|plasma-widgets-addons|plasma-workspace|plymouth|plymouth-theme-nomad|plymouth-theme-ubuntu-text|pm-utils|policykit-1|policykit-desktop-privileges|polkit-kde-agent-1|poppler-data|poppler-utils|powerdevil|powerdevil-data|powermgmt-base|ppp|pptp-linux|printer-driver-gutenprint|psmisc|pulseaudio|pulseaudio-module-bluetooth|pulseaudio-module-gconf|pulseaudio-utils|python|python-apt-common|python-crypto|python-dbus|python-gi|python-ldb|python-minimal|python-qt4-dbus|python-samba|python-talloc|python-tdb|python2.7|python2.7-minimal|python3|python3-apport|python3-apt|python3-certifi|python3-chardet|python3-dbus|python3-debian|python3-gi|python3-httplib2|python3-idna|python3-minimal|python3-pkg-resources|python3-problem-report|python3-requests|python3-requests-unixsocket|python3-six|python3-systemd|python3-urllib3|python3-xapian|python3-xkit|python3.6|python3.6-minimal|qapt-deb-installer|qdbus|qdbus-qt5|qml-module-org-kde-activities|qml-module-org-kde-bluezqt|qml-module-org-kde-draganddrop|qml-module-org-kde-extensionplugin|qml-module-org-kde-kcm|qml-module-org-kde-kconfig|qml-module-org-kde-kcoreaddons|qml-module-org-kde-kholidays|qml-module-org-kde-kio|qml-module-org-kde-kirigami2|qml-module-org-kde-kquickcontrols|qml-module-org-kde-kquickcontrolsaddons|qml-module-org-kde-kwindowsystem|qml-module-org-kde-newstuff|qml-module-org-kde-purpose|qml-module-org-kde-qqc2desktopstyle|qml-module-org-kde-runnermodel|qml-module-org-kde-solid|qml-module-qt-labs-folderlistmodel|qml-module-qt-labs-settings|qml-module-qtgraphicaleffects|qml-module-qtmultimedia|qml-module-qtqml-models2|qml-module-qtquick-controls|qml-module-qtquick-controls-styles-breeze|qml-module-qtquick-controls2|qml-module-qtquick-dialogs|qml-module-qtquick-layouts|qml-module-qtquick-privatewidgets|qml-module-qtquick-templates2|qml-module-qtquick-virtualkeyboard|qml-module-qtquick-window2|qml-module-qtquick-xmllistmodel|qml-module-qtquick2|qml-module-qtwebengine|qml-module-qtwebkit|qml-module-ubuntu-onlineaccounts|qpdf|qpdfview|qpdfview-djvu-plugin|qpdfview-ps-plugin|qpdfview-translations|qt-at-spi|qt5-gtk-platformtheme|qt5-image-formats-plugins|qtchooser|qtcore4-l10n|qtdeclarative5-qtquick2-plugin|qtdeclarative5-xmllistmodel-plugin|qttranslations5-l10n|qtvirtualkeyboard-plugin|qtwayland5|rake|rfkill|rsync|rtkit|ruby|ruby-did-you-mean|ruby-minitest|ruby-net-telnet|ruby-power-assert|ruby-test-unit|ruby2.5|rubygems-integration|samba-common|samba-common-bin|samba-libs|sane-utils|sbsigntool|sddm|sddm-theme-breeze|secureboot-db|shared-mime-info|signon-plugin-oauth2|sni-qt|socat|sonnet-plugins|sound-theme-freedesktop|squashfs-tools|sshfs|ssl-cert|sudo|systemd|systemd-sysv|systemsettings|thermald|tzdata|ubuntu-drivers-common|ubuntu-mono|ucf|udev|udisks2|ufw|unzip|update-inetd|upower|usb-modeswitch|usb-modeswitch-data|usbmuxd|usbutils|user-manager|user-setup|uuid-runtime|va-driver-all|vbetool|vdpau-driver-all|vlc|vlc-bin|vlc-data|vlc-l10n|vlc-plugin-base|vlc-plugin-notify|vlc-plugin-qt|vlc-plugin-samba|vlc-plugin-skins2|vlc-plugin-video-output|vlc-plugin-video-splitter|vlc-plugin-visualization|wamerican|whiptail|wireless-regdb|wireless-tools|wpasupplicant|x11-apps|x11-common|x11-session-utils|x11-utils|x11-xkb-utils|x11-xserver-utils|xauth|xbitmaps|xdg-user-dirs|xdg-utils|xfonts-base|xfonts-encodings|xfonts-scalable|xfonts-utils|xinit|xinput|xkb-data|xorg|xorg-docs-core|xserver-common|xserver-xorg|xserver-xorg-core|xserver-xorg-input-all|xserver-xorg-input-libinput|xserver-xorg-input-wacom|xserver-xorg-legacy|xserver-xorg-video-all|xserver-xorg-video-amdgpu|xserver-xorg-video-ati|xserver-xorg-video-fbdev|xserver-xorg-video-intel|xserver-xorg-video-nouveau|xserver-xorg-video-qxl|xserver-xorg-video-radeon|xserver-xorg-video-vesa|xserver-xorg-video-vmware|xz-utils|zip"

  echo "CREATING REPOSITORY MIRRORS"

  echo "  - Adding Key for Ubuntu Bionic"
  gpg --no-default-keyring --keyring trustedkeys.gpg --keyserver keys.gnupg.net --recv-keys 40976EAF437D05B5 3B4FE6ACC0B21F32 2>&1 | sed -e 's/^/    * /'
  echo "  - Creating AMD64 Mirror for Ubuntu Bionic : bionic"
  aptly mirror create -filter=$NXOS_PACKAGES -filter-with-deps -architectures="amd64" bionic http://archive.ubuntu.com/ubuntu bionic main universe multiverse restricted 2>&1 | sed -e 's/^/    * /'

  echo
  echo "  - Adding Key for KDENeon Bionic"
  gpg --no-default-keyring --keyring trustedkeys.gpg --keyserver keys.gnupg.net --recv-keys E6D4736255751E5D 2>&1 | sed -e 's/^/    * /'
  echo "  - Creating AMD64 Mirror for KDENeon Bionic : kdeneon-bionic"
  aptly mirror create -filter=$NXOS_PACKAGES -filter-with-deps -architectures="amd64" kdeneon-bionic https://archive.neon.kde.org/dev/stable/ bionic main 2>&1 | sed -e 's/^/    * /'
}

updateMirrors() {
  echo "UPDATING MIRRORS"

  case "$1" in
    all)
      TO_BE_UPDATED="bionic kdeneon-bionic"
    ;;
    
    *)
      TO_BE_UPDATED=$@
    ;;
  esac

  for mirror in $TO_BE_UPDATED
  do
    echo "  - Updating $mirror"
    aptly mirror update $mirror 2>&1 | sed -e 's/^/    * /'
  done
}

upload() {
  NXOS_SERVER_URL=http://88.198.66.58/
  REPO=$1

  shift

  if [ -z "$@" ]; then
    echo "Invalid File List"
    exit 1
  else
    for FILE in "$@"; do
      if [ ! -e "$FILE" ]; then
        echo "Invalid Files in File List"
        exit 1
      fi

      FILE_PATH=$(realpath $FILE)
      FILE_LIST="$FILE_LIST -F file=@$FILE_PATH "
    done
  fi

  case "$REPO" in
    development|testing)
      if [ -z "$APTLY_USERNAME" -o -z "$APTLY_API_KEY" ]; then
        echo "Requires APTLY_USERNAME and APTLY_API_KEY to be set before uploading file"
        exit 1
      fi

      echo "DELETING Remote Upload Folder"
      curl -sS -u$APTLY_USERNAME:$APTLY_API_KEY -X DELETE $NXOS_SERVER_URL/aptly-api/files/$REPO-$APTLY_USERNAME 2>&1 | sed -e 's/^/    - /'

      echo
      echo "UPLOADING FILES"
      curl -sS -u$APTLY_USERNAME:$APTLY_API_KEY -X POST $FILE_LIST $NXOS_SERVER_URL/aptly-api/files/$REPO-$APTLY_USERNAME 2>&1 | sed -e 's/^/    - /'

      echo
      echo "PUBLISHING to $REPO"
      curl -sS -u$APTLY_USERNAME:$APTLY_API_KEY -X POST $NXOS_SERVER_URL/aptly-api/repos/$REPO/file/$REPO-$APTLY_USERNAME 2>&1 | sed -e 's/^/    - /'

      echo
      echo "UPDATING $REPO"
      curl -sS -u$APTLY_USERNAME:$APTLY_API_KEY -X PUT -H 'Content-Type: application/json' --data '{"local": [{"Component": "main"}]}' $NXOS_SERVER_URL/aptly-api/publish/:$REPO/nxos
    ;;

    *)
      echo "Invalid Repository"
      exit 1
    ;;
  esac
}

pushToStable() {
  PACKAGES=$(find ~/.aptly/public/testing/pool/main/ -name *.deb)
  TODAY=$(date +%s)
  LIMIT_DAYS=15

  echo "CHECKING FOR PACKAGES IN testing PUBLISHED >= $LIMIT_DAYS DAYS"

  for PACKAGE in $PACKAGES; do
    PACKAGE_NAME=$(echo $PACKAGE | awk -F/ '{print $NF}' | awk '{print substr($0, 1, length($1)-4)}')
    PACKAGE_DATE=$(date -r $PACKAGE +%s)
    DATE_DIFF=$(($TODAY - $PACKAGE_DATE))

    if [ $DATE_DIFF -ge $(($LIMIT_DAYS * 86400)) ]; then
      echo "    - Moving Package $PACKAGE_NAME to stable"
      aptly repo move -dry-run testing stable $PACKAGE_NAME 2>&1 > /dev/null
    fi
  done
}

publishLatest() {
  REPO=$1
  DATE=$(date +%Y%m%d)

  if [ -z $REPO ]; then
    echo "Invalid Number of Arguments"
    exit 1
  elif [ $REPO != "testing" -a $REPO != "stable" ]; then
    echo "Invalid Repository Name"
    exit 1
  fi

  echo "CREATING SNAPSHOTS"

  echo "    - Creating snapshot bionic-$DATE"
  aptly snapshot create bionic-$DATE from mirror bionic

  echo "    - Creating snapshot kdeneon-bionic-$DATE"
  aptly snapshot create kdeneon-bionic-$DATE from mirror kdeneon-bionic

  echo "    - Creating snapshot nxos-stable-$DATE"
  aptly snapshot create nxos-$REPO-$DATE from repo $REPO

  echo
  echo "MERGING SNAPSHOTS"
  aptly snapshot merge snapshot-$REPO-$DATE bionic-$DATE kdeneon-bionic-$DATE nxos-$REPO-$DATE

  echo
  echo "PUBLISHING LATEST SNAPSHOT"
  aptly publish switch nxos $REPO snapshot-$REPO-$DATE
}

HELPTEXT="nxos-repository-util : A Simple Tool to manage NXOS repository with Aptly

USAGE :
  nxos-repository-util [OPTION]

OPTIONS :
  -h | --help                                                       Print this HELP TEXT
  create-amd64-mirrors                                              Create the Repository Mirrors 
  update-mirrors [all | (list of space seperated mirrors)]          Update the Created Mirrors
  upload [development | testing] [list of space seperated files]    Upload Files to the repositories
  push-to-stable                                                    Push Packages from testing to stable
  publish-latest [stable | testing]                                 Create snapshot, merge and publish
                                                                    latest packages from mirrors
"

if [ -z `which realpath` ]; then 
  echo "realpath not found";
  exit 1;
fi

case "$1" in
  --help|-h)
    echo "$HELPTEXT"
    exit 0
  ;;

  create-amd64-mirrors)
    shift
    createAmd64Mirrors $@
  ;;

  update-mirrors)
    shift

    if [ $# -eq 0 ]; then
      echo "Error parsing the arguments"
      echo "$HELPTEXT"
      exit 1
    else
      updateMirrors $@
    fi
  ;;

  upload)
    shift

    if [ $# -lt 2 ]; then
      echo "Invalid Number of Arguments"
      echo "$HELPTEXT"
      exit 1
    else
      upload $@
    fi
  ;;

  push-to-stable)
    shift

    pushToStable $@
  ;;

  publish-latest)
    shift

    publishLatest $@
  ;;

  *)
    echo "Error parsing the arguments"
    echo "$HELPTEXT"
    exit 1
  ;;
esac

exit 0
