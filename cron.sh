#!/bin/bash
set -e
cd /tmp/
eval $(ssh-agent -s)
ssh-add ~/.ssh/aplicatii-romanesti
mv ~/.gitconfig ~/.gitconfig.cron
git config --global user.name aplicatii-romanesti
git config --global user.email aplicatii.romanesti@gmail.com
git config --global github.user aplicatii-romanesti
git config --global github.email aplicatii.romanesti@gmail.com

git clone git@github.com:aplicatii-romanesti/OVorbaBunaPlaylist.git
cd OVorbaBunaPlaylist

chmod +x ./cron_tash.sh
./cron_tash.sh
git add .

git commit -m"`date`" --author "aplicatii-romanesti"
git push
mv ~/.gitconfig.cron ~/.gitconfig

