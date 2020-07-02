#! /bin/bash

server_url="https://repo.nxos.org/"
repo=nitrux
timestamp=$(date +%Y%m%d)


put () { printf "\e[32m%b\e[0m\n" "$@"; }


case "$1" in
	--help|-h)
		put "${0##*/}: upload packages to https://repo.nxos.org."
		put "usage: ${0##*/} [-h|--help] <files>"
		exit
	;;
esac


test "$APTLY_USERNAME" -a "$APTLY_API_KEY" || {
	put "please set 'APTLY_USERNAME' and 'APTLY_API_KEY' before uploading files."
	put "ask luis for them."
	exit 1
}


for f in "$@"; do
	test -f "$f" || {
		echo "'$f' is not a file. aborting."
		echo "usage: ${0##*/} [-h|--help] <files>"
		exit 1
	}
done


put "deleting remote upload directory."
curl -A "mozilla" \
	-sS -u"$APTLY_USERNAME:$APTLY_API_KEY" \
	-X DELETE \
	"$server_url"/aptly-api/files/upload-tmp


put "uploading files."
	for f in "$@"; do shift; set -- "$@" -F file="@$f"; done
	curl -A "mozilla" \
		-sS -u"$APTLY_USERNAME:$APTLY_API_KEY" \
		-X POST "$@" \
		"$server_url"/aptly-api/files/upload-tmp


put "adding files to '$repo'."
curl -A "mozilla" \
	-sS -u"$APTLY_USERNAME:$APTLY_API_KEY" \
	-X POST \
	"$server_url"/aptly-api/repos/"$repo"/file/upload-tmp


put "updating repository."
curl -A "mozilla" \
	-sS -u"$APTLY_USERNAME:$APTLY_API_KEY" \
	-X PUT \
	-H 'Content-Type: application/json' \
	--data '{ "SourceKind": "local" }' \
	"$server_url"/aptly-api/publish/"$repo"/nitrux


put "done."
