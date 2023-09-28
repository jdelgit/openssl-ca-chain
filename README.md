# Certificate trust chain

We'll look into certificate chain of trust using an existing trust-chain.
We'll see how to inspect a certificate and confirm the chain. After that we are going to build our own certificate chain of trust using openssl


The main steps are:
	1. Create a CA (certificate authority)
	2. Use the CA certificate to create a Intermediate CA (optional)
	3. Use the intermediate CA to create client and server certificates

The generated certificates will be used for a web-server and we'll see how the connection differs between connecting to the server with and without mTLS.

## Tools and Environment
We will be using `openssl` application for all the steps. Any other Linux distribution should support the command. If you are on Windows the command should be available if you already have git installed, and should work in the Git-Bash terminal.
It's recommended to create a new folder to follow along lab.

More information on `openssl` can be found on their website [OpenSSL](https://www.openssl.org/)

#### Commands used
`docker` -> run webserver container
`curl` -> make web request
`grep` -> search text for snippets
`awk` -> select snippets from text
`openssl` -> all certificate actions

**Manage Private key**
`openssl genrsa`  -> generate private key
`openssl rsa` -> inspect private key
`openssl pkcs12`  -> generate PFX file

**Manage CSR**
`openssl req` -> Create and inspect CSR

**Manage certificates**
`openssl x509` -> Inspect certificates
`openssl ca` -> Use CA to sign certificates

**Testing certificates**
`openssl s_client` -> Make request to TLS server
`openssl s_server` -> Lightweight TLS server

`openssl verify` ->Verify a signed certificate against its issuer
### Command Primer


`openssl x509 -in <cert-filepath> -noout -subject`

`openssl x509 -in <cert-filepath> -noout -text`

`echo "Q" | openssl s_client -showcerts -connect <host>:<port>`
`echo "Q"` terminates the connection after having it established


## [Inspecting the root certificate authority (CA)](docs/01.InspectingCertificateChain.md)

## [Creating Trust Chain](docs/02.CreateCertificateAuthority.md)
