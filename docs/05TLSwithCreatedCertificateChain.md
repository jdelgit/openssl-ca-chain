We will continue with the same repository from [4. Creating your own Certificate Chain](./04CreatingOwnCertificateChain.md)

## Using the the trust chain on a web-server

Next to inspecting the created certificates using `openssl x509 -in <certificate-path> -noout -text`, we can leverage OpenSSL to run a simple HTTPS web-server.
In the same repository I've added some Docker images which can be used for these tests.

The Server certificate has been given the SubjectAltName of `webserver.local`, so we'll have to ensure that our call is directed to the correct location when we make a call to `webserver.local`.
The web-servers we deploy will run on different ports on the `localhost` .
To ensure that the traffic is routed correctly we'll need to add an entry to our Hosts file located at `/etc/hosts`, for Windows users this path will be located in the `system32` folder.
Add the following line as the last entry.

```
127.0.0.1    webserver.local
```

#### OpenSSL (command-line)

Without mTLS:  `openssl s_server -chainCAfile <ca-chain> -cert <server-cert> -key <server-key> -www -accept 8843`

With mTLS:  `openssl s_server -chainCAfile <ca-chain> -cert <server-cert> -key <server-key> -Verify 1 -www -accept 9943`

**note**: if running both commands use different terminal sessions as it binds to the terminal.


The `-Verify 1` denotes how deep the certificate chain should be checked to find the root.
#### OpenSSL (Docker)
T
o build the Docker images, you must of course have [Docker installed](https://docs.docker.com/engine/install/), then run the following commands from the repository's root folder.

1.  `docker build -t localopenssl:latest -f images/openssl/Dockerfile.openssl . `     -> builds base image used in the other two images
2.  `docker build -t openssl-https:latest -f images/openssl/Dockerfile.ssl . `
3.  `docker build -t openssl-mtls:latest -f images/openssl/Dockerfile.mtls . `

**Run without mTLS**

`docker run -p 8843:8843 -d openssl-https

**Run with mTLS**

`docker run -p 9943:9943 -d openssl-mtls


Now we have a web-server with a certificate chain on which we can carry out the same tests that were done in the previous exercises [1. Anatomy of a Certificate](./01AnatomyOfaCertificate.md) and [2. Anatomy of a Certificate Chain](./02AnatomyOfaCertificateChain.md), however this time we'll use `webserver.local` and `localhost` as domains instead of `digicert.com`, be mindful of the different ports used during the lab.

Running the above commands you will now have two services running, one on `https://webserver.local:8843` and the other on `https://webserver.local:9943`.
You can verify that by running

**Connection without mTLS**

request: `curl -kv https://webserver.local:8843 2>&1 | grep Connected`

response: `Connected to webserver.local (127.0.0.1) port 8843 (#0)`

**Connection with mTLS**

request:  `curl -kv https://webserver.local:9943 2>&1 | grep Connected`

response: `Connected to webserver.local (127.0.0.1) port 9943 (#0)`

#### Checking the certificates

First let's look at the server running without mTLS. We'll open two terminal windows side-by-side.

Terminal 1: `echo "Q" | openssl s_client -connect localhost:8843`

Terminal 2: `echo "Q" | openssl s_client -connect webserver.local:8843`

There won't be much difference between the outputs, however in Terminal 1 we'll see the second line will say `Can't use SSL_get_servername`.
This line is absent from Terminal 2. The reason for this is because there's a SubjectAltName defined in the certificate which doesn't match the domain used to to reach the server where the certificate is hosted. The only SubjectAltName defined on the server is `webserver.local` , hence if we call the server using that domain name it will match successfully with the one defined on the certificate.
In both outputs you'll see `verify error:num=19:self-signed certificate in certificate chain`, this is because your `openssl` client is not familiar with this certificate and recognizes that it must be a selfsigned certificate.  You'll notice this error in multiple places in the output for the same reason.
If we tell the `openssl` client what the root CA is it will accept the certificate as trustworthy. We do that as follows
`echo "Q" | openssl s_client -CAfile ca/certs/ca.crt -connect webserver.local:8843`
Now we see that the error is gone and we even have the message `Verification: OK`.

##### Using mTLS
For regular TLS only the client verifies the trustworthiness of the server certificate, but for mTLS the server also requires the client to present a valid certificate.
We already know that the client requires the root CA to validate the certificate so let's try to make a call to the mTLS endpoint and pass the CA.
`echo "Q" | openssl s_client -CAfile ca/certs/ca.crt -connect webserver.local:9943`
We'll see an error
`40A76806E27F0000:error:0A00045C:SSL routines:ssl3_read_bytes:tlsv13 alert certificate required:../ssl/record/rec_layer_s3.c:1586:SSL alert number 116`
If we look in the web-server logs, for docker run `docker logs $(docker ps | grep mtls | awk '{print $NF}')`, we see a message stating `peer did not return a certificate`.
This indicates that the server was expecting the client to provide a certificate with its request, fortunately we've already generated one in a previous step. We can add our user certificate as follows
`echo "Q" | openssl s_client -key client/LocalUser0/private/LocalUser0.key -CAfile ca/certs/ca.crt -cert client/LocalUser0/certs/LocalUser0.crt -connect webserver.local:9943`
## How do I get it to work in my browser?

It's all about trust, and your browser doesn't trust the certificate since it doesn't know you. Your browser likely comes with its own truststore (list of trusted CAs), and your newly generated CA will not be in that list. For each browser it is slightly different, but you can find the certificate settings in the Privacy & Security settings. There you can choose to add a CA, for site that use mTLS you can also add a client certificate.