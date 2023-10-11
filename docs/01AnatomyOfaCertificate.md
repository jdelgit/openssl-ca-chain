**A certificate is an identity that is bound to a public key**

Let's look at the Digicert website certificate shown below. We can get this certificate by running the following:

`echo "Q" | openssl s_client -connect digicert.com:443`

The output shows among other things the certificate in base64 encoded PEM (Privacy-Enhanced Mail) format between the markers
`-----BEGIN CERTIFICATE-----` and `-----END CERTIFICATE-----`.  For now we'll ignore the rest of the output, as it's related to SSL/TLS connection.

Let's save the snippet to a file called `digicert.com`.

In this format a human reader can't make much out of the information.
```
-----BEGIN CERTIFICATE-----
MIIHbDCCBlSgAwIBAgIQAWmCouBnm1T93QMhlDatRDANBgkqhkiG9w0BAQsFADBE
MQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMR4wHAYDVQQDExVE
aWdpQ2VydCBFViBSU0EgQ0EgRzIwHhcNMjMwNzMxMDAwMDAwWhcNMjQwNzMwMjM1
OTU5WjCBwTETMBEGCysGAQQBgjc8AgEDEwJVUzEVMBMGCysGAQQBgjc8AgECEwRV
dGFoMR0wGwYDVQQPDBRQcml2YXRlIE9yZ2FuaXphdGlvbjEVMBMGA1UEBRMMNTI5
OTUzNy0wMTQyMQswCQYDVQQGEwJVUzENMAsGA1UECBMEVXRhaDENMAsGA1UEBxME
TGVoaTEXMBUGA1UEChMORGlnaUNlcnQsIEluYy4xGTAXBgNVBAMTEHd3dy5kaWdp
Y2VydC5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCY3zNZwTun
OIxdni/jz8vqUDo2/nenmFJNwsqUeI/m81ddOHfy09drpJBC93EeWGqSDZWRXzJx
sZMc9dvgCtbSqNpvGoA5V03lr5dYUtGsQhjhmS9esL0dO/KMXoytp5n1pVHRYUpl
qRcjnrsQhrU2nqozh4wAbyjsKlzZUU5cNAgkOo9hhaixj2yecn6hi4gxgQfolXUv
KAkOkbT5LBx/xTQVXlm8IRxOo6x/skx25MSc2cHOVvOmBx9D8JrF3Qk/YHcn2A9V
BZuC8vYgQAoFBGG51xHmJomVeNMgxW8JGdib4ZrYzeMyaRHOPwz+NMDKJUmdRdBn
ftl4yQ40lYg5AgMBAAGjggPaMIID1jAfBgNVHSMEGDAWgBRqTlC/mGidW3sgddRZ
AXlIZpIyBjAdBgNVHQ4EFgQU1DiwneJjUpHHggPwHwDO7qD6t5MwgaAGA1UdEQSB
mDCBlYIQd3d3LmRpZ2ljZXJ0LmNvbYIMZGlnaWNlcnQuY29tghJhZG1pbi5kaWdp
Y2VydC5jb22CEGFwaS5kaWdpY2VydC5jb22CFGNvbnRlbnQuZGlnaWNlcnQuY29t
ghJsb2dpbi5kaWdpY2VydC5jb22CEm9yZGVyLmRpZ2ljZXJ0LmNvbYIPd3MuZGln
aWNlcnQuY29tMA4GA1UdDwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDAQYI
KwYBBQUHAwIwdQYDVR0fBG4wbDA0oDKgMIYuaHR0cDovL2NybDMuZGlnaWNlcnQu
Y29tL0RpZ2lDZXJ0RVZSU0FDQUcyLmNybDA0oDKgMIYuaHR0cDovL2NybDQuZGln
aWNlcnQuY29tL0RpZ2lDZXJ0RVZSU0FDQUcyLmNybDBKBgNVHSAEQzBBMAsGCWCG
SAGG/WwCATAyBgVngQwBATApMCcGCCsGAQUFBwIBFhtodHRwOi8vd3d3LmRpZ2lj
ZXJ0LmNvbS9DUFMwcwYIKwYBBQUHAQEEZzBlMCQGCCsGAQUFBzABhhhodHRwOi8v
b2NzcC5kaWdpY2VydC5jb20wPQYIKwYBBQUHMAKGMWh0dHA6Ly9jYWNlcnRzLmRp
Z2ljZXJ0LmNvbS9EaWdpQ2VydEVWUlNBQ0FHMi5jcnQwCQYDVR0TBAIwADCCAX0G
CisGAQQB1nkCBAIEggFtBIIBaQFnAHYAdv+IPwq2+5VRwmHM9Ye6NLSkzbsp3GhC
Cp/mZ0xaOnQAAAGJriYaDgAABAMARzBFAiEAkEFn2Y0r31HwEjcJNwp6yO3yh3Gs
CiqiZ3rIFWTqJVoCIA8YEjwJRZrnO+aJYs21GVFjIZAQo3lFHOw/q5DaZLk6AHUA
SLDja9qmRzQP5WoC+p0w6xxSActW3SyB2bu/qznYhHMAAAGJriYZ+QAABAMARjBE
AiAuuASW/DRLBiVG8vrb4/LIPR6BtGZM0xNk6Y42fxf4DAIgBfyM24TOauxonG2x
wpmCuBPzwXrlv8KCXVCop2XUKwcAdgDatr9rP7W2Ip+bwrtca+hwkXFsu1GEhTS9
pD0wSNf7qwAAAYmuJhnCAAAEAwBHMEUCIQDOQYIsQRxwdOvOpED6B/rlpsu7HW3K
xLLyjiyd3YUk6wIgelGR++BkZcNotjDJAjYvtD74p1MLcwdqI4tke+zZgbQwDQYJ
KoZIhvcNAQELBQADggEBADMg/S3lXWskzIHO/IVlcYy8ePucUHJ8O1BONKGMj9Ag
pj67HnwjItfr1CeIgcv5sfADuBgm9mbQupLrM26eq2KEDYf1RT+Pnb1WaQisWXSp
m5mqTdtiPUGP6GNAMzmL1KlQ1ZSqkAXYbGIOhXOHMTMKF/UD1uRLQsFBVvWrLYUQ
9/AXiSQzvUzag85hUYP6PZ6/Mp8vHCS+CzVUcbakTm7POvQl1kNZw3bdNwPrnEW7
Gon/yku97BbMhxsOceRObPR5GzUIGsOz7iqqjDwbgrV4YdPnXICc57fJvJ8esdBT
5eDbzi5GOtHJKRrzuv7mwEJcFMw++aUx9hpJHuoxKWA=
-----END CERTIFICATE-----
```


