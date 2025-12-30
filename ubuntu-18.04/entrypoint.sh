#!/bin/bash

USER_UID=${UID:-$(id -u)}
USER_GID=${GID:-$(id -g)}
USER_NAME=${USER:-"user"}

# install packages, env or file
if id -Gn | grep &>/dev/null '\bsudo\b' || [ "$(id -u)" -eq 0 ]; then
  if [ -n "$PACKAGES_LIST" ]; then
    sudo apt-get update
    sudo apt-get install -qy --no-install-recommends $PACKAGES_LIST
  fi
  if [ -s /packages.list ]; then
    sudo apt-get update
    sudo apt-get install -qy --no-install-recommends $(cat /packages.list)
  fi

  # drop sudo privilege
  sudo /bin/rm -f /etc/sudoers.d/priv_sudo

  # when running with root privilege
  # allow auto create missing group and user with gid & uid
  if [ "$(id -u)" -eq 0 ]; then
    if ! getent group $USER_GID &>/dev/null; then
      groupadd -g "$USER_GID" "group_$USER_GID"
    fi

    if ! getent passwd $USER_UID &>/dev/null; then
      useradd -u "$USER_UID" -g "$USER_GID" -m "$USER_NAME"
      echo $USER_NAME:123 | chpasswd
    fi
  fi
fi

exec "$@"
