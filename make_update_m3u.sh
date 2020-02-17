#!/usr/bin/env bash

###########
SET=O_Vorba_Buna_Remus_Radulescu
CAT=14
grep 'http://media.3netmedia.ro/media/RRAOnline/audio/' archive_cron_html/cron_${CAT}_ovb.html | cut -d'"' -f8 > ${SET}_Radio_Romania_Actualitati_Playlist_Arhiva_all.m3u.tmp
uniq ${SET}_Radio_Romania_Actualitati_Playlist_Arhiva_all.m3u.tmp > ${SET}_Radio_Romania_Actualitati_Playlist_Arhiva_all.m3u.tmp.tmp
tac ${SET}_Radio_Romania_Actualitati_Playlist_Arhiva_all.m3u.tmp.tmp > ${SET}_Radio_Romania_Actualitati_Playlist_Arhiva_all.m3u
echo "# OLDER from archive.org" >> ${SET}_Radio_Romania_Actualitati_Playlist_Arhiva_all.m3u
grep '^http://media.3netmedia.ro/media/RRAOnline/audio/' ${SET}_Radio_Romania_Actualitati_Playlist_Arhiva_recovered_archive_org.m3u >> ${SET}_Radio_Romania_Actualitati_Playlist_Arhiva_all.m3u
echo "# OLDER manual recovered" >> ${SET}_Radio_Romania_Actualitati_Playlist_Arhiva_all.m3u
grep '^http://media.3netmedia.ro/media/RRAOnline/audio/' ${SET}_Radio_Romania_Actualitati_Playlist_Arhiva_recovered_manual.m3u >> ${SET}_Radio_Romania_Actualitati_Playlist_Arhiva_all.m3u
# Add silence
cat ${SET}_Radio_Romania_Actualitati_Playlist_Arhiva_all.m3u | sort -n | uniq | awk ' {print;} { print "https://raw.githubusercontent.com/aplicatii-romanesti/OVorbaBunaPlaylist/master/silence7s.mp3"; }' > ${SET}_Radio_Romania_Actualitati_Playlist_Arhiva_all.m3u.tmp
mv ${SET}_Radio_Romania_Actualitati_Playlist_Arhiva_all.m3u.tmp ${SET}_Radio_Romania_Actualitati_Playlist_Arhiva_all.m3u

############
SET=O_150_Cuvinte
CAT=12
grep 'http://media.3netmedia.ro/media/RRAOnline/audio/' archive_cron_html/cron_${CAT}_ovb.html | cut -d'"' -f8 > ${SET}_Radio_Romania_Actualitati_Playlist_Arhiva_all.m3u.tmp
uniq ${SET}_Radio_Romania_Actualitati_Playlist_Arhiva_all.m3u.tmp > ${SET}_Radio_Romania_Actualitati_Playlist_Arhiva_all.m3u.tmp.tmp
tac ${SET}_Radio_Romania_Actualitati_Playlist_Arhiva_all.m3u.tmp.tmp > ${SET}_Radio_Romania_Actualitati_Playlist_Arhiva_all.m3u
echo "# OLDER from archive.org - TODO" >> ${SET}_Radio_Romania_Actualitati_Playlist_Arhiva_all.m3u
#TODO: grep '^http://media.3netmedia.ro/media/RRAOnline/audio/' ${SET}_Radio_Romania_Actualitati_Playlist_Arhiva_recovered_archive_org.m3u >> ${SET}_Radio_Romania_Actualitati_Playlist_Arhiva_all.m3u
echo "# OLDER manual recovered" >> ${SET}_Radio_Romania_Actualitati_Playlist_Arhiva_all.m3u
grep '^http://media.3netmedia.ro/media/RRAOnline/audio/' ${SET}_Radio_Romania_Actualitati_Playlist_Arhiva_recovered_manual.m3u >> ${SET}_Radio_Romania_Actualitati_Playlist_Arhiva_all.m3u
# Add Silence
cat ${SET}_Radio_Romania_Actualitati_Playlist_Arhiva_all.m3u | sort -n | uniq | awk ' {print;} { print "https://raw.githubusercontent.com/aplicatii-romanesti/OVorbaBunaPlaylist/master/silence7s.mp3"; }' > ${SET}_Radio_Romania_Actualitati_Playlist_Arhiva_all.m3u.tmp
mv ${SET}_Radio_Romania_Actualitati_Playlist_Arhiva_all.m3u.tmp ${SET}_Radio_Romania_Actualitati_Playlist_Arhiva_all.m3u

