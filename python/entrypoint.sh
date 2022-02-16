#!/bin/bash

# if [ "$(id -u)" -eq '0' ]
# then
#     USER_ID=${LOCAL_UID:-9001}

#     usermod -u ${USER_ID} -g ${USER_ID} user > /dev/null 2>&1
#     chown -R `id -u user`:`id -u user` /app > /dev/null 2>&1

#     export HOME=/home/user
#     exec gosu user "$0" "$@"
# fi

# exec "$@"

# https://blog.giovannidemizio.eu/2021/05/24/how-to-set-user-and-group-in-docker-compose/

# https://denibertovic.com/posts/handling-permissions-with-docker-volumes/
USER_ID=${LOCAL_UID:-9001}
GROUP_ID=${LOCAL_GID:-9001}

echo "Starting with UID: $USER_ID, GID: $GROUP_ID"
useradd -u $USER_ID -o -m user
groupmod -g $GROUP_ID user
export HOME=/home/user

exec /usr/sbin/gosu user "$@"
