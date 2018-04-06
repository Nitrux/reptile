#!/bin/sh

createAmd64Mirrors() {
  echo "CREATING REPOSITORY MIRRORS"

  echo "  - Adding Key for Ubuntu Bionic"
  gpg --no-default-keyring --keyring trustedkeys.gpg --keyserver keys.gnupg.net --recv-keys 40976EAF437D05B5 3B4FE6ACC0B21F32 2>&1 | sed -e 's/^/    * /'
  echo "  - Creating AMD64 Mirror for Ubuntu Bionic : bionic"
  aptly mirror create -filter="cryptsetup|gcc|make|chromium-browser|mobile-broadband-provider-info|pm-utils|pulseaudio-module-bluetooth|grub2-common|ubuntu-drivers-common|x11-session-utils|xinit|xorg|acpi-support|acpid|alsa-base|bluez-cups|dc|linux-sound-base|linux-image-generic|rfkill|sbsigntool|inputattach|kerneloops-daemon|mscompress|pcmciautils|policykit-desktop-privileges|fwupd|fwupdate|fwupdate-signed|pm-utils|pulseaudio-module-bluetooth|mobile-broadband-provider-info|pulseaudio" -filter-with-deps -architectures="amd64" bionic http://archive.ubuntu.com/ubuntu bionic main universe multiverse restricted 2>&1 | sed -e 's/^/    * /'

  echo
  echo "  - Adding Key for KDENeon Bionic"
  gpg --no-default-keyring --keyring trustedkeys.gpg --keyserver keys.gnupg.net --recv-keys E6D4736255751E5D 2>&1 | sed -e 's/^/    * /'
  echo "  - Creating AMD64 Mirror for KDENeon Bionic : kdeneon-bionic"
  aptly mirror create -filter="phonon-backend-gstreamer|gstreamer1.0-pulseaudio|frameworkintegration|kimageformat-plugins|qt5-image-formats-plugins|sddm|baloo-kf5|breeze|kde-cli-tools|khotkeys|kinfocenter|kio|kio-extras|kmenuedit|ksysguard|kwin|oxygen-sounds|plasma-desktop|powerdevil|systemsettings|plasma-widgets-addons|kde-config-gtk-style|polkit-kde-agent-1|bluedevil|kwin-addons|kscreen|milou|plasma-nm|kde-config-sddm|user-manager|plasma-pa|konsole|kcalc|ark|dolphin|kde-spectacle|kate|qapt-deb-installer|oxygen-icon-theme|partitionmanager|python-qt4-dbus|gtk2-engines-oxygen|gtk3-engines-breeze|kdeconnect|qpdfview|upower|udisks2|xdg-utils|cdrdao|libqca2-plugin-ossl|qtdeclarative5-xmllistmodel-plugin|libqt5qml-graphicaleffects|xdg-user-dirs" -filter-with-deps -architectures="amd64" kdeneon-bionic https://archive.neon.kde.org/dev/stable/ bionic main 2>&1 | sed -e 's/^/    * /'
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
  DATE=$(echo date+%Y%m%d)

  echo "CREATING SNAPSHOTS"

  echo "    - Creating snapshot bionic-$DATE"
  aptly snapshot create bionic-$DATE from mirror bionic

  echo "    - Creating snapshot kdeneon-bionic-$DATE"
  aptly snapshot create kdeneon-bionic-$DATE from mirror kdeneon-bionic

  echo "    - Creating snapshot nxos-stable-$DATE"
  aptly snapshot create nxos-stable-$DATE from repo stable

  echo
  echo "MERGING SNAPSHOTS"
  aptly snapshot merge snapshot-$DATE bionic-$DATE kdeneon-bionic-$DATE nxos-stable-$DATE

  echo
  echo "PUBLISHING LATEST SNAPSHOT"
  aptly publish switch nxos stable snapshot-$DATE
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
  publish-latest                                                    Create snapshot, merge and publish
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
