<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Web Crypto API ECDH generateKey/deriveBits and perform AES encryption and decryption, jwk format ecdh ">
    <meta name="keywords" content="Web Crypto API ecdh named curved generate keys sign verify the message,  ecdh generate keys, ecdh keys export to jwk, web crypto deriveKeys ,web crypto live tutorial, windo.crypto javascript examples, Web Cryptography API">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>Web Crypto API ECDH generateKey/deriveBits and perform AES encryption and decryption</title>

    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/blog-post.css" rel="stylesheet">
    
    <link rel="stylesheet"  href="css/highlight/default.min.css">
	<script src="css/highlight/highlight.min.js"></script>
	<script>hljs.initHighlightingOnLoad();</script>
	
	
		<!-- JSON-LD markup generated by Google Structured Data Markup Helper. -->
<!-- JSON-LD markup generated by Google Structured Data Markup Helper. -->
<script type="application/ld+json">
{
  "@context" : "http://schema.org",
  "@type" : "Article",
  "mainEntityOfPage": {
    "@type": "WebPage",
    "@id": "https://8gwifi.org/docs/window-crypto-ecdh.jsp"
  },
  "name" : "Web Crypto API Generate ecdh Public Private Keys and perform Sign and Verify Message",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "Web Crypto API Generate ecdh derive key, generte keys perform aes encryption and decryption ",
  "image":"https://8gwifi.org/docs/img/ecdh.png",
  "datePublished" : "2018-09-24",
  "dateModified": "2018-09-24",
  "articleSection" : "Web Crypto API ECDH generateKey/deriveBits and perform AES encryption and decryption",
  "articleBody" : [ "Web Crypto API ECDH generateKey/deriveBits and perform AES encryption and decryption","The recognized algorithm name for this algorithm is "ECDH".", "Named Curve reference", "secp256r1=P-256","ECDH Demo", "ECDH Derived Key Master","ECDH Private Key (JWK)", "ECDH Javascript example of using webcrypto api", "ECDH exportKey Example", "ECDH Derive key using name curved algorithms", "ECDH deriveBits", "Performing AES Encryption using ECDH generate Key"],
  "publisher" : {
    "@type" : "Organization",
    "name" : "8gwifi.org Tech Blog",
    "logo" :  {
      "@type": "ImageObject",
      "url": "https://8gwifi.org/docs/img/logo.jpg"
    }
  }
}
</script>

<script type="text/javascript">
    var privateKey;
    var publicKey;



    var iv;

    
    function asciiToUint8Array(str) {
        var chars = [];
        for (var i = 0; i < str.length; ++i)
            chars.push(str.charCodeAt(i));
        return new Uint8Array(chars);
    }

 function ECDH_DeriveKey_DeriveBits() {

    var cryptoObj = window.crypto || window.msCrypto;

    if (!cryptoObj) {
        alert("Crypto API is not supported by the Browser");
        return;
    }

    var plainText = document.getElementById("plainText").value;
    var curve = document.getElementById("curve").value;

    iv = crypto.getRandomValues(new Uint8Array(16));

    window.crypto.subtle.generateKey({
                name: "ECDH",
                namedCurve: curve, //can be "P-256", "P-384", or "P-521"
            },
            true, //whether the key is extractable (i.e. can be used in exportKey)
            ["deriveKey", "deriveBits"] //can be any combination of "deriveKey" and "deriveBits"
        )
        .then(function(key) {

            publicKey = key.publicKey;
            privateKey = key.privateKey;


            // For Demo Purpos Only Exported in JWK format
            window.crypto.subtle.exportKey("jwk", key.publicKey).then(
                function(keydata) {
                    publicKeyhold = keydata;
                    publicKeyJson = JSON.stringify(publicKeyhold);
                    document.getElementById("ecdhpublic").value = publicKeyJson;
                }
            );

            window.crypto.subtle.exportKey("jwk", key.privateKey).then(
                function(keydata) {
                    privateKeyhold = keydata;
                    privateKeyJson = JSON.stringify(privateKeyhold);
                    document.getElementById("ecdhprivate").value = privateKeyJson;
                }
            );

            window.crypto.subtle.deriveKey({
                        name: "ECDH",
                        namedCurve: curve, //can be "P-256", "P-384", or "P-521"
                        public: publicKey, //an ECDH public key from generateKey or importKey
                    },
                    privateKey, //your ECDH private key from generateKey or importKey
                    { //the key type you want to create based on the derived bits
                        name: "AES-CTR", //can be any AES algorithm ("AES-CTR", "AES-CBC", "AES-CMAC", "AES-GCM", "AES-CFB", "AES-KW", "ECDH", "DH", or "HMAC")
                        //the generateKey parameters for that type of algorithm
                        length: 256, //can be  128, 192, or 256
                    },
                    true, //whether the derived key is extractable (i.e. can be used in exportKey)
                    ["encrypt", "decrypt"] //limited to the options in that algorithm's importKey
                )
                .then(function(keydata) {
                    //returns the exported key data

                    // For Demo Purpos Only Exported in JWK format
                    window.crypto.subtle.exportKey("jwk", keydata).then(
                        function(keydata) {
                            dKey = keydata;
                            document.getElementById("deriveKey").value = dKey.k
                            document.getElementById("deriveKeyUsage").value = JSON.stringify(dKey)
                        }
                    );
                })
                .catch(function(err) {
                    console.error(err);
                });

            window.crypto.subtle.deriveBits({
                        name: "ECDH",
                        namedCurve: curve, //can be "P-256", "P-384", or "P-521"
                        public: publicKey, //an ECDH public key from generateKey or importKey
                    },
                    privateKey, //from generateKey or importKey above
                    256 //the number of bits you want to derive
                )
                .then(function(bits) {
                    //returns an ArrayBuffer containing the signature
                    document.getElementById("cipherText").value = bytesToHexString(bits);
                })
                .catch(function(err) {
                    console.error(err);
                });


        })
        .catch(function(err) {
            console.error(err);
        });
}


