SSL (Secure Sockets Layer) and TLS (Transport Layer Security) are cryptographic protocols designed to provide secure communication over a computer network. They are used to encrypt network data, ensuring that it remains confidential and protected from eavesdropping or tampering. TLS is the successor to SSL, providing many more recent security upgrades compared to SSL.
SSL is considered obsolete and TLS is used primarly on modern networks. When a server has an SSL certificate and a call to the server is initiated via HTTPS it will initiate a TLS handshake before a client and the server start exchanging data. To perform the TLS handshake the server will make use of the Public Key of the server certificate and the Signature of its CA. Read more at [What happens in a TLS handshake? | SSL handshake](https://www.cloudflare.com/learning/ssl/what-happens-in-a-tls-handshake/)

note: SSL and TLS are still used interchangeably even though SSL has been deprecated.

During the TLS handshake the following will occur
	- TLS version selection, one that is supported by both client and server
	- [Cipher Suites](https://en.wikipedia.org/wiki/Cipher_suite) selection, one support by both client and server
	- Validate server's identity against its CA
	- Generate keys for symmetric encryption for exchange of data


Let's view the TLS handshake using `openssl` and viewing the output

`echo "Q" | openssl s_client -connect digicert.com:443`

This time we'll ignore the certificate (replaced by .......) in the output.

Establish TCP connection
```
 CONNECTED(00000003)
```

Server Certificate response
```
depth=2 C = US, O = DigiCert Inc, OU = www.digicert.com, CN = DigiCert Global Root G2
verify return:1
depth=1 C = US, O = DigiCert Inc, CN = DigiCert EV RSA CA G2
verify return:1
depth=0 jurisdictionC = US, jurisdictionST = Utah, businessCategory = Private Organization, serialNumber = 5299537-0142, C = US, ST = Utah, L = Lehi, O = "DigiCert, Inc.", CN = www.digicert.com
verify return:1
---
Certificate chain
0 s:jurisdictionC = US, jurisdictionST = Utah, businessCategory = Private Organization, serialNumber = 5299537-0142, C = US, ST = Utah, L = Lehi, O = "DigiCert, Inc.", CN = www.digicert.com
  i:C = US, O = DigiCert Inc, CN = DigiCert EV RSA CA G2
  a:PKEY: rsaEncryption, 2048 (bit); sigalg: RSA-SHA256
  v:NotBefore: Jul 31 00:00:00 2023 GMT; NotAfter: Jul 30 23:59:59 2024 GMT
1 s:C = US, O = DigiCert Inc, CN = DigiCert EV RSA CA G2
  i:C = US, O = DigiCert Inc, OU = www.digicert.com, CN = DigiCert Global Root G2
  a:PKEY: rsaEncryption, 2048 (bit); sigalg: RSA-SHA256
  v:NotBefore: Jul  2 12:42:50 2020 GMT; NotAfter: Jul  2 12:42:50 2030 GMT
---
Server certificate
.......
subject=jurisdictionC = US, jurisdictionST = Utah, businessCategory = Private Organization, serialNumber = 5299537-0142, C = US, ST = Utah, L = Lehi, O = "DigiCert, Inc.", CN = www.digicert.com
issuer=C = US, O = DigiCert Inc, CN = DigiCert EV RSA CA G2
```

In this section we see the chain of subjects as described in [4. Creating your own Certificate Chain](04CreatingOwnCertificateChain.md). However in the `Certificate chain` section the Root CA is noticeably absent.

Key derivation result
```
No client certificate CA names sent
Peer signing digest: SHA256
Peer signature type: RSA-PSS
Server Temp Key: X25519, 253 bits
```

Handshake Summary
```
---
SSL handshake has read 3797 bytes and written 382 bytes
Verification: OK
---
New, TLSv1.3, Cipher is TLS_AES_128_GCM_SHA256
Server public key is 2048 bit
Secure Renegotiation IS NOT supported
Compression: NONE
Expansion: NONE
No ALPN negotiated
Early data was not sent
Verify return code: 0 (ok)
```

Termination of connection
```
DONE
```
