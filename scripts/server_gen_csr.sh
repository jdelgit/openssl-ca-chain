#!/bin/bash

cd "$(dirname "$0")"
# Certrificate Issuer data (Can be a root or Intermediate CA). For CA just use 'ca'
ISSUER_COMMONNAME="HomeServerIntermediate0"
OPENSSL_CONF=../conf/intermediate.conf

# Certificate Subject Data
SUBJECT_COMMONNAME="LocalServer0"
CERT_VALIDITY_DAYS=182 # 6 months

echo "##########################################################"
echo "Setting up directories for ${SUBJECT_COMMONNAME}"
echo "##########################################################"
# export the value so it can be used in the corresponding openssl.conf
export ISSUER_COMMONNAME=$ISSUER_COMMONNAME

SUBJECT_DIR="../server/${SUBJECT_COMMONNAME}"
# Create directories for created certificates and private keys
mkdir -p \
      "${SUBJECT_DIR}/certs" \
      "${SUBJECT_DIR}/csr" \
      "${SUBJECT_DIR}/private"

# Only allow the file owner to read the private directory due to the sensitive information it contains
chmod 700 "${SUBJECT_DIR}/private"

echo "###########################################################################################################"
echo "Sign ${SUBJECT_COMMONNAME} cert by ${ISSUER_COMMONNAME} for ${CERT_VALIDITY_DAYS} days"
echo "###########################################################################################################"
# export the value so it can be used in the corresponding openssl.conf
export ISSUER_COMMONNAME=$ISSUER_COMMONNAME

if [[ "$ISSUER_COMMONNAME" == "ca" ]]; then
      ISSUER_DIR="../ca"
else
      ISSUER_DIR="../intermediate/${ISSUER_COMMONNAME}"
fi

SUBJECT_DIR="../server/${SUBJECT_COMMONNAME}"
# Private Key
# Generate Private key for Server
echo "##########################################################"
echo "Generating ${SUBJECT_COMMONNAME} private key"
echo "##########################################################"
openssl genrsa \
      -out "${SUBJECT_DIR}/private/${SUBJECT_COMMONNAME}.key" \
      4096

# Ensure the private key can only be read by the file owner
chmod 0400 "${SUBJECT_DIR}/private/${SUBJECT_COMMONNAME}.key"

# Generate CSR to be signed by the intermediate CA
echo "##########################################################"
echo  "Generating CSR for ${SUBJECT_COMMONNAME}"
echo "##########################################################"
openssl req \
      -config "$OPENSSL_CONF" \
      -new \
      -sha256 \
      -key "${SUBJECT_DIR}/private/${SUBJECT_COMMONNAME}.key" \
      -out "${SUBJECT_DIR}/csr/${SUBJECT_COMMONNAME}.csr"

echo "##########################################################"
echo  "Inspect CSR for ${SUBJECT_COMMONNAME}"
echo "##########################################################"
openssl req \
      -in "${SUBJECT_DIR}/csr/${SUBJECT_COMMONNAME}.csr" \
      -noout \
      -text