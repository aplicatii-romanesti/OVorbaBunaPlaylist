docker run -d --name rec -v /home/d/OVorbaBuna:/r cjkas/maven-oracle-jdk tail -f /dev/null

docker exec -ti rec bash

apt update
apt install -y ffmpeg sox vim

## Prepare mp3 & wav files:
mkdir -p /r/mp3 /r/wav
cd /r/mp3

LIST="127068 127069 127091 127092 127093 127094 127095 127096"

for x in $LIST
do
  wget http://media.3netmedia.ro/media/RRAOnline/audio/${x}.mp3
done

for x in $LIST
do
  ffmpeg -i /r/mp3/${x}.mp3 -acodec pcm_s16le -ac 1 -ar 16000 /r/wav/${x}.wav
done

newfile(){
	for x in $*
	do
		wget http://media.3netmedia.ro/media/RRAOnline/audio/${x}.mp3 -O /r/mp3/${x}.mp3
		ffmpeg -i /r/mp3/${x}.mp3 -acodec pcm_s16le -ac 1 -ar 16000 /r/wav/${x}.wav
	done
}

## This is a known good file (sample from the voice we are looking for):
cp /r/wav/127068.wav /r/wav/127068_sample.wav

## Compile the recognito library:
cd /r
git clone https://github.com/amaurycrickx/recognito.git
cd recognito/recognito
mvn package
cp target/recognito-0.1.0-SNAPSHOT.jar /r/
cd /r
rm -rf recognito/recognito

## Compile our code, using the library
cd /r
git clone https://github.com/aplicatii-romanesti/OVorbaBunaPlaylist.git
cd /r/OVorbaBunaPlaylist
javac -cp /r/recognito*.jar Reco.java

## Run our code, using the library
cd /r/OVorbaBunaPlaylist
java -cp .:/r/recognito-0.1.0-SNAPSHOT.jar Reco

javac -cp /r/recognito*.jar Reco.java && java -cp .:/r/recognito-0.1.0-SNAPSHOT.jar Reco


f(){
	x=$1
	if [[ -r /r/mp3/${x}.mp3 ]]; then
		return
	fi
	wget http://media.3netmedia.ro/media/RRAOnline/audio/${x}.mp3 -O /r/mp3/${x}.mp3
	ffmpeg -i /r/mp3/${x}.mp3 -acodec pcm_s16le -ac 1 -ar 16000 /r/wav/${x}.wav
} 

while read p; do
  #set -vx
  X=$(echo $p | cut -d, -f1)
  echo "->>>>>>>>>>>>>>>>>>>>>>>>>>>> $X <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<---"
  f ${X}
    #newfile $X
done <names_for_100K_2M.txt
set +vx


while read p; do
  #set -vx
  X=$(echo $p | cut -d"," -f1)
  echo "->>>>>>>>>>>>>>>>>>>>>>>>>>>> $X <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<---"
  #echo "$X"
  f ${X}
    #newfile $X
done <names_for_100K_2M.txt > 01M_2M.txt


for X in $(cat 01M_2M.txt); do 
  echo "->>>>>>>>>>>>>>>>>>>>>>>>>>>> $X <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<---"
  f ${X}
done


javac -cp /r/recognito*.jar Reco.java

docker exec -ti rec bash
cd /r/OVorbaBunaPlaylist

date; time java -cp .:/r/recognito-0.1.0-SNAPSHOT.jar Reco /r/wav/b7/ /r/wav/known_good_samples/ | tee /r/OVorbaBunaPlaylist/results/b7.txt ;date
date; time java -cp .:/r/recognito-0.1.0-SNAPSHOT.jar Reco /r/wav/b8/ /r/wav/known_good_samples/ | tee /r/OVorbaBunaPlaylist/results/b8.txt ;date
date; time java -cp .:/r/recognito-0.1.0-SNAPSHOT.jar Reco /r/wav/b9/ /r/wav/known_good_samples/ | tee /r/OVorbaBunaPlaylist/results/b9.txt ;date
date; time java -cp .:/r/recognito-0.1.0-SNAPSHOT.jar Reco /r/wav/b10/ /r/wav/known_good_samples/ | tee /r/OVorbaBunaPlaylist/results/b10.txt ;date
date; time java -cp .:/r/recognito-0.1.0-SNAPSHOT.jar Reco /r/wav/b11/ /r/wav/known_good_samples/ | tee /r/OVorbaBunaPlaylist/results/b11.txt ;date
date; time java -cp .:/r/recognito-0.1.0-SNAPSHOT.jar Reco /r/wav/b12/ /r/wav/known_good_samples/ | tee /r/OVorbaBunaPlaylist/results/b12.txt ;date

for x in *.txt
do
	grep , $x | tr -d [a-z] | tr -d '.' > $x.csv
done