Now we can analyze the certificate with `openssl` by running

`openssl x509 -in digicert.com.crt -noout -text`.

We get the following output
```
Certificate:
   Data:
       Version: 3 (0x2)
       Serial Number:
           01:69:82:a2:e0:67:9b:54:fd:dd:03:21:94:36:ad:44
       Signature Algorithm: sha256WithRSAEncryption
       Issuer: C = US, O = DigiCert Inc, CN = DigiCert EV RSA CA G2
       Validity
           Not Before: Jul 31 00:00:00 2023 GMT
           Not After : Jul 30 23:59:59 2024 GMT
       Subject: jurisdictionC = US, jurisdictionST = Utah, businessCategory = Private Organization, serialNumber = 5299537-0142, C = US, ST = Utah, L = Lehi, O = "DigiCert, Inc.", CN = www.digicert.com
       Subject Public Key Info:
           Public Key Algorithm: rsaEncryption
               Public-Key: (2048 bit)
               Modulus:
                   00:98:df:33:59:c1:3b:a7:38:8c:5d:9e:2f:e3:cf:
                   cb:ea:50:3a:36:fe:77:a7:98:52:4d:c2:ca:94:78:
                   8f:e6:f3:57:5d:38:77:f2:d3:d7:6b:a4:90:42:f7:
                   71:1e:58:6a:92:0d:95:91:5f:32:71:b1:93:1c:f5:
                   db:e0:0a:d6:d2:a8:da:6f:1a:80:39:57:4d:e5:af:
                   97:58:52:d1:ac:42:18:e1:99:2f:5e:b0:bd:1d:3b:
                   f2:8c:5e:8c:ad:a7:99:f5:a5:51:d1:61:4a:65:a9:
                   17:23:9e:bb:10:86:b5:36:9e:aa:33:87:8c:00:6f:
                   28:ec:2a:5c:d9:51:4e:5c:34:08:24:3a:8f:61:85:
                   a8:b1:8f:6c:9e:72:7e:a1:8b:88:31:81:07:e8:95:
                   75:2f:28:09:0e:91:b4:f9:2c:1c:7f:c5:34:15:5e:
                   59:bc:21:1c:4e:a3:ac:7f:b2:4c:76:e4:c4:9c:d9:
                   c1:ce:56:f3:a6:07:1f:43:f0:9a:c5:dd:09:3f:60:
                   77:27:d8:0f:55:05:9b:82:f2:f6:20:40:0a:05:04:
                   61:b9:d7:11:e6:26:89:95:78:d3:20:c5:6f:09:19:
                   d8:9b:e1:9a:d8:cd:e3:32:69:11:ce:3f:0c:fe:34:
                   c0:ca:25:49:9d:45:d0:67:7e:d9:78:c9:0e:34:95:
                   88:39
               Exponent: 65537 (0x10001)
       X509v3 extensions:
           X509v3 Authority Key Identifier:  
               6A:4E:50:BF:98:68:9D:5B:7B:20:75:D4:59:01:79:48:66:92:32:06
           X509v3 Subject Key Identifier:  
               D4:38:B0:9D:E2:63:52:91:C7:82:03:F0:1F:00:CE:EE:A0:FA:B7:93
           X509v3 Subject Alternative Name:  
               DNS:www.digicert.com, DNS:digicert.com, DNS:admin.digicert.com, DNS:api.digicert.com, DNS:content.digicert.com, DNS:login.digicert.com, DNS:order.digicert.com, DNS:ws.digicert.com
           X509v3 Key Usage: critical
               Digital Signature, Key Encipherment
           X509v3 Extended Key Usage:  
               TLS Web Server Authentication, TLS Web Client Authentication
           X509v3 CRL Distribution Points:  
               Full Name:
                 URI:http://crl3.digicert.com/DigiCertEVRSACAG2.crl
               Full Name:
                 URI:http://crl4.digicert.com/DigiCertEVRSACAG2.crl
           X509v3 Certificate Policies:  
               Policy: 2.16.840.1.114412.2.1
               Policy: 2.23.140.1.1
                 CPS: http://www.digicert.com/CPS
           Authority Information Access:  
               OCSP - URI:http://ocsp.digicert.com
               CA Issuers - URI:http://cacerts.digicert.com/DigiCertEVRSACAG2.crt
           X509v3 Basic Constraints:  
               CA:FALSE
           CT Precertificate SCTs:  
               Signed Certificate Timestamp:
                   Version   : v1 (0x0)
                   Log ID    : 76:FF:88:3F:0A:B6:FB:95:51:C2:61:CC:F5:87:BA:34:
                               B4:A4:CD:BB:29:DC:68:42:0A:9F:E6:67:4C:5A:3A:74
                   Timestamp : Jul 31 22:51:19.950 2023 GMT
                   Extensions: none
                   Signature : ecdsa-with-SHA256
                               30:45:02:21:00:90:41:67:D9:8D:2B:DF:51:F0:12:37:
                               09:37:0A:7A:C8:ED:F2:87:71:AC:0A:2A:A2:67:7A:C8:
                               15:64:EA:25:5A:02:20:0F:18:12:3C:09:45:9A:E7:3B:
                               E6:89:62:CD:B5:19:51:63:21:90:10:A3:79:45:1C:EC:
                               3F:AB:90:DA:64:B9:3A
               Signed Certificate Timestamp:
                   Version   : v1 (0x0)
                   Log ID    : 48:B0:E3:6B:DA:A6:47:34:0F:E5:6A:02:FA:9D:30:EB:
                               1C:52:01:CB:56:DD:2C:81:D9:BB:BF:AB:39:D8:84:73
                   Timestamp : Jul 31 22:51:19.929 2023 GMT
                   Extensions: none
                   Signature : ecdsa-with-SHA256
                               30:44:02:20:2E:B8:04:96:FC:34:4B:06:25:46:F2:FA:
                               DB:E3:F2:C8:3D:1E:81:B4:66:4C:D3:13:64:E9:8E:36:
                               7F:17:F8:0C:02:20:05:FC:8C:DB:84:CE:6A:EC:68:9C:
                               6D:B1:C2:99:82:B8:13:F3:C1:7A:E5:BF:C2:82:5D:50:
                               A8:A7:65:D4:2B:07
               Signed Certificate Timestamp:
                   Version   : v1 (0x0)
                   Log ID    : DA:B6:BF:6B:3F:B5:B6:22:9F:9B:C2:BB:5C:6B:E8:70:
                               91:71:6C:BB:51:84:85:34:BD:A4:3D:30:48:D7:FB:AB
                   Timestamp : Jul 31 22:51:19.874 2023 GMT
                   Extensions: none
                   Signature : ecdsa-with-SHA256
                               30:45:02:21:00:CE:41:82:2C:41:1C:70:74:EB:CE:A4:
                               40:FA:07:FA:E5:A6:CB:BB:1D:6D:CA:C4:B2:F2:8E:2C:
                               9D:DD:85:24:EB:02:20:7A:51:91:FB:E0:64:65:C3:68:
                               B6:30:C9:02:36:2F:B4:3E:F8:A7:53:0B:73:07:6A:23:
                               8B:64:7B:EC:D9:81:B4
   Signature Algorithm: sha256WithRSAEncryption
   Signature Value:
       33:20:fd:2d:e5:5d:6b:24:cc:81:ce:fc:85:65:71:8c:bc:78:
       fb:9c:50:72:7c:3b:50:4e:34:a1:8c:8f:d0:20:a6:3e:bb:1e:
       7c:23:22:d7:eb:d4:27:88:81:cb:f9:b1:f0:03:b8:18:26:f6:
       66:d0:ba:92:eb:33:6e:9e:ab:62:84:0d:87:f5:45:3f:8f:9d:
       bd:56:69:08:ac:59:74:a9:9b:99:aa:4d:db:62:3d:41:8f:e8:
       63:40:33:39:8b:d4:a9:50:d5:94:aa:90:05:d8:6c:62:0e:85:
       73:87:31:33:0a:17:f5:03:d6:e4:4b:42:c1:41:56:f5:ab:2d:
       85:10:f7:f0:17:89:24:33:bd:4c:da:83:ce:61:51:83:fa:3d:
       9e:bf:32:9f:2f:1c:24:be:0b:35:54:71:b6:a4:4e:6e:cf:3a:
       f4:25:d6:43:59:c3:76:dd:37:03:eb:9c:45:bb:1a:89:ff:ca:
       4b:bd:ec:16:cc:87:1b:0e:71:e4:4e:6c:f4:79:1b:35:08:1a:
       c3:b3:ee:2a:aa:8c:3c:1b:82:b5:78:61:d3:e7:5c:80:9c:e7:
       b7:c9:bc:9f:1e:b1:d0:53:e5:e0:db:ce:2e:46:3a:d1:c9:29:
       1a:f3:ba:fe:e6:c0:42:5c:14:cc:3e:f9:a5:31:f6:1a:49:1e:
       ea:31:29:60
```

