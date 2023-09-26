# Generate certificate trust chain

## Generating the root certificate authority (CA)

To initialize the trust-chain and generate the root CA you must run
`./scripts/ca_initialization_script.sh`. You can configure the settings for the certificate in `./conf/ca.conf`

Once the root CA has been created you can start creating and signing intermediate and server certificates

`./scripts/intermediate_gen_ca_csr.sh` to generate CSRs for intermediate certificates

`./scripts/server_gen_csr.sh` to generate CSRs for server certificates

`./scripts/sign_csr.sh` can be used to sign the CSRs

Note the variables and their description in order to configure your required parameters.