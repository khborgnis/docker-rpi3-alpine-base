#!/bin/bash

# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback

USER_ID=${LOCAL_USER_ID:-1000}
GRP_ID=${LOCAL_GRP_ID:-100}

echo "Starting with UID : $USER_ID   GID : $GRP_ID"
adduser -u 1000 -S -g users user

#
# Change UID / GID of CouchPotato user.
#

printf "Updating UID / GID... "
sed -i "/${USER}/s/1000/${CP_UID}/" /etc/passwd > /dev/null
sed -i "/${GROUP}/s/100/${CP_GID}/" /etc/group > /dev/null
echo "[DONE]"

#
# Set directory permissions.
#

export HOME=/home/user

exec /usr/local/bin/gosu user "$@"
