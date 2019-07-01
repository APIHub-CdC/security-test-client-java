#!/bin/sh
PRIVATE_KEY_FILE=pri_key.pem
CERTIFICATE_FILE=certificate.pem
SUBJECT=/C=/ST=/L=/O=/CN=kobra
PKCS12_FILE=keypair.p12
KEYSTORE_PASSWORD=
KEY_PASSWORD=N%eGJ37b4rXhzPym
KEYSTORE_FILE=keystore.jks
ALIAS=cdc
#Borra todos los archivos
rm -rf ${KEYSTORE_FILE}
#rm -rf ${PRIVATE_KEY_FILE}
rm -rf ${CERTIFICATE_FILE}
rm -rf ${PKCS12_FILE}
#Genera la llave privada y el certificado.

#openssl ecparam -name secp384r1 -genkey -out ${PRIVATE_KEY_FILE}
openssl req -new -x509 -days 365 -key ${PRIVATE_KEY_FILE} -out ${CERTIFICATE_FILE} -subj "${SUBJECT}"
#Genera el archivo pkcs12 a partir de la llave privada y el certificado.
openssl pkcs12 -name ${ALIAS} -export -out ${PKCS12_FILE} -inkey ${PRIVATE_KEY_FILE} -in ${CERTIFICATE_FILE} -password pass:${KEY_PASSWORD}


#Genera un Keystore con un par de llaves dummy.
keytool -genkey -alias dummy -keyalg RSA -keysize 2048 -keystore ${KEYSTORE_FILE} -dname "CN=dummy, OU=, O=, L=, S=, C=" -storepass ${KEYSTORE_PASSWORD} -keypass ${KEY_PASSWORD}
#Lista el contenido del Kesystore.
keytool -list -keystore ${KEYSTORE_FILE} -storepass ${KEYSTORE_PASSWORD}
#Elimina el par de llaves dummy.
keytool -delete -alias dummy -keystore ${KEYSTORE_FILE} -storepass ${KEYSTORE_PASSWORD}
#Lista el contenido del Kesystore.
keytool -list -keystore ${KEYSTORE_FILE} -storepass ${KEYSTORE_PASSWORD}
#IMPORTAMOS EL ARCHIVO PKCS12
keytool -importkeystore -srckeystore ${PKCS12_FILE} -srcstoretype PKCS12 -srcstorepass ${KEY_PASSWORD} -destkeystore ${KEYSTORE_FILE} -deststoretype JKS -storepass ${KEYSTORE_PASSWORD} -alias ${ALIAS}
#Lista el contenido del Kesystore
keytool -list -keystore ${KEYSTORE_FILE} -storepass ${KEYSTORE_PASSWORD}
#Borra todos los archivos excepto el KeyStore
#rm -rf ${PRIVATE_KEY_FILE}
#rm -rf ${CERTIFICATE_FILE}
#rm -rf ${PKCS12_FILE}
