#!/bin/bash
#http://www.romania-actualitati.ro/Podcast/o_vorba_buna/14
#1  - Agenda Globală
#2  - Jurnalul de Prânz (not in use)
#3  - Jurnalul de Seară
#4  - Istorica
#5  - Documentarele Radio România Actualităţi
#6  - not in use
#7  - not in use
#8  - Euroatlantica
#9  - Săptămâna Mediteranei (not in use)
#10 - Lumea pe verticală(not in use)
#11 - Radiojurnal (not in use)
#12 - 150 Cuvinte
#13 - Lecția de gramatică (not in use)
#14 - O vorba buna
#15 - Bună ziua căciulă că stăpănul n-are gură.Cod de bune maniere
#16 - Alo? Rubrică satirică scrisă si interpretată de Maria Radu (not in use)
#17 - Poveşti cu care creşti
#18 - La dispoziţia dumneavoastră: Reţeta de sănătate
#20 - Un minut de sănătate
#21 - Semnele lumii
#22 - Probleme la zi
#23 - Europa, încotro ?
#24 - Accente europene
#25 - Serviciul de noapte
#SERII="12 14" # important e 14!

#set -e
cd archive_cron_html/
#for SERIE in ${SERII}; do
for SERIE in {1..25}; do
  curl -sL http://www.romania-actualitati.ro/Podcast/o_vorba_buna/$SERIE | grep mp3 >>cron_${SERIE}_ovb.html
  sort cron_${SERIE}_ovb.html | uniq > cron_${SERIE}_ovb.html_uniq
  mv cron_${SERIE}_ovb.html_uniq cron_${SERIE}_ovb.html
  git add cron_${SERIE}_ovb.html
done
cd -
