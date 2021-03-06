# dotfiles

My configuration files (dotfiles) for anyone that is interested.

## Repository Structure

For the most part the whole repository is meant to be symbolically linked into
my home directory.  This means that `vimrc` will be linked to `~/.vimrc` and
`config/` will be linked to `~/.config/`, the `bin/` directory however gets
linked without the leading dot (i.e. `~/bin/`).  Files that don't follow this
scheme are `install.sh`, `README.md`, `.gitignore`, the `ssh/` directory and
anything under `etc/`.

In the case of the `ssh/` directory, the ssh config file is linked itself as
opposed to the whole directory because the directory may contain other sensitive
information. I feel it is easier to ensure correct permissions for the `~/.ssh/`
directory if done this way, so I think this is a better solution than linking
the directory and ignoring everything inside of it.

The files under `etc/` are files that help me configure my setup system-wide
(such as udev rules) and are unlikely to be used on a system where root access
is not permitted.  The structure of the `etc/` folder is setup to match that of
the system, and instead of linking these I copy them to where they need to be in
the event that I need them.

### Vim Configuration

If you're here for my Vim configuration, make sure you check out the `vim/`
directory in addition to the `vimrc` file.  There are a bunch of useful bits in
those files and some of them are even required for things that are in my
`vimrc`.  I can't stop you from just blindly copying my `vimrc` and using it,
but if you do I recommend you at least try to understand what it's doing.  I
have tried to comment it fairly well so just reading the file should give you a
pretty good understanding of it.

## Installing

The file `install.sh` is used to link these files to their correct places. By
default the script runs in interactive mode, prompting whether or not to install
each group of files. The install script provides a few options for different
install cases (all, skipping interactive mode; force, relink already installed
files), read the script itself or run `install.sh -h` for more information.

## Usage

Anything on here can be used for free (unless otherwise noted of course), have
fun.
