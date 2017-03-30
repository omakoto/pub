#!/bin/bash

set -

run() {
  echo "$@"
  "$@"
}
echo "Installing necessary packages..."
sudo apt-get install -y git-core gnupg ssh xclip perl curl wget

if [[ ! -d $HOME/.ssh ]] ; then
  echo "Downloading ssh keys..."
  run cd $HOME
  run wget http://cloud.omakoto.org/bootstrap/dot_ssh.tgz.gpg
  run gpg -d --output dot_ssh.tgz dot_ssh.tgz.gpg
  run /bin/sh dot_ssh.tgz
  run rm -f dot_ssh.*
fi

run mkdir -p $HOME/local-makoto
test -d /usr/local/makoto || run sudo ln -sf $HOME/local-makoto /usr/local/makoto
test -d /usr/local/makoto/cbin || run ln -sf --no-dereference $HOME/cbin /usr/local/makoto/cbin

run mkdir -p $HOME/cbin
run cd $HOME/cbin
run git clone omakoto@cloud.omakoto.org:git/cbin.git .
run ./cbin-fix-permission.sh
run git submodule init
run git submodule update

run ./dot-files-link
