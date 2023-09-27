#!/bin/bash
cd "$(dirname "$0")"

# Intermediate CA signing data
ISSUER_COMMONNAME="ca"
OPENSSL_CONF=../conf/ca.conf
CERT_VALIDITY_DAYS=3650 # 10 years
SUBJECT_COMMONNAME="HomeServerIntermediate0"
SUBJECT_TYPE="intermediate" # intermediate, server, or client


# # Server signing data
# ISSUER_COMMONNAME="HomeServerIntermediate0"
# OPENSSL_CONF=../conf/intermediate.conf
# CERT_VALIDITY_DAYS=182 # 6 months
# SUBJECT_COMMONNAME="LocalServer0"
# SUBJECT_TYPE="server" # intermediate or server

# # Client signing data
# ISSUER_COMMONNAME="HomeServerIntermediate0"
# OPENSSL_CONF=../conf/intermediate.conf
# CERT_VALIDITY_DAYS=182 # 6 months
# SUBJECT_COMMONNAME="LocalUser0"
# SUBJECT_TYPE="client" # intermediate, server, or client


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

SUBJECT_DIR="../${SUBJECT_TYPE}/${SUBJECT_COMMONNAME}"

if [[ "$SUBJECT_TYPE" == "intermediate" ]]; then
      DEFAULT_EXTENSION="v3_intermediate_ca"
elif [[ "$SUBJECT_TYPE" == "server" ]]; then
      DEFAULT_EXTENSION="server_cert"
else
      DEFAULT_EXTENSION="usr_cert"
fi

# Sign certificate with ca
echo "Use CA certificate to sign CSR"
echo "Issuer Key Password"
openssl ca \
      -config $OPENSSL_CONF \
      -extensions $DEFAULT_EXTENSION \
      -days $CERT_VALIDITY_DAYS \
      -notext \
      -md sha256 \
      -in ${SUBJECT_DIR}/csr/${SUBJECT_COMMONNAME}.csr \
      -out ${SUBJECT_DIR}/certs/${SUBJECT_COMMONNAME}.crt

chmod 444 ${SUBJECT_DIR}/certs/${SUBJECT_COMMONNAME}.crt


echo "##########################################################"
echo "Inspect Signed ${SUBJECT_COMMONNAME} CA cert"
echo "##########################################################"

openssl x509 \
      -in  "${SUBJECT_DIR}/certs/${SUBJECT_COMMONNAME}.crt" \
      -noout \
      -text

echo "##########################################################"
echo "Verify ${SUBJECT_COMMONNAME} cert vs ${ISSUER_COMMONNAME} CA"
echo "CA file ${ISSUER_DIR}/certs/ca-chain.crt"
echo "##########################################################"
# Verify the chain of trust the ${COMMONNAME} cert agains the root cert

if [[ "$ISSUER_COMMONNAME" == "ca" ]]; then
      openssl verify \
            -CAfile "../ca/certs/ca.crt" \
            "${SUBJECT_DIR}/certs/${SUBJECT_COMMONNAME}.crt"
else
      openssl verify \
            -CAfile "${ISSUER_DIR}/certs/ca-chain.crt" \
            "${SUBJECT_DIR}/certs/${SUBJECT_COMMONNAME}.crt"
fi

echo "##########################################################"
echo "Create chain cert"
echo "##########################################################"
# Create chain file of root and ${COMMONNAME} cert
if [[ "$ISSUER_COMMONNAME" == "ca" ]]; then
      cat "${ISSUER_DIR}/certs/ca.crt" \
            "${SUBJECT_DIR}/certs/${SUBJECT_COMMONNAME}.crt" > "${SUBJECT_DIR}/certs/ca-chain.crt"
else
      cat "${ISSUER_DIR}/certs/ca-chain.crt" \
            "${SUBJECT_DIR}/certs/${SUBJECT_COMMONNAME}.crt" > "${SUBJECT_DIR}/certs/ca-chain.crt"
fi
chmod 444 "${SUBJECT_DIR}/certs/ca-chain.crt"