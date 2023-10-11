A certificate chain, also known as a certification path, is a series of digital certificates that are linked together to establish a trust relationship between a user's certificate (end-entity certificate) and a trusted Certificate Authority (CA). The certificate issuers determine and attest that the public-key provided by the certificate subject belongs to the subject, so whoever receives the public-key can rely on the fact that the subject is who they claim to be. However one must trust that the certificate issuer takes the necessary steps to actually verify the subject.

Certificate chain make up
	**End-Entity (Leaf) Certificate**: This is the certificate that contains the public key of the entity it identifies (e.g., a website). It's signed by an **Intermediate CA** or the **Root CA**.
	**Intermediate CA Certificates**: These are certificates that sit between the end-entity certificate and the root certificate. They are signed by a higher-level CA, which may be an intermediate CA itself or the root CA.
	**Root CA certificates**: This is the highest level certificate in the chain and is self-signed. It serves as the ultimate trust anchor


[Certificate Chain Image](https://en.wikipedia.org/wiki/Chain_of_trust#/media/File:Chain_of_trust_v2.svg)


In the above image the relations in a certificate chain are further shown. The Root CA signs it's own certificate, then signs the Intermediate certificate. The intermediate certificate(s) can then be used to sign the server certificate. The number of intermediate certificates in the chain between the Root CA and the server certificate can technically be an length, this is determined by the restrictions set when the Root CA is signing the intermediate CA. Generally there's only one intermediate CA in the chain.
In a valid chain only the Root CA certificate will be self-signed, having the same Issuer as Subject.




Let's have a Look at Digicert's certificate chain. We've already had a look at the web-server certificate in [Anatomy of a Certificate](01AnatomyOfaCertificate.md).

### Intermediate CA
To get the additional certificates when we call with `openssl`, we'll need to pass another parameter `-showcerts`.

`echo "Q" | openssl s_client -showcerts -connect digicert.com:443`

In the output we'll see that an additional certificate has been added. Just like last time we'll save this snippet to a file `digicert-intermediate.crt` and inspect it further.

```
-----BEGIN CERTIFICATE-----
MIIFPDCCBCSgAwIBAgIQAWePH++IIlXYsKcOa3uyIDANBgkqhkiG9w0BAQsFADBh
MQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3
d3cuZGlnaWNlcnQuY29tMSAwHgYDVQQDExdEaWdpQ2VydCBHbG9iYWwgUm9vdCBH
MjAeFw0yMDA3MDIxMjQyNTBaFw0zMDA3MDIxMjQyNTBaMEQxCzAJBgNVBAYTAlVT
MRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxHjAcBgNVBAMTFURpZ2lDZXJ0IEVWIFJT
QSBDQSBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAK0eZsx/neTr
f4MXJz0R2fJTIDfN8AwUAu7hy4gI0vp7O8LAAHx2h3bbf8wl+pGMSxaJK9ffDDCD
63FqqFBqE9eTmo3RkgQhlu55a04LsXRLcK6crkBOO0djdonybmhrfGrtBqYvbRat
xenkv0Sg4frhRl4wYh4dnW0LOVRGhbt1G5Q19zm9CqMlq7LlUdAE+6d3a5++ppfG
cnWLmbEVEcLHPAnbl+/iKauQpQlU1Mi+wEBnjE5tK8Q778naXnF+DsedQJ7NEi+b
QoonTHEz9ryeEcUHuQTv7nApa/zCqes5lXn1pMs4LZJ3SVgbkTLj+RbBov/uiwTX
tkBEWawvZH8CAwEAAaOCAgswggIHMB0GA1UdDgQWBBRqTlC/mGidW3sgddRZAXlI
ZpIyBjAfBgNVHSMEGDAWgBROIlQgGJXm427mD/r6uRLtBhePOTAOBgNVHQ8BAf8E
BAMCAYYwHQYDVR0lBBYwFAYIKwYBBQUHAwEGCCsGAQUFBwMCMBIGA1UdEwEB/wQI
MAYBAf8CAQAwNAYIKwYBBQUHAQEEKDAmMCQGCCsGAQUFBzABhhhodHRwOi8vb2Nz
cC5kaWdpY2VydC5jb20wewYDVR0fBHQwcjA3oDWgM4YxaHR0cDovL2NybDMuZGln
aWNlcnQuY29tL0RpZ2lDZXJ0R2xvYmFsUm9vdEcyLmNybDA3oDWgM4YxaHR0cDov
L2NybDQuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0R2xvYmFsUm9vdEcyLmNybDCBzgYD
VR0gBIHGMIHDMIHABgRVHSAAMIG3MCgGCCsGAQUFBwIBFhxodHRwczovL3d3dy5k
aWdpY2VydC5jb20vQ1BTMIGKBggrBgEFBQcCAjB+DHxBbnkgdXNlIG9mIHRoaXMg
Q2VydGlmaWNhdGUgY29uc3RpdHV0ZXMgYWNjZXB0YW5jZSBvZiB0aGUgUmVseWlu
ZyBQYXJ0eSBBZ3JlZW1lbnQgbG9jYXRlZCBhdCBodHRwczovL3d3dy5kaWdpY2Vy
dC5jb20vcnBhLXVhMA0GCSqGSIb3DQEBCwUAA4IBAQBSMgrCdY2+O9spnYNvwHiG
+9lCJbyELR0UsoLwpzGpSdkHD7pVDDFJm3//B8Es+17T1o5Hat+HRDsvRr7d3MEy
o9iXkkxLhKEgApA2Ft2eZfPrTolc95PwSWnn3FZ8BhdGO4brTA4+zkPSKoMXi/X+
WLBNN29Z/nbCS7H/qLGt7gViEvTIdU8x+H4l/XigZMUDaVmJ+B5d7cwSK7yOoQdf
oIBGmA5Mp4LhMzo52rf//kXPfE3wYIZVHqVuxxlnTkFYmffCX9/Lon7SWaGdg6Rc
k4RHhHLWtmz2lTZ5CEo2ljDsGzCFGJP7oT4q6Q8oFC38irvdKIJ95cUxYzj4tnOI
-----END CERTIFICATE-----
```

This time we'll focus only on a few fields from the inspect output command

`openssl x509 -in digicert-intermediate.crt -noout -text`

```
Issuer: C = US, O = DigiCert Inc, OU = www.digicert.com, CN = DigiCert Global Root G2
Subject: C = US, O = DigiCert Inc, CN = DigiCert EV RSA CA G2
X509v3 extensions:
	X509v3 Basic Constraints
		CA:TRUE, pathlen:0
```

Here we see that the Subject of this certificate is the same as the Issuer of the web-server certificate we looked at in [Anatomy of a Certificate](01AnatomyOfaCertificate.md). Further more the issuer of this certificate is not the same as the subject, indicating that is not self-signed, but signed by a higher-level CA.
Under the `Basic Constraints` extension we see that here `CA` is marked as `TRUE`, that combined with the fact it is signed by another CA indicates that it is an intermediate CA.
The `pathlen` variable indicates whether it can sign certificates which themselves are allowed to sign other certificates. In this case `pathlen:0` indicates that any certificate that this CA signs is not allowed to sign other certificates.

### Root CA

Despite having passed the  `-showcerts` flag in the previous exercise we were only shown 2 certificates, the Intermediate CA certificate and the web-server certificate. This is because the Root CA is implicitly trusted by the system on which we are running the commands, thus it is assumed that we don't need to inspect this certificate.

In order to still get and inspect the certificate we'll need to go digging into the system's certificate trust-store (repository of all trusted root CA certificates). For Debian based systems it can be found at `/etc/ssl/certs/ca-certificates.crt`, mind you they are all stored in PEM so we'll need to do some converting for us to find what we're looking for. See [how to get the list of CAs on your system ](https://unix.stackexchange.com/questions/97244/list-all-available-ssl-ca-certificates)
There are many other CAs in the file, so we'll extract all the certificates to a single file and search that file for the CA we want. We start by running the following command

`awk -v cmd='openssl x509 -noout -text' '/BEGIN/{close(cmd)};{print | cmd}' < /etc/ssl/certs/ca-certificates.crt > list_of_CAs.txt`

Once the command has executed we can open the file and search for `C = US, O = DigiCert Inc, OU = www.digicert.com, CN = DigiCert Global Root G2`, which is the issuer of the intermediate CA certificate.
We'll see the following fields

```
Issuer: C = US, O = DigiCert Inc, OU = www.digicert.com, CN = DigiCert Global Root G2
Subject: C = US, O = DigiCert Inc, OU = www.digicert.com, CN = DigiCert Global Root G2
X509v3 extensions:
	X509v3 Basic Constraints
		CA:TRUE
```

Here we see the Issuer and Subject are equal, indicating it is self-signed. We also see `CA:TRUE` with no `pathlen` restrictions, indicating it is indeed a CA that can authorize a certificate to sign other certificate with any number of intermediate certificate.

### The full chain
Below we'll see the different parts of the chain for Digicert.com  as referenced in the image above. I've left the `Basic Contraints` in for further clarity.

**Root CA**
```
Issuer:  C = US, O = DigiCert Inc, OU = www.digicert.com, CN = DigiCert Global Root G2
Subject: C = US, O = DigiCert Inc, OU = www.digicert.com, CN = DigiCert Global Root G2
Subject Public Key Info:
	Public Key Algorithm: rsaEncryption
		Public-Key: (2048 bit)
		Modulus:
			00:bb:37:cd:34:dc:7b:6b:c9:b2:68:90:ad:4a:75:
			ff:46:ba:21:0a:08:8d:f5:19:54:c9:fb:88:db:f3:
			ae:f2:3a:89:91:3c:7a:e6:ab:06:1a:6b:cf:ac:2d:
			e8:5e:09:24:44:ba:62:9a:7e:d6:a3:a8:7e:e0:54:
			75:20:05:ac:50:b7:9c:63:1a:6c:30:dc:da:1f:19:
			b1:d7:1e:de:fd:d7:e0:cb:94:83:37:ae:ec:1f:43:
			4e:dd:7b:2c:d2:bd:2e:a5:2f:e4:a9:b8:ad:3a:d4:
			99:a4:b6:25:e9:9b:6b:00:60:92:60:ff:4f:21:49:
			18:f7:67:90:ab:61:06:9c:8f:f2:ba:e9:b4:e9:92:
			32:6b:b5:f3:57:e8:5d:1b:cd:8c:1d:ab:95:04:95:
			49:f3:35:2d:96:e3:49:6d:dd:77:e3:fb:49:4b:b4:
			ac:55:07:a9:8f:95:b3:b4:23:bb:4c:6d:45:f0:f6:
			a9:b2:95:30:b4:fd:4c:55:8c:27:4a:57:14:7c:82:
			9d:cd:73:92:d3:16:4a:06:0c:8c:50:d1:8f:1e:09:
			be:17:a1:e6:21:ca:fd:83:e5:10:bc:83:a5:0a:c4:
			67:28:f6:73:14:14:3d:46:76:c3:87:14:89:21:34:
			4d:af:0f:45:0c:a6:49:a1:ba:bb:9c:c5:b1:33:83:
			29:85
		Exponent: 65537 (0x10001)
X509v3 extensions:
	X509v3 Basic Constraints
		CA:TRUE
Signature Value:
	60:67:28:94:6f:0e:48:63:eb:31:dd:ea:67:18:d5:89:7d:3c:
	c5:8b:4a:7f:e9:be:db:2b:17:df:b0:5f:73:77:2a:32:13:39:
	81:67:42:84:23:f2:45:67:35:ec:88:bf:f8:8f:b0:61:0c:34:
	a4:ae:20:4c:84:c6:db:f8:35:e1:76:d9:df:a6:42:bb:c7:44:
	08:86:7f:36:74:24:5a:da:6c:0d:14:59:35:bd:f2:49:dd:b6:
	1f:c9:b3:0d:47:2a:3d:99:2f:bb:5c:bb:b5:d4:20:e1:99:5f:
	53:46:15:db:68:9b:f0:f3:30:d5:3e:31:e2:8d:84:9e:e3:8a:
	da:da:96:3e:35:13:a5:5f:f0:f9:70:50:70:47:41:11:57:19:
	4e:c0:8f:ae:06:c4:95:13:17:2f:1b:25:9f:75:f2:b1:8e:99:
	a1:6f:13:b1:41:71:fe:88:2a:c8:4f:10:20:55:d7:f3:14:45:
	e5:e0:44:f4:ea:87:95:32:93:0e:fe:53:46:fa:2c:9d:ff:8b:
	22:b9:4b:d9:09:45:a4:de:a4:b8:9a:58:dd:1b:7d:52:9f:8e:
	59:43:88:81:a4:9e:26:d5:6f:ad:dd:0d:c6:37:7d:ed:03:92:
	1b:e5:77:5f:76:ee:3c:8d:c4:5d:56:5b:a2:d9:66:6e:b3:35:
	37:e5:32:b6
```

**Intermediate CA**
```
Issuer:  C = US, O = DigiCert Inc, OU = www.digicert.com, CN = DigiCert Global Root G2
Subject: C = US, O = DigiCert Inc, CN = DigiCert EV RSA CA G2
Subject Public Key Info:
   Public Key Algorithm: rsaEncryption
	   Public-Key: (2048 bit)
	   Modulus:
		   00:ad:1e:66:cc:7f:9d:e4:eb:7f:83:17:27:3d:11:
		   d9:f2:53:20:37:cd:f0:0c:14:02:ee:e1:cb:88:08:
		   d2:fa:7b:3b:c2:c0:00:7c:76:87:76:db:7f:cc:25:
		   fa:91:8c:4b:16:89:2b:d7:df:0c:30:83:eb:71:6a:
		   a8:50:6a:13:d7:93:9a:8d:d1:92:04:21:96:ee:79:
		   6b:4e:0b:b1:74:4b:70:ae:9c:ae:40:4e:3b:47:63:
		   76:89:f2:6e:68:6b:7c:6a:ed:06:a6:2f:6d:16:ad:
		   c5:e9:e4:bf:44:a0:e1:fa:e1:46:5e:30:62:1e:1d:
		   9d:6d:0b:39:54:46:85:bb:75:1b:94:35:f7:39:bd:
		   0a:a3:25:ab:b2:e5:51:d0:04:fb:a7:77:6b:9f:be:
		   a6:97:c6:72:75:8b:99:b1:15:11:c2:c7:3c:09:db:
		   97:ef:e2:29:ab:90:a5:09:54:d4:c8:be:c0:40:67:
		   8c:4e:6d:2b:c4:3b:ef:c9:da:5e:71:7e:0e:c7:9d:
		   40:9e:cd:12:2f:9b:42:8a:27:4c:71:33:f6:bc:9e:
		   11:c5:07:b9:04:ef:ee:70:29:6b:fc:c2:a9:eb:39:
		   95:79:f5:a4:cb:38:2d:92:77:49:58:1b:91:32:e3:
		   f9:16:c1:a2:ff:ee:8b:04:d7:b6:40:44:59:ac:2f:
		   64:7f
	   Exponent: 65537 (0x10001)
X509v3 extensions:
	X509v3 Basic Constraints
		CA:TRUE, pathlen:0
Signature Value:
   52:32:0a:c2:75:8d:be:3b:db:29:9d:83:6f:c0:78:86:fb:d9:
   42:25:bc:84:2d:1d:14:b2:82:f0:a7:31:a9:49:d9:07:0f:ba:
   55:0c:31:49:9b:7f:ff:07:c1:2c:fb:5e:d3:d6:8e:47:6a:df:
   87:44:3b:2f:46:be:dd:dc:c1:32:a3:d8:97:92:4c:4b:84:a1:
   20:02:90:36:16:dd:9e:65:f3:eb:4e:89:5c:f7:93:f0:49:69:
   e7:dc:56:7c:06:17:46:3b:86:eb:4c:0e:3e:ce:43:d2:2a:83:
   17:8b:f5:fe:58:b0:4d:37:6f:59:fe:76:c2:4b:b1:ff:a8:b1:
   ad:ee:05:62:12:f4:c8:75:4f:31:f8:7e:25:fd:78:a0:64:c5:
   03:69:59:89:f8:1e:5d:ed:cc:12:2b:bc:8e:a1:07:5f:a0:80:
   46:98:0e:4c:a7:82:e1:33:3a:39:da:b7:ff:fe:45:cf:7c:4d:
   f0:60:86:55:1e:a5:6e:c7:19:67:4e:41:58:99:f7:c2:5f:df:
   cb:a2:7e:d2:59:a1:9d:83:a4:5c:93:84:47:84:72:d6:b6:6c:
   f6:95:36:79:08:4a:36:96:30:ec:1b:30:85:18:93:fb:a1:3e:
   2a:e9:0f:28:14:2d:fc:8a:bb:dd:28:82:7d:e5:c5:31:63:38:
   f8:b6:73:88
```

**Server Certificate**
```
Issuer:  C = US, O = DigiCert Inc, CN = DigiCert EV RSA CA G2
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
	X509v3 Basic Constraints
		CA:FALSE
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


Having the information of all the certificates along the chain allows us to validate the certificate chain and prove that the chain of trust (signing) leads back to a specific Certificate Authority.