function ECDH_AES_CTR_Encrypt() {

    var cryptoObj = window.crypto || window.msCrypto;

    if (!cryptoObj) {
        alert("Crypto API is not supported by the Browser");
        return;
    }

    var plainText = document.getElementById("plainText").value;
    var deriveKeyUsage = document.getElementById("deriveKeyUsage").value;

    if (!publicKey) {
        alert("Generate ECDH Key First");
        return;
    }

    obj = JSON.parse(deriveKeyUsage);
    alg1 = obj.alg;
    ext1 = obj.ext;
    k1 = obj.k;
    kty1 = obj.kty;

    crypto.subtle.importKey("jwk", {
        alg: alg1,
        ext: ext1,
        k: k1,
        kty: kty1
    }, "aes-ctr", false, ["encrypt"]).then(function(key) {
        return crypto.subtle.encrypt({
            name: "aes-ctr",
            counter: iv,
            length: 128
        }, key, asciiToUint8Array(plainText));
    }, failAndLog).then(function(cipherText) {
        document.getElementById("cipherTextGCM").value = bytesToHexString(cipherText);
    }, failAndLog);
}


    function ECDH_AES_CTR_Decrypt() {

    var cryptoObj = window.crypto || window.msCrypto;

    if (!cryptoObj) {
        alert("Crypto API is not supported by the Browser");
        return;
    }

    var plainText = document.getElementById("cipherTextGCM").value;
    var deriveKeyUsage = document.getElementById("deriveKeyUsage").value;

    if (!deriveKeyUsage) {
        alert("Generate ECDH Key First and perform Encrypttion");
        return;
    }
    obj = JSON.parse(deriveKeyUsage);
    alg1 = obj.alg;
    ext1 = obj.ext;
    k1 = obj.k;
    kty1 = obj.kty;

    crypto.subtle.importKey("jwk", {
        alg: alg1,
        ext: ext1,
        k: k1,
        kty: kty1
    }, "aes-ctr", false, ["decrypt"]).then(function(key) {
        return crypto.subtle.decrypt({
            name: "aes-ctr",
            counter: iv,
            length: 128
        }, key, hexStringToUint8Array(plainText));
    }, failAndLog).then(function(cipherText) {
        alert(bytesToASCIIString(cipherText));
    }, failAndLog);
}


    function bytesToASCIIString(bytes) {
        return String.fromCharCode.apply(null, new Uint8Array(bytes));
    }

    function bytesToHexString(bytes) {
        if (!bytes)
            return null;

        bytes = new Uint8Array(bytes);
        var hexBytes = [];

        for (var i = 0; i < bytes.length; ++i) {
            var byteString = bytes[i].toString(16);
            if (byteString.length < 2)
                byteString = "0" + byteString;
            hexBytes.push(byteString);
        }

        return hexBytes.join("");
    }

    function hexStringToUint8Array(hexString) {
        if (hexString.length % 2 != 0)
            throw "Invalid hexString";
        var arrayBuffer = new Uint8Array(hexString.length / 2);

        for (var i = 0; i < hexString.length; i += 2) {
            var byteValue = parseInt(hexString.substr(i, 2), 16);
            if (byteValue == NaN)
                throw "Invalid hexString";
            arrayBuffer[i / 2] = byteValue;
        }

        return arrayBuffer;
    }


    function failAndLog(error) {
        console.log(error);
        alert(error)
    }
