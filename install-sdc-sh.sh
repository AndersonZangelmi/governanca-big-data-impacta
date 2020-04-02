#!/bin/bash
#
#DOWNLOAD PACOTE STREAMSETS
#
wget https://s3-us-west-2.amazonaws.com/archives.streamsets.com/datacollector/3.13.0/rpm/el6/streamsets-datacollector-3.13.0-el6-all-rpms.tar
#
#DESCOMPACTACAO PACOTE
#
tar -xvf streamsets-datacollector-3.13.0-el6-all-rpms.tar
#
#ENTRAR NA PASTA DO PACOTE
#
cd streamsets-datacollector-3.13.0-el6-all-rpms
#
#INSTALAR PACOTES
#
sudo yum localinstall streamsets*.rpm -y
#
#
#ADICIONAR LINHA DE CONFIGURACAO NO JAVA_HOME 8 PARA START DO SDC
#ADICIONAR TAMBEM LINHA DE CONFIGURACAO DE LIMITS DO LINUX
#
sudo sed -i '37 i\export JAVA_HOME="/usr/lib/jvm/jre-1.8.0-openjdk.x86_64"' >> /etc/init.d/sdc
sudo sed -i '38 i\ulimit -n 32768' >> /etc/init.d/sdc
#
#ADD JDBC DRIVER TO SDC
#
sudo cp /usr/lib/sentry/lib/mysql-connector-java.jar /opt/streamsets-datacollector/streamsets-libs/streamsets-datacollector-jdbc-lib/lib/
#
#REMOVE FILE PID
#
sudo /var/lib/sdc/sdc.pid
#
#START STATUS
#
sudo service sdc status
sudo service sdc start
sudo service sdc status
