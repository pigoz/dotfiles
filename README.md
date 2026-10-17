pigoz's dotfiles
================

My Mac setup. They aren't made to be used by other people, but I hope they
are at least useful as reference.

On a new Mac, from Terminal.app before opening iTerm2:

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    git clone https://github.com/pigoz/dotfiles ~/dev/dotfiles
    ~/dev/dotfiles/bootstrap

`bootstrap` installs the Brewfile, links the dotfiles into `~`, points iTerm2
at `config/iterm2`, installs the runtimes with mise, restores the secrets from
Bitwarden, clones my repos into `~/dev` and logs in to gh and gcloud. It's
safe to run again.

Secrets that can't live in this repo (ssh and age keys, `~/.localrc`, the
`.env` and `master.key` files that git ignores in my repos) are kept in
Bitwarden with `secrets push` / `secrets pull`; the shell says when they need
a push.
