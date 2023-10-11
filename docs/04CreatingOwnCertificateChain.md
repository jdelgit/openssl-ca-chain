## Create your own CA, intermediate, and server cert

Go read [OpenSSL Certificate Authority by Jamie Nguyen](https://jamielinux.com/docs/openssl-certificate-authority/introduction.html), it's a great resource on the subjects. There you can follow each command step by step to create a CA trust chain. I've created several scripts to automate the creation and signing of the certificate which can be found here [openssl-ca-chain](https://github.com/jdelgit/openssl-ca-chain). I'll be using the scripts to continue

Certificate extensions : https://www.openssl.org/docs/man1.0.2/man5/x509v3_config.html

Note that some of the executed actions need only be done once when setting up the trust-chain and other actions can be automated as they will be required to be ran to create other intermediate or server certificates in the future.

## Create Self-signed Trust Chain using the Github Repo

Let's start by cloning the code to a directory for the lab.

```
git clone https://github.com/jdelgit/openssl-ca-chain.git
```

All commands are to be run from the repository root level. Using the script I generated 2 trust chains to use for testing later on for testing.

- Root CA -> Intermediate CA -> Server Cert
- Root CA -> Intermediate CA -> User Cert

The script should be ran as follows to generate Root CA and Intermediate CA

	1. `./scripts/gen_root_ca,sh`
	2. `./scripts/gen_intermediate_ca_csr.sh`
	3. `./scripts/sign_csr.sh`

To generate Server certificates you will need to comment the block in `./scripts/sign_csr.sh` under `# Intermediate CA signing data` and un-comment the block under `# # Server signing data`

	1. `./scripts/gen_leaf_csr.sh`
	2. `./scripts/sign_csr`

Now you should have a full certificate chain with the following certificates

	- `./ca/certs/ca.crt`
	- `./intermediate/HomeServerIntermediate0/certs/HomeServerIntermediate0.crt`
	- `./intermediate/HomeServerIntermediate0/certs/ca-chain.crt`
	- `./server/LocalServer0/certs/LocalServer0.crt`
	- `./server/LocalServer0/certs/ca-chain.crt`

To generate Client certificates you will need to comment the block in `./scripts/gen_leaf_csr.sh` under `# Server signing data` and uncomment the block under `# # Client signing data`

	1. `./scripts/gen_leaf_csr.sh`
	2. `./scripts/sign_csr`

Now you should have following additional certificates

	- `./client/LocalUser0/certs/LocalUser0.crt`
	- `./client/LocalUser0/certs/ca-chain.crt`


You can view and inspect the certificates with the same methods described in [2 Anatomy of a Certificate Chain](02AnatomyOfaCertificateChain.md)