</script>


  </head>

  <body>

    <!-- Navigation -->
 	<%@ include file="navigation.jsp"%>

    <!-- Page Content -->
    <div class="container">

      <div class="row">

        <!-- Post Content Column -->
        <div class="col-lg-8">

          <!-- Title -->
          <h1 class="mt-4">Web Crypto API ECDH generateKey/deriveBits and perform AES encryption and decryption</h1>

          <!-- Author -->
          <p class="lead">
            by
            <a href="https://www.linkedin.com/in/anishnath">Anish</a>
            <p>Posted on Monday september 24, 2018</p>
          </p>
          
          
          
          <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>
           
          <hr>
          
          <p><mark>This sample chapter </mark> extracted from the book, <a href="https://leanpub.com/crypto">Cryptography for JavaScript Developers</a>. </p>
<p><iframe width='160' height='400' src='https://leanpub.com/cryptojs/embed' frameborder='0' allowtransparency='true'></iframe></p>
<hr>


<p>The Web crypto api describes using Elliptic Curve Diffie-Hellman (ECDH) for key generation and key agreement, as specified by RFC6090.</p>
<p>The recognized algorithm name for this algorithm is "ECDH".</p>
<ol>
<li><strong>generateKey</strong>- Params:    EcKeyGenParams  KeyPair (Normalized Algorithm is "P-256", "P-384" or "P-521")</li>
<li><strong>deriveBits</strong>  Params: EcdhKeyDeriveParams Octet string (normalizedAlgorithm is "P-256", "P-384" or "P-521"))</li>
<li><strong>importKey</strong>   EcKeyImportParams   Key (spki,jwk,raw,pkcs8)</li>
<li><strong>exportKey</strong>   None    ArrayBuffer</li>
</ol>
<p><strong>Named Curve reference</strong></p>
<ol start="1">
<li>secp256r1=P-256</li>
<li>secp384r1=P-384</li>
<li>secp521r1=P-521</li>
</ol>
<hr>
<h2 class="mt-4"><a id="ECDH_Demo_17"></a>ECDH Demo</h2>

<div>
        Named Curve <select class="form-control" name="curve" id="curve">
            <option value="P-256">P-256</option>
            <option value="P-384">P-384</option>
            <option value="P-521">P-521</option>
        </select>

        <button type="button" class="btn btn-primary" onclick="ECDH_DeriveKey_DeriveBits()">ECDH DeriveKey and Derive Bits </button>
    </div>
    



    <div>
        ECDH Derived Bits (Hex) <input class="form-control" type="text" size="100" name="cipherText" id="cipherText" readonly="true"><br>
        ECDH Derived Key Master (Hex) <input class="form-control" type="text" size="100" name="deriveKey" id="deriveKey" readonly="true"><br>

        ECDH Derived Key Usage (JWK)  <textarea class="form-control" name="deriveKeyUsage" id="deriveKeyUsage" cols="10" rows="2"> </textarea><br>
        ECDH Public Key (JWK) : <textarea class="form-control" name="ecdhpublic" id="ecdhpublic" cols="10" rows="2"> </textarea><br>
        ECDH Private Key (JWK): <textarea class="form-control" name="ecdhprivate" id="ecdhprivate" cols="10" rows="2"></textarea>
    </div>

    <div>
        Encrypt Using ECDH Derived Key (Master) <input class="form-control" type="text" name="plainText" value="Hello 8gwifi" id="plainText"> 

        Output <input class="form-control" type="text" size="100" name="cipherTextGCM"  id="cipherTextGCM"> <br>
        <button type="button" class="btn btn-primary" onclick="ECDH_AES_CTR_Encrypt()">Encrypt ECDH-AES-CTR </button>
        <button type="button" class="btn btn-primary" onclick="ECDH_AES_CTR_Decrypt()">Decrypt ECDH-AES-CTR </button>
    </div>

