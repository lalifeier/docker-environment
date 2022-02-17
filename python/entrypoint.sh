#!/bin/bash
set -e

USER=${LOCAL_USER:-user}
USER_ID=${LOCAL_UID:-1000}
GROUP_ID=${LOCAL_GID:-1000}
echo "Starting with UID : $USER_ID, GID: $GROUP_ID,USER: $USER"

if id -u ${USER} >/dev/null 2>&1 ; then
  exec "$@"
  exit
else
  useradd -s /bin/bash -u $USER_ID -o -m $USER
fi

# usermod -u $USER_ID -o -m $USER
groupmod -g $GROUP_ID $USER

export HOME=/home/$USER

exec /usr/sbin/gosu "$USER" "$@"

tail -f /dev/null
