#dotfiles
My configuration files (dotfiles) for anyone that is interested.

##Repository Structure
For the most part the whole repository is meant to be symbolically linked into my home directory.
Files that don't follow this scheme are `install.sh`, `README.md`, `.gitignore`, `.gitattributes` and more which are found under `etc/`.
The files under `etc/` are files that help me configure my setup system-wide (such as udev rules) and are unlikely to be used on a system where root access is not permitted, the structure of the `etc/` folder is setup to match that on the system.

##Installing
The file `install.sh` is used to link these files to their correct places.
The install script provides a few options for different install cases, read the script itself or run `install.sh -h` for more information.

Note: when `.gitconfig` is installed the bash script in `bin/hasGitPushSimple.sh` will run in order to set the value of push.default to either 'simple' or 'upstream' depending on what the system's version of git supports.

##Usage
Anything on here can be used for free, have fun.
