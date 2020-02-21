#! /bin/sh

_server_url=https://repo.nxos.org/
_repo=nitrux
_timestamp=$(date +%Y%m%d)


[ "$APTLY_USERNAME" -a "$APTLY_API_KEY" ] || {
	echo "Please set 'APTLY_USERNAME' and 'APTLY_API_KEY' before uploading files."
	echo "Ask the system administrator for them."
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


printf "\n\nDeleting remote upload directory.\n"
curl -A "mozilla" \
	-sS -u$APTLY_USERNAME:$APTLY_API_KEY \
	-X DELETE \
	$_server_url/aptly-api/files/upload-tmp


printf "\n\nUploading files.\n"
curl -A "mozilla" \
	-sS -u$APTLY_USERNAME:$APTLY_API_KEY \
	-X POST $_files \
	$_server_url/aptly-api/files/upload-tmp


printf "\n\nAdding files to repository '$_repo'.\n"
curl -A "mozilla" \
	-sS -u$APTLY_USERNAME:$APTLY_API_KEY \
	-X POST \
	$_server_url/aptly-api/repos/$_repo/file/upload-tmp


# printf "\n\nDropping published repository '$_repo'.\n"
# curl -A "mozilla" \
	# -sS -u$APTLY_USERNAME:$APTLY_API_KEY \
	# -X DELETE \
	# $_server_url/aptly-api/publish/$_repo/nitrux


printf "\n\nUpdating repository.\n"
curl -A "mozilla" \
	-sS -u$APTLY_USERNAME:$APTLY_API_KEY \
	-X PUT \
	-H 'Content-Type: application/json' \
	--data '{ "SourceKind": "local" }' \
	$_server_url/aptly-api/publish/$_repo

# curl -A "mozilla" \
	# -sS -u$APTLY_USERNAME:$APTLY_API_KEY \
	# -X POST \
	# -H 'Content-Type: application/json' \
	# --data '{
		# "SourceKind": "local",
		# "Sources": [ {"Name": "snapshot-'$_repo'-'$_timestamp'"} ],
		# "Architectures": ["amd64"],
		# "Distribution": "nitrux"
	# }' \
	# $_server_url/aptly-api/publish/$_repo


printf "\n\nPUBLISHED.\n"
