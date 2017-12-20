set -e
cd /tmp/
eval $(ssh-agent -s)
ssh-add ~/.ssh/aplicatii-romanesti
mv ~/.gitconfig ~/.gitconfig.cron
git config --global user.name aplicatii-romanesti
git config --global user.email aplicatii.romanesti@gmail.com
git config --global github.user aplicatii-romanesti
git config --global github.email aplicatii.romanesti@gmail.com

git clone https://github.com/aplicatii-romanesti/OVorbaBunaPlaylist.git
cd OVorbaBunaPlaylist
curl -sL http://www.romania-actualitati.ro/Podcast/o_vorba_buna/14 | grep mp3 >>cron_14_ovb.html
sort cron_14_ovb.html | uniq > cron_14_ovb.html_uniq
mv cron_14_ovb.html_uniq cron_14_ovb.html
git add cron_14_ovb.html
git commit -m"`date`" --author "aplicatii-romanesti"
git push
mv ~/.gitconfig.cron ~/.gitconfig

