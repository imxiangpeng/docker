#!/bin/bash

# install packages, env or file
if id -Gn | grep &>/dev/null '\bsudo\b'; then
  if [ -n "$PACKAGES_LIST" ]; then
    sudo apt-get update
    sudo apt-get install -qy --no-install-recommends $PACKAGES_LIST
  fi
  if [ -f /packages.list ]; then
    sudo apt-get update
    sudo apt-get install -qy --no-install-recommends $(cat /packages.list)
  fi

# drop sudo privilege
sudo /bin/rm -f /etc/sudoers.d/priv_sudo
fi

exec "$@"
