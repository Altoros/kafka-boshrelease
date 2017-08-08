#!/bin/bash
PASSWORD=123456
VALIDITY=365
openssl req -new -x509 -keyout ca-key -out ca-cert -days $VALIDITY -batch -nodes -subj "/CN=Konstantin Burtsev/OU=RnD/O=Altoros/L=Minsk/ST=Minsk/C=BY"

keytool -keystore kafka.server.keystore.jks -genkey -noprompt -alias localhost -dname "CN=Konstantin Burtsev, OU=RnD, O=Altoros, L=Minsk, ST=Minsk, C=BY" -validity $VALIDITY -storepass $PASSWORD -keypass $PASSWORD
keytool -keystore kafka.client.keystore.jks -genkey -noprompt -alias localhost -dname "CN=Konstantin Burtsev, OU=RnD, O=Altoros, L=Minsk, ST=Minsk, C=BY" -validity $VALIDITY -storepass $PASSWORD -keypass $PASSWORD

keytool -keystore kafka.server.truststore.jks -import -noprompt -alias CARoot -file ca-cert -storepass $PASSWORD
keytool -keystore kafka.client.truststore.jks -import -noprompt -alias CARoot -file ca-cert -storepass $PASSWORD

keytool -keystore kafka.server.keystore.jks -certreq -noprompt -alias localhost -file cert-file-server -storepass $PASSWORD
openssl x509 -req -CA ca-cert -CAkey ca-key -in cert-file-server -out cert-signed -days $VALIDITY -CAcreateserial
keytool -keystore kafka.server.keystore.jks -import -noprompt -alias CARoot -file ca-cert -storepass $PASSWORD
keytool -keystore kafka.server.keystore.jks -import -noprompt -alias localhost -file cert-signed -storepass $PASSWORD

keytool -keystore kafka.client.keystore.jks -certreq -noprompt -alias localhost -file cert-file-client -storepass $PASSWORD
openssl x509 -req -CA ca-cert -CAkey ca-key -in cert-file-client -out cert-signed -days $VALIDITY -CAcreateserial
keytool -keystore kafka.client.keystore.jks -import -noprompt -alias CARoot -file ca-cert -storepass $PASSWORD
keytool -keystore kafka.client.keystore.jks -import -noprompt -alias localhost -file cert-signed -storepass $PASSWORD
