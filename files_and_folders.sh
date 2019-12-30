# This file contains the files and folders which will be symlinked into the home
# directory with the makesymlinks.sh script.

# files and folders which should start with a dot when symlinked
# list of dot files to symlink in homedir
dot_files="aliases profile gitconfig gitignore_global gitignore gitk viminfo Rprofile tmux.conf ctags env_exporter global_python_requirements"
# list of dot folders to symlink in homedir
# Todo: this isn't working -- figure out why
# dot_folders="vim"
# all files/folders which start with a dot
dot_links="$dot_folders $dot_files"

# files and folders which should not start with a dot when symlinked
# list of nondot files to symlink in homedir
nondot_files="git-completion.bash"
# list of nondot folders to symlink in homedir
nondot_folders="vimtmpdir vimbackup"
nondot_links="$nondot_files $nondot_folders"
