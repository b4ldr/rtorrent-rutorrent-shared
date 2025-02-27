#!/usr/bin/env sh

set -x

# set rtorrent user and group id
RT_UID=${USR_ID:=1000}
RT_GID=${GRP_ID:=1000}

# update uids and gids
addgroup -g $RT_GID rtorrent
adduser -u $RT_UID -G rtorrent -h /home/rtorrent -m -s /bin/sh rtorrent

# arrange dirs and configs
mkdir -p /downloads/.rtorrent/session 
mkdir -p /downloads/.rtorrent/watch
mkdir -p /downloads/.log/rtorrent
if [ ! -e /downloads/.rtorrent/.rtorrent.rc ]; then
    cp /root/.rtorrent.rc /downloads/.rtorrent/
fi
ln -s /downloads/.rtorrent/.rtorrent.rc /home/rtorrent/
chown -R rtorrent:rtorrent /downloads/.rtorrent
chown -R rtorrent:rtorrent /home/rtorrent
chown -R rtorrent:rtorrent /downloads/.log/rtorrent

rm -f /downloads/.rtorrent/session/rtorrent.lock

# run
su --login --command="TERM=xterm rtorrent" rtorrent 

