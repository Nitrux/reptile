#!/bin/bash

function createAmd64Mirrors() {
  echo "- CREATING REPOSITORY MIRRORS"

  echo "  - Adding Key for Ubuntu Xenial"
  gpg --no-default-keyring --keyring trustedkeys.gpg --keyserver keys.gnupg.net --recv-keys 40976EAF437D05B5 3B4FE6ACC0B21F32 > /dev/null 2>&1
  echo "  - Creating AMD64 Mirror for Ubuntu Xenial : xenial"
  aptly mirror create -architectures="amd64" xenial http://archive.ubuntu.com/ubuntu xenial main universe multiverse restricted

  echo "  - Creating AMD64 Mirror for Ubuntu Xenial - Updates : xenial-updates"
  aptly mirror create -architectures="amd64" xenial-updates http://archive.ubuntu.com/ubuntu xenial-updates main universe multiverse restricted

  echo "  - Creating AMD64 Mirror for Ubuntu Xenial - Security : xenial-security"
  aptly mirror create -architectures="amd64" xenial-security http://archive.ubuntu.com/ubuntu xenial-security main universe multiverse restricted

  echo
  echo "  - Adding Key for KDENeon Xenial"
  gpg --no-default-keyring --keyring trustedkeys.gpg --keyserver keys.gnupg.net --recv-keys E6D4736255751E5D > /dev/null 2>&1
  echo "  - Creating AMD64 Mirror for KDENeon Xenial : kdeneon-xenial"
  aptly mirror create -architectures="amd64" kdeneon-xenial https://archive.neon.kde.org/user/ xenial main

  echo
  echo "  - Creating AMD64 Mirror for NXOS : nxos"
  aptly mirror create -ignore-signatures=true -architectures="amd64" nxos http://repo.nxos.org/ nxos main  
}

HELPTEXT="nxos-repository-util : A Simple Tool to manage NXOS repository with Aptly

USAGE :
  nxos-repository-util [OPTION]

OPTIONS :
  create-amd64-mirrors
"

case "$1" in
  create-amd64-mirrors)
    createAmd64Mirrors
  ;;

  *)
    echo "$HELPTEXT"
    exit 1
  ;;
esac

exit 0