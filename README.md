# nxos-repository-util
A Simple Tool to manage Nitrux deb repository with Aptly

<pre>
nxos-repository-util : A Simple Tool to manage NXOS repository with Aptly

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
</pre>
