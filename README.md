# Nitrux repository utility.

> The easiest, no-nonsense, nonfancy tool to manage Debian repositories.

This system consists of two programs: `reptile` and `boa`. `reptile` has to
be available on `$PATH` on the server; `boa` is what you use to manage the
repository. `boa` works through `ssh`.

## Installation.

### Install boa locally.

Assuming `~/.local/bin/` is contained in `$PATH`:
```
$ curl https://raw.githubusercontent.com/Nitrux/reptile/master/boa > ~/.local/bin/boa
$ chmod +x ~/.local/bin/boa
```

### Install reptile on the server.
```
$ ssh my-server
root@my-server # curl https://raw.githubusercontent.com/Nitrux/reptile/master/reptile > /bin/reptile
root@my-server # chmod +x /bin/reptile
```

## Usage.

```
$ boa
Usage: boa <remote> <command [args]>

command is any of:

  mk <repo>              Create a new repository.
  cp <pkg> <repo>        Add a package to a repository.
  rm <repo> [pkg]        Remove a repository or package that belongs to a repository.
  mv <pkg> <from> <to>   Move a package from a repository to another.
  mv <old> <new>         Rename a repository.
  ls [repo] [pkg]        List the contents of a repository or a package. If no
                         arguments are provided, list all repositories.
 ```

# Issues
If you find problems with the contents of this repository please create an issue.

©2018 Nitrux Latinoamericana S.C.