Now we'll go through different sections of the output

`Version` : The x.509 certificate specification version used for signing the certificate
`Serial Number` : A serial number (20 bytes) assigned by the certificate issuer. A CA is _supposed_ to choose unique serial numbers, that is, *unique for the CA*.
`Signature Algorithm`: Algorithm used to sign the certificate, see [Signature algorithms](https://docs.digicert.com/en/iot-trust-manager/certificate-templates/create-json-formatted-certificate-templates/signature-algorithms.html) to see other possibilities
`Issuer` : The subject-name of the Authority that signed the certificate. See [What is a Distinguished Name (DN)](https://knowledge.digicert.com/generalinformation/INFO1745.html) for more info on the specific fields in the description
`Validity`:
	`Not Before` What date and time is the certificate valid from
	`Not After` What date time is the certificate no longer valid
`Subject`: The distinguished name information for this certificate
`Subject Public Key Info`: Provides information about the public key used for encryption of signatures, e.g. SSL/TLS sessions.
	`Public Key Algorithm`: Algorithm used for signing, see [Public key cryptography](https://www.digicert.com/faq/cryptography/what-is-public-key-cryptography) for more info.
		`Public-Key`: Length in bits of the public key. The key is made up of a `modulus` and an `exponent`
		`Modulus`: Used for encryption and decryption. Part of the public key, which is a large number.
		`Exponent`: Used for encryption and decryption
`X509v3 extensions`: Extensions (restrictions) added to the certificate by the signing authority, see [OpenSSL x509v3_config](https://www.openssl.org/docs/man1.0.2/man5/x509v3_config.html) for more info.

We won't cover all the extensions, however there are a few notable ones.
`X509v3 Key Usage` : Specifies the set of allowed operations that can be performed using the public key contained in the certificate
		`Digital Signature` : This allows the public key to be used for creating digital signatures.
		`Key Encipherment`This allows the public key to be used for encrypting keys, for example when using SSL/TLS.
`X509v3 Extended Key Usage`: Provides additional information about the intended purposes or usages of the public key contained in the certificate
	`TLS Web Server Authentication`: The certificate is intended for authenticating web servers in SSL/TLS connections.
	`TLS Web Client Authentication`: The certificate is intended for authenticating clients in SSL/TLS connections.
`X509v3 Subject Alternative Name`: Allows the certificate subject to be associated with additional identities beyond its  Common Name
`X509v3 Basic Constraints`
	`CA` : Flag that defines whether the certificate is a (intermediate) Certificate Authority or not, values : `TRUE` or `FALSE`

For this certificate we see the flag `CA:FALSE` indicating that it is not a CA certificate.

Finally we have the `Signature Value`.
When a Certificate Authority (CA) issues a certificate, it creates a digital signature using its private key. This signature is generated by applying a cryptographic algorithm to a hash value of the certificate's content. This process ensures that only the CA, with its private key, could have produced the signature.

There is one more useful identifying info of a certificate and that is its hash value, also known as fingerprint or thumbprint. To get that we'll need yet another `openssl` command.

`openssl x509 -fingerprint -sha256 -noout -in digicert.com`
ouput:
`sha256 Fingerprint=06:D4:7A:E7:41:86:52:81:14:64:84:F8:41:11:35:54:BD:3D:3D:82:7E:38:BE:DF:AE:CF:15:CF:5E:97:7B:A9`

Omiting `-sha256` will produce a `sha-1` output which can also be used. This value will differ from the `sha256` value.

`SHA1 Fingerprint=FF:73:F7:38:8C:B6:80:9C:16:11:03:F7:D4:D5:ED:71:3D:B6:97:18`




