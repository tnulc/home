# 🏠

Shamelessly stolen from [emilyst/home](https://github.com/emilyst/home). See their [README.md](https://github.com/emilyst/home#home) for the decisions behind this approach to managing the home directory.

## Setup

Set the inital alias.

```sh
alias home="git --work-tree=$HOME --git-dir=$HOME/.home.git"
```

Bootstrap the repo.

```sh
home init
home remote add origin git@github.com:kirisu/home.git
home fetch --all
home reset --hard origin/master
home submodule update --init --rebase
```