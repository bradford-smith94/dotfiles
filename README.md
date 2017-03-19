# dotfiles
My configuration files (dotfiles) for anyone that is interested.

## Repository Structure
For the most part the whole repository is meant to be symbolically linked into my home directory.
This means that `vimrc` will be linked to `~/.vimrc` and `config/` will be linked to `~/.config/`, the `bin/` directory however gets linked without the leading dot (i.e. `~/bin/`).
Files that don't follow this scheme are `install.sh`, `README.md`, `.gitignore`, `.gitattributes`, anything under `.hooks/` and anything under `etc/`.

The files under `etc/` are files that help me configure my setup system-wide (such as udev rules) and are unlikely to be used on a system where root access is not permitted.
The structure of the `etc/` folder is setup to match that of the system, and instead of linking these I copy them to where they need to be in the event that I need them.
The `.hooks/` directory holds git hooks useful for working in this repository, that should be copied into `.git/hooks/` if desired.

### Vim Configuration
If you're here for my Vim configuration, make sure you check out the `vim/` directory in addition to the `vimrc` file.
There are a bunch of useful bits in those files and some of them are even required for things that are in my `vimrc`.
I can't stop you from just blindly copying my `vimrc` and using it, but if you do I recommend you at least try to understand what it's doing.
I have tried to comment it fairly well so just reading the file should give you a pretty good understanding of it.

### Regarding Git Configuration
I have included an interesting git hook in this repository (`.hook/post-merge`).
This is because I have a somewhat unusual and over-complicated git configuration.
In an effort to be portable I have made my git configuration work with versions that do not support git's `push.default = simple` option.
I didn't really need to do this (99% of the systems I use have a version of git new enough to have that option), and some day I may change it, but for now this is how it is.

So I have a git filter setup using `.gitattributes` which gets git to ignore the `push.default` line, and I have `bin/hasGitPushSimple.sh` to set it.
The problem is that anytime `gitconfig` gets updated and pulled `bin/hasGitPushSimple.sh` needs to be re-run, this becomes tedious so I have automated it using the `.hooks/post-merge` hook.

## Installing
The file `install.sh` is used to link these files to their correct places.
The install script provides a few options for different install cases, read the script itself or run `install.sh -h` for more information.

Note: when `.gitconfig` is installed the bash script in `bin/hasGitPushSimple.sh` will run in order to set the value of 'push.default' to either 'simple' or 'upstream' depending on what the system's version of git supports.

## Usage
Anything on here can be used for free, have fun.
