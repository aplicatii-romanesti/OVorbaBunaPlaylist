#!/bin/bash
set -e
set -v
cd /tmp/
PRJ=OVorbaBunaPlaylist
rm -rf ${PRJ}
eval $(ssh-agent -s)
ssh-add ~/.ssh/aplicatii-romanesti
mv ~/.gitconfig ~/.gitconfig.cron
git config --global user.name aplicatii-romanesti
git config --global user.email aplicatii.romanesti@gmail.com
git config --global github.user aplicatii-romanesti
git config --global github.email aplicatii.romanesti@gmail.com

git clone git@github.com:aplicatii-romanesti/${PRJ}.git
cd ${PRJ}

chmod +x ./cron_task.sh
./cron_task.sh
git add .

git commit -m"`date`" --author "aplicatii-romanesti"
git push
mv ~/.gitconfig.cron ~/.gitconfig
