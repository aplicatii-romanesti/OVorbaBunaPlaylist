
docker run -d --name rec -v /home/d/OVorbaBuna:/r cjkas/maven-oracle-jdk tail -f /dev/null

docker exec -ti rec bash

## Prepare mp3 & wav files:
mkdir -p /r/mp3 /r/wav
cd /r/mp3

for x in 
do
  wget http://media.3netmedia.ro/media/RRAOnline/audio/${x}
done

for x in 
do
  ffmpeg -i /r/mp3/${x} -acodec pcm_s16le -ac 1 -ar 16000 /r/wav/${x}.wav
done


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
java -cp .:/r/recognito*.jar Reco


