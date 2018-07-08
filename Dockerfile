FROM debian:stretch

MAINTAINER dongruixuan dongruixuan@hotmail.com
ENV EC_VERSION 2.1-release
EXPOSE 7999
WORKDIR /root/

RUN apt-get update && \
    apt-get install -y software-properties-common dirmngr && \
    apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xF1656F24C74CD1D8 && \
    add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://nyc2.mirrors.digitalocean.com/mariadb/repo/10.3/debian stretch main' && \
    apt-get update && \
    apt-get install -y mariadb-server openjdk-8-jre wget

RUN wget -O /root/encryptedchat.sql https://raw.githubusercontent.com/starcatmeow/EncryptedChat/master/encryptedchat.sql && \
    mysql -uroot -e "CREATE DATABASE encryptedchat;USE encryptedchat;SOURCE /root/encryptedchat.sql;"

RUN wget -O /root/ECServer.jar https://github.com/starcatmeow/EncryptedChat/releases/download/v$EC_VERSION/EncryptedChatServer-$EC_VERSION.jar && \
    echo "{\"rsastrength\":2048,\"servicePort\":7999,\"useMysql\":true,\"accountFile\":\"account.json\",\"mysqlData\":{\"mySQLHost\":\"localhost\",\"mySQLUsername\":\"root\",\"mySQLPassword\":\"\",\"mySQLDatabase\":\"encryptedchat\",\"mySQLPort\":3306,\"useSSL\":false}}" > /root/config/config.json

ENTRYPOINT java -jar /root/ECServer.jar
