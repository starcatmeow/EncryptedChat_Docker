FROM debian

MAINTAINER dongruixuan dongruixuan@hotmail.com
ENV EC_VERSION 2.1-release
EXPOSE 7999
WORKDIR /root/

RUN apt-get update&&apt-get -y install openjdk-8-jre wget
RUN wget -O /root/ECServer.jar https://github.com/starcatmeow/EncryptedChat/releases/download/v$EC_VERSION/EncryptedChatServer-$EC_VERSION.jar
ENTRYPOINT java -jar /root/ECServer.jar
