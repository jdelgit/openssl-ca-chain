#!/bin/bash
cd "$(dirname "$0")"

# Set the Name of the directory, use commonName without spaces
SUBJECT_COMMONNAME="HomeServerIntermediate0"
ISSUER_COMMONNAME="ca"
OPENSSL_CONF=../conf/ca.conf
# SUBJECT_COMMONNAME="HomeServerIntermediate0Branch0"
# ISSUER_COMMONNAME="HomeServerIntermediate0"
# OPENSSL_CONF=../conf/intermediate.conf

echo "##########################################################"
echo "Setting up directories for ${SUBJECT_COMMONNAME}"
echo "##########################################################"
# export the value so it can be used in the corresponding openssl.conf
export ISSUER_COMMONNAME=$ISSUER_COMMONNAME

SUBJECT_DIR="../intermediate/${SUBJECT_COMMONNAME}"
# Create directories for created objects when signing certificates
mkdir -p \
      "${SUBJECT_DIR}/certs" \
      "${SUBJECT_DIR}/db" \
      "${SUBJECT_DIR}/crl" \
      "${SUBJECT_DIR}/csr" \
      "${SUBJECT_DIR}/newcerts" \
      "${SUBJECT_DIR}/private"

# Only allow the file owner to read the private directory due to the sensitive information it contains
chmod 700 "${SUBJECT_DIR}/private"

# Create file that tracks all created certificates (must match [ CA_default ] database in conf/intermediate.conf)
touch "${SUBJECT_DIR}/db/${SUBJECT_COMMONNAME}_DB.txt"

# Set start index Id for generated certificates
echo 1000 > "${SUBJECT_DIR}/serial"


# Private Key
# Generate Private key for intermediate CA
# -aes256 is set inorder to add a password to the key
echo "##########################################################"
echo "Generating ${SUBJECT_COMMONNAME} CA private key"
echo "##########################################################"
echo "Subject Key Password"
openssl genrsa \
      -aes256 \
      -out "${SUBJECT_DIR}/private/${SUBJECT_COMMONNAME}.key" \
      4096

# Ensure the private key can only be read by the file owner
chmod 0400 "${SUBJECT_DIR}/private/${SUBJECT_COMMONNAME}.key"

# Generate CSR to be signed by the root CA
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