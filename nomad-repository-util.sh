#!/bin/sh

NXOS_PACKAGES=$(paste -s -d '|' PACKAGES)

upload() {
  NXOS_SERVER_URL=http://88.198.66.58/
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
    nomad-desktop-dev|nomad-desktop)
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
      echo "ADDING FILES to $REPO"
      curl -sS -u$APTLY_USERNAME:$APTLY_API_KEY -X POST $NXOS_SERVER_URL/aptly-api/repos/$REPO/file/$REPO-$APTLY_USERNAME 2>&1 | sed -e 's/^/    - /'

      echo
      echo "UPDATING $REPO"
      curl -sS -u$APTLY_USERNAME:$APTLY_API_KEY -X PUT -H 'Content-Type: application/json' --data '{"local": [{"Component": "main"}]}' $NXOS_SERVER_URL/aptly-api/publish/:$REPO/nxos

      echo "DROPING PUBLISHED REPOSITORY $REPO"
      aptly publish drop nxos $REPO

     echo "Droping Snapshot snapshot-$REPO-$DATE"
     aptly snapshot drop snapshot-$REPO-$DATE

     echo "Creating snapshot snapshot-$REPO-$DATE"
     aptly snapshot create snapshot-$REPO-$DATE from repo $REPO

     echo "PUBLISHING LATEST SNAPSHOT"
     aptly publish -distribution="nxos" -component="main" snapshot snapshot-$REPO-$DATE /$REPO

    ;;

    *)
      echo "Invalid Repository"
      exit 1
    ;;
  esac
}

HELPTEXT="nomad-repository-util : A Simple Tool to manage NOMAD-DESKTOP repository with Aptly

USAGE :
  nomad-repository-util [OPTION]

OPTIONS :
  -h | --help                                                       		Print this HELP TEXT
  upload [nomad-desktop-dev | nomad-desktop] [list of space separated files]    Upload Files to the repositories
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
