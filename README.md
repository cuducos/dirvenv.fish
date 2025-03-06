# `dirvenv`

[Fish shell](https://fishshell.com/) tooling to automagically activate and deactivate Python's _virtualenv_ when moving between directories.

> :warning: This is a Fish shell script, it will not work on Bash or Zsh.

For example, let's say you have a project in `~/my-project` with a _virtualenv_ inside:

```console
~ $  # note that no virtualenv is active
~ $ cd ~/my-project
(.venv) my-project $  # note that the virtualenv was activated
(.venv) my-project $ cd ~
~ $  # now the virtualenv is deactivated
```

## Features

### It looks for `venv` and `.venv`

In the future we can add a more (customizable) options, but by now these are the defaults.

### It only deactivates a _virtualenv_ that was activated automatically

If you manually activates a _virtualenv_, `dirvenv` will not deactivate it.

### It detects _virtualenv_ above the current directory in the tree

For example, if you have `~/my-project/.venv` and you `cd ~/my-project/tests`, it will activate the _virtualenv_ in the parent directory (recursively).

### It is session-aware

If you have more than one shell, `dirvenv` from one shell will not mess up with the magic in the other shells.

## Install

Probably it works with [Fisher](https://github.com/jorgebucaran/fisher), but I haven't tested it myself:

```console
$ fisher install cuducos/dirvenv.fish
```

Alternatively you can use the `install.fish` script:

```console
$ curl https://raw.githubusercontent.com/cuducos/dirvenv.fish/refs/heads/main/install.fish | source
```

### Uninstall

Similarly, just remove `dirvenv.fish` from `~/.config/fish/conf.d` and `~/config/fish/functions` or use the `uninstall.fish` script:

```console
$ curl -LO https://raw.githubusercontent.com/cuducos/dirvenv.fish/refs/heads/main/uninstall.fish
$ source uninstall.fish
$ rm uninstall.fish
```

## Acknowledgements

Thank you, [`direnv`](https://github.com/direnv/direnv)! The similarity in the name is intentional, the user experience of `direnv` is so great I wanted to offer the same seamless smooth experience with `dirvenv` : )
