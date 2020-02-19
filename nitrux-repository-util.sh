#! /bin/sh

_server_url=https://repo.nxos.org/
_repo=nitrux
_timestamp=$(date +%Y%m%d)


[ "$APTLY_USERNAME" -a "$APTLY_API_KEY" ] || {
	echo "Please set APTLY_USERNAME and APTLY_API_KEY before uploading files."
	exit 1
}


case "$1" in
	--help|-h)
		echo "${0##*/}: Upload files to https://repo.nxos.org."
		echo "Usage: ${0##*/} [-h|--help] <files>"
		exit
	;;
esac


[ "$@" ] || {
	echo "No files provided. Provide at least one."
	exit 1
}


for f in "$@"; do
	[ -f "$f" ] || {
		echo "'$f' is not a file. Aborting."
		exit 1
	}

	_files="$_files -F file=@$(realpath '$f')"
done

echo
echo "Deleting remote updload directory."
curl -A "mozilla" -sS -u$APTLY_USERNAME:$APTLY_API_KEY -X DELETE $_server_url/aptly-api/files/$_repo-$APTLY_USERNAME

echo
echo "Uploading files."
curl -A "mozilla" -sS -u$APTLY_USERNAME:$APTLY_API_KEY -X POST $_files $_server_url/aptly-api/files/$_repo-$APTLY_USERNAME

echo
echo "Adding files to repository '$_repo'."
curl -A "mozilla" -sS -u$APTLY_USERNAME:$APTLY_API_KEY -X POST $_server_url/aptly-api/repos/$_repo/file/$_repo-$APTLY_USERNAME

echo
echo "Dropping published repository '$_repo'."
#aptly publish drop nitrux $_repo
curl -A "mozilla" -sS -u$APTLY_USERNAME:$APTLY_API_KEY -X DELETE $_server_url/aptly-api/publish/$_repo/nitrux

echo
echo "Droping Snapshot snapshot-$_repo-$_timestamp"
#aptly snapshot drop snapshot-$_repo-$_timestamp
curl -A "mozilla" -sS -u$APTLY_USERNAME:$APTLY_API_KEY -X DELETE $_server_url/aptly-api/snapshots/snapshot-$_repo-$_timestamp

echo
echo "Creating snapshot 'snapshot-$_repo-$_timestamp'."
#aptly snapshot create snapshot-$_repo-$_timestamp from repo $_repo
curl -A "mozilla" -sS -u$APTLY_USERNAME:$APTLY_API_KEY -X POST -H 'Content-Type: application/json' --data '{"Name":"snapshot-'$_repo'-'$_timestamp'"}' $_server_url/aptly-api/repos/$_repo/snapshots

echo
echo "Publishing..."
curl -A "mozilla" -sS -u$APTLY_USERNAME:$APTLY_API_KEY -X POST -H 'Content-Type: application/json' --data '{"SourceKind": "snapshot", "Sources": [{"Name": "snapshot-'$_repo'-'$_timestamp'"}], "Architectures": ["amd64"], "Distribution": "nitrux"}' $_server_url/aptly-api/publish/ubuntu_repos_$_repo
