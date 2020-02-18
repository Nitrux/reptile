#!/bin/sh

NXOS_PACKAGES=$(paste -s -d '|' PACKAGES)

upload() {
  NXOS_SERVER_URL=https://repo.nxos.org/
  REPO=$1
  DATE=$(date +%Y%m%d)

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
    nitrux)
      if [ -z "$APTLY_USERNAME" -o -z "$APTLY_API_KEY" ]; then
        echo "Requires APTLY_USERNAME and APTLY_API_KEY to be set before uploading file"
        exit 1
      fi

      echo "DELETING Remote Upload Folder"
      curl -A "mozilla" -sS -u$APTLY_USERNAME:$APTLY_API_KEY -X DELETE $NXOS_SERVER_URL/aptly-api/files/$REPO-$APTLY_USERNAME 2>&1 | sed -e 's/^/    - /'

      echo
      echo "UPLOADING FILES"
      curl -A "mozilla" -sS -u$APTLY_USERNAME:$APTLY_API_KEY -X POST $FILE_LIST $NXOS_SERVER_URL/aptly-api/files/$REPO-$APTLY_USERNAME 2>&1 | sed -e 's/^/    - /'

      echo
      echo "ADDING FILES to $REPO"
      curl -A "mozilla" -sS -u$APTLY_USERNAME:$APTLY_API_KEY -X POST $NXOS_SERVER_URL/aptly-api/repos/$REPO/file/$REPO-$APTLY_USERNAME 2>&1 | sed -e 's/^/    - /'

      echo
      echo "DROPING PUBLISHED REPOSITORY $REPO"
      #aptly publish drop nitrux $REPO
      curl -A "mozilla" -sS -u$APTLY_USERNAME:$APTLY_API_KEY -X DELETE $NXOS_SERVER_URL/aptly-api/publish/ubuntu_repos_$REPO/nitrux

      echo
      echo "Droping Snapshot snapshot-$REPO-$DATE"
      #aptly snapshot drop snapshot-$REPO-$DATE
      curl -A "mozilla" -sS -u$APTLY_USERNAME:$APTLY_API_KEY -X DELETE $NXOS_SERVER_URL/aptly-api/snapshots/snapshot-$REPO-$DATE

      echo
      echo "Creating snapshot snapshot-$REPO-$DATE"
      #aptly snapshot create snapshot-$REPO-$DATE from repo $REPO
      curl -A "mozilla" -sS -u$APTLY_USERNAME:$APTLY_API_KEY -X POST -H 'Content-Type: application/json' --data '{"Name":"snapshot-'$REPO'-'$DATE'"}' $NXOS_SERVER_URL/aptly-api/repos/$REPO/snapshots

      echo
      echo "PUBLISHING LATEST SNAPSHOT"
      curl -A "mozilla" -sS -u$APTLY_USERNAME:$APTLY_API_KEY -X POST -H 'Content-Type: application/json' --data '{"SourceKind": "snapshot", "Sources": [{"Name": "snapshot-'$REPO'-'$DATE'"}], "Architectures": ["amd64"], "Distribution": "nitrux"}' $NXOS_SERVER_URL/aptly-api/publish/ubuntu_repos_$REPO

      ;;

    *)
      echo "Invalid Repository"
      exit 1
    ;;
  esac
}

HELPTEXT="nitrux-repository-util : A Simple Tool to manage Nitrux repository with Aptly

USAGE :
  nitrux-repository-util [OPTION]

OPTIONS :
  -h | --help                                                       		Print this HELP TEXT
  upload [nitrux] [list of space separated files]    Upload Files to the repositories
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

  *)
    echo "Error parsing the arguments"
    echo "$HELPTEXT"
    exit 1
  ;;
esac

exit 0
