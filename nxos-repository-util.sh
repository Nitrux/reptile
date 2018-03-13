#!/bin/bash

function createAmd64Mirrors() {
  echo "CREATING REPOSITORY MIRRORS"

  echo "  - Adding Key for Ubuntu Xenial"
  gpg --no-default-keyring --keyring trustedkeys.gpg --keyserver keys.gnupg.net --recv-keys 40976EAF437D05B5 3B4FE6ACC0B21F32 2>&1 | sed -e 's/^/    * /'
  echo "  - Creating AMD64 Mirror for Ubuntu Xenial : xenial"
  aptly mirror create -architectures="amd64" xenial http://archive.ubuntu.com/ubuntu xenial main universe multiverse restricted 2>&1 | sed -e 's/^/    * /'

  echo "  - Creating AMD64 Mirror for Ubuntu Xenial - Updates : xenial-updates"
  aptly mirror create -architectures="amd64" xenial-updates http://archive.ubuntu.com/ubuntu xenial-updates main universe multiverse restricted 2>&1 | sed -e 's/^/    * /'

  echo "  - Creating AMD64 Mirror for Ubuntu Xenial - Security : xenial-security"
  aptly mirror create -architectures="amd64" xenial-security http://archive.ubuntu.com/ubuntu xenial-security main universe multiverse restricted 2>&1 | sed -e 's/^/    * /'

  echo
  echo "  - Adding Key for KDENeon Xenial"
  gpg --no-default-keyring --keyring trustedkeys.gpg --keyserver keys.gnupg.net --recv-keys E6D4736255751E5D 2>&1 | sed -e 's/^/    * /'
  echo "  - Creating AMD64 Mirror for KDENeon Xenial : kdeneon-xenial"
  aptly mirror create -architectures="amd64" kdeneon-xenial https://archive.neon.kde.org/user/ xenial main 2>&1 | sed -e 's/^/    * /'

  echo
  echo "  - Creating AMD64 Mirror for NXOS : nxos"
  aptly mirror create -architectures="amd64" nxos http://repo.nxos.org/ nxos main 2>&1 | sed -e 's/^/    * /'
}

function updateMirrors() {
  echo "UPDATING MIRRORS"

  case "$1" in
    all)
      TO_BE_UPDATED="xenial xenial-security xenial-update kdeneon-xenial nxos"
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

HELPTEXT="nxos-repository-util : A Simple Tool to manage NXOS repository with Aptly

USAGE :
  nxos-repository-util [OPTION]

OPTIONS :
  -h | --help
  create-amd64-mirrors
  update-mirrors [all | (list of space seperated mirrors)]
"

case "$1" in
  --help|-h)
    echo "$HELPTEXT"
    exit 0
  ;;

  create-amd64-mirrors)
    createAmd64Mirrors
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

  *)
    echo "Error parsing the arguments"
    echo "$HELPTEXT"
    exit 1
  ;;
esac

exit 0