<hr>
<p>This is the web cryptography api example of performing ECDH generateKey and derivebits, and then using generate key to encrypt and decrypt the message in AES</p>
<h2 class="mt-4"><a id="ECDH_Javascript_example_of_using_webcrypto_api_23"></a>ECDH Javascript example of using webcrypto api</h2>
<p>Generate ECDH Keys</p>
<pre><code class="html">   window.crypto.subtle.generateKey({
            name: &quot;ECDH&quot;,
            namedCurve: curve, //can be &quot;P-256&quot;, &quot;P-384&quot;, or &quot;P-521&quot;
        },
        true, //whether the key is extractable (i.e. can be used in exportKey)
        [&quot;deriveKey&quot;, &quot;deriveBits&quot;] //can be any combination of &quot;deriveKey&quot; and &quot;deriveBits&quot;
    )
    .then(function(key) {
        publicKey = key.publicKey;
        privateKey = key.privateKey;
        // For Demo Purpos Only Exported in JWK format
</code></pre>
<p>ECDH exportKey Example  (for demo purpose)</p>
<pre><code class="html">        window.crypto.subtle.exportKey(&quot;jwk&quot;, key.publicKey).then(
            function(keydata) {
                publicKeyhold = keydata;
                publicKeyJson = JSON.stringify(publicKeyhold);
                document.getElementById(&quot;ecdhpublic&quot;).value = publicKeyJson;
            }
        );

        window.crypto.subtle.exportKey(&quot;jwk&quot;, key.privateKey).then(
            function(keydata) {
                privateKeyhold = keydata;
                privateKeyJson = JSON.stringify(privateKeyhold);
                document.getElementById(&quot;ecdhprivate&quot;).value = privateKeyJson;
            }
        );
</code></pre>
<p>ECDH Derive key using name curved algorithms</p>
<pre><code class="html">        window.crypto.subtle.deriveKey({
                    name: &quot;ECDH&quot;,
                    namedCurve: curve, //can be &quot;P-256&quot;, &quot;P-384&quot;, or &quot;P-521&quot;
                    public: publicKey, //an ECDH public key from generateKey or importKey
                },
                privateKey, //your ECDH private key from generateKey or importKey
                { //the key type you want to create based on the derived bits
                    name: &quot;AES-CTR&quot;, //can be any AES algorithm (&quot;AES-CTR&quot;, &quot;AES-CBC&quot;, &quot;AES-CMAC&quot;, &quot;AES-GCM&quot;, &quot;AES-CFB&quot;, &quot;AES-KW&quot;, &quot;ECDH&quot;, &quot;DH&quot;, or &quot;HMAC&quot;)
                    //the generateKey parameters for that type of algorithm
                    length: 256, //can be  128, 192, or 256
                },

           true, //whether the derived key is extractable (i.e. can be used in exportKey)
                [&quot;encrypt&quot;, &quot;decrypt&quot;] //limited to the options in that algorithm's importKey
            )
            .then(function(keydata) {
                //returns the exported key data

                // For Demo Purpos Only Exported in JWK format
                window.crypto.subtle.exportKey(&quot;jwk&quot;, keydata).then(
                    function(keydata) {
                        dKey = keydata;
                        document.getElementById(&quot;deriveKey&quot;).value = dKey.k
                        document.getElementById(&quot;deriveKeyUsage&quot;).value = JSON.stringify(dKey)
                    }
                );
            })
            .catch(function(err) {
                console.error(err);
            });
</code></pre>
<p>ECDH deriveBits</p>
<pre><code class="html">        window.crypto.subtle.deriveBits({
                    name: &quot;ECDH&quot;,
                    namedCurve: curve, //can be &quot;P-256&quot;, &quot;P-384&quot;, or &quot;P-521&quot;
                    public: publicKey, //an ECDH public key from generateKey or importKey
                },
                privateKey, //from generateKey or importKey above
                256 //the number of bits you want to derive
            )
            .then(function(bits) {
                //returns an ArrayBuffer containing the signature
                document.getElementById(&quot;cipherText&quot;).value = bytesToHexString(bits);
            })
            .catch(function(err) {
                console.error(err);
            });
    })
    .catch(function(err) {
        console.error(err);
    });
</code></pre>
<p>}</p>
<p>Performing AES Encryption using ECDH generate Key, by importing JWK key and then deriving the AES encryption key and then encrypting the message, This snippet uses AES-CTR mode</p>
<pre><code class="html">obj = JSON.parse(deriveKeyUsage);
    alg1 = obj.alg;
    ext1 = obj.ext;
    k1 = obj.k;
    kty1 = obj.kty;

    crypto.subtle.importKey(&quot;jwk&quot;, {
        alg: alg1,
        ext: ext1,
        k: k1,
        kty: kty1
    }, &quot;aes-ctr&quot;, false, [&quot;encrypt&quot;]).then(function(key) {
        return crypto.subtle.encrypt({
            name: &quot;aes-ctr&quot;,
            counter: iv,
            length: 128
        }, key, asciiToUint8Array(plainText));
    }, failAndLog).then(function(cipherText) {
        document.getElementById(&quot;cipherTextGCM&quot;).value = bytesToHexString(cipherText);
    }, failAndLog);
</code></pre>
<p>Performing AES Decryption using ECDH Derived Key, by importing JWK key and deriving the AES encryption key and then decryption the message, This snippet uses AES-CTR mode</p>
<pre><code class="html">obj = JSON.parse(deriveKeyUsage);
    alg1 = obj.alg;
    ext1 = obj.ext;
    k1 = obj.k;
    kty1 = obj.kty;

    crypto.subtle.importKey(&quot;jwk&quot;, {
        alg: alg1,
        ext: ext1,
        k: k1,
        kty: kty1
    }, &quot;aes-ctr&quot;, false, [&quot;decrypt&quot;]).then(function(key) {
        return crypto.subtle.decrypt({
            name: &quot;aes-ctr&quot;,
            counter: iv,
            length: 128
        }, key, hexStringToUint8Array(plainText));
    }, failAndLog).then(function(cipherText) {
        alert(bytesToASCIIString(cipherText));
    }, failAndLog);</code></pre>
<hr>
Download the sample code <a href="https://drive.google.com/open?id=1dsE6r_R1ENSR-IQqcSh9SzzoMNTa9fL0">here </a>

<hr>
Next Reading <a href="window-crypto-ecdsa.jsp">Web Crypto API ECDSA Generate Keys Sign & verify Message </a>

<%@ include file="thanks.jsp"%>

<hr>

<%@ include file="addcomments.jsp"%>
      <!-- Comments Form -->
    

          <!-- Single Comment -->
 

          <!-- Comment with nested comments -->
        
          

        </div>

		
        
        <!-- Sidebar Widgets Column -->
        <div class="col-md-4">

          <!-- Ad Widget -->
         <%@ include file="footer_adsense.jsp"%> 
         
         <%@ include file="related-window-crypto.jsp"%>

		 <%@ include file="related-cryptography.jsp"%>
          <!-- Article Widget -->
         <%@ include file="related-ansible.jsp"%>
         
         <%@ include file="related-kube.jsp"%>
         
         
         
         <%@ include file="related-openstack.jsp"%>
         <%@ include file="related-linux.jsp"%>
         
         
         <!-- Topic Widget -->
         <%@ include file="side.jsp"%>
         
           <!-- Add Comments Support -->
         
         
         

        </div>


      </div>
      
      <!-- /.row -->


	
    
    </div>
    
    
    
    
    <!-- /.container -->

    <!-- Footer -->
    <footer class="py-5 bg-dark">
      <div class="container">
        <p class="m-0 text-center text-white">Copyright &copy; 8gwifi.org 2018</p>
      </div>
      <!-- /.container -->
    </footer>
    
    Here

    <!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>


  </body>

</html>