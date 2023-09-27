#!/bin/bash
cd "$(dirname "$0")"

# This script should only be ran once

# Set the validaty length of the Root CA
CERT_VALIDITY_DAYS=7300 # 20 years

echo "##########################################################"
echo "Setting up directories: Root CA"
echo "##########################################################"
# Create directories for created objects when signing certificates
mkdir -p \
      ../ca/certs \
      ../ca/crl \
      ../ca/newcerts \
      ../ca/private \
      ../ca/db

# Only allow the file owner to read the private directory due to the sensitive information it contains
chmod 0700 ../ca/private

# Create file that tracks all created certificates (must match [ CA_default ] database in conf/ca.conf)
touch ../ca/db/ca_signed_certs.txt

# Set start index Id for generated certificates
echo 1000 > ../ca/serial

# Record Id of first certificate in Certificate Revocation List DB
echo 1000 > ../ca/crlnumber


echo "##########################################################"
echo "Generating Root CA private key"
echo "##########################################################"
# Private Key
# Generate Private key for root CA
# -aes256 is set inorder to add a password to the key
echo "Generate private key"
echo "Subject Key Password"
openssl genrsa \
      -aes256 \
      -out "../ca/private/ca.key" \
      4096

# Ensure the private key can only be read by the file owner
chmod 400 ../ca/private/ca.key


echo "##########################################################"
echo "Sign Root CA  key: valid ${CERT_VALIDITY_DAYS} for days"
echo "##########################################################"

# Generate root CA certificate
echo "Sign Root CA"
echo "Issuer Key Password"
openssl req \
      -config ../conf/ca.conf \
      -key ../ca/private/ca.key \
      -new \
      -x509 \
      -days $CERT_VALIDITY_DAYS \
      -sha256 \
      -extensions v3_ca \
      -out ../ca/certs/ca.crt

# Set permissions for all to read but no edit rights on the certificate
chmod 444 ../ca/certs/ca.crt


echo "##########################################################"
echo "Inspect signed Root CA cert"
echo "##########################################################"
# Inspect root CA certificate
openssl x509 \
      -in \
      ../ca/certs/ca.crt \
      -noout \
      -text