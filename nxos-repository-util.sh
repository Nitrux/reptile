#!/bin/sh

NXOS_PACKAGES=$(paste -s -d '|' PACKAGES)

createAmd64Mirrors() {

  echo "CREATING REPOSITORY MIRRORS"

  echo "  - Adding Key for Ubuntu Bionic"
  gpg --no-default-keyring --keyring trustedkeys.gpg --keyserver keys.gnupg.net --recv-keys 40976EAF437D05B5 3B4FE6ACC0B21F32 2>&1 | sed -e 's/^/    * /'
  echo "  - Creating AMD64 Mirror for Ubuntu Bionic : bionic"
  aptly mirror create -filter=$NXOS_PACKAGES -filter-with-deps -architectures="amd64" bionic http://archive.ubuntu.com/ubuntu bionic main universe multiverse restricted 2>&1 | sed -e 's/^/    * /'

  echo
  echo "  - Adding Key for Ubuntu Bionic Security"
  gpg --no-default-keyring --keyring trustedkeys.gpg --keyserver keys.gnupg.net --recv-keys 40976EAF437D05B5 3B4FE6ACC0B21F32 2>&1 | sed -e 's/^/    * /'
  echo "  - Creating AMD64 Mirror for Ubuntu Bionic Security: bionic-security"
  aptly mirror create -filter=$NXOS_PACKAGES -filter-with-deps -architectures="amd64" bionic-security http://archive.ubuntu.com/ubuntu bionic-security main universe multiverse restricted 2>&1 | sed -e 's/^/    * /'

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
      TO_BE_UPDATED="bionic bionic-security kdeneon-bionic"
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

  echo "    - Creating snapshot bionic-security-$DATE"
  aptly snapshot create bionic-security-$DATE from mirror bionic-security

  echo "    - Creating snapshot kdeneon-bionic-$DATE"
  aptly snapshot create kdeneon-bionic-$DATE from mirror kdeneon-bionic

  echo "    - Creating snapshot nxos-$REPO-$DATE"
  aptly snapshot create nxos-$REPO-$DATE from repo $REPO

  echo
  echo "MERGING SNAPSHOTS"
  aptly snapshot merge snapshot-$REPO-$DATE bionic-$DATE bionic-security-$DATE kdeneon-bionic-$DATE nxos-$REPO-$DATE

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
  update-mirrors [all | (list of space separated mirrors)]          Update the Created Mirrors
  upload [development | testing] [list of space separated files]    Upload Files to the repositories
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
