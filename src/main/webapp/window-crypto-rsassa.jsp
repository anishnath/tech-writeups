<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Web Crypto API RSASSA-PKCS1-v1_5 Generate Keys and Perform rsa pkcs1 sign verify ">
    <meta name="keywords" content="Web Crypto API rsa sign verify,RSASSA-PKCS1-v1_5 generate keys, rsa keys export to jwk, web crypto deriveKeys ,web crypto live tutorial, windo.crypto javascript examples, Web Cryptography API">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>Web Crypto API RSASSA-PKCS1-v1_5 Generate Keys and Perform sign/verify </title>

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
    "@id": "https://8gwifi.org/docs/window-crypto-rsassa.jsp"
  },
  "name" : "Web Crypto API RSASSA-PKCS1-v1_5 Generate Keys and Perform sign/verify",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "Web Crypto API RSASSA-PKCS1-v1_5 Generate Keys Sign and verify Message ",
  "image":"https://8gwifi.org/docs/img/rsassa.png",
  "datePublished" : "2018-09-24",
  "dateModified": "2018-09-24",
  "articleSection" : "Web Crypto API RSASSA-PKCS1-v1_5 Generate Keys and Perform sign/verify ",
  "articleBody" : [ "Web Crypto API RSASSA-PKCS1-v1_5 Generate Keys and Perform sign/verify", "This is the web cryptography api example of performing rsa pkcs1  verify" , "RSASSA-PKCS1-v1_5 Public Key (JWK)" , "webcrypto api RSASSA-PKCS1-v1_5 Javascript example" , "Generate the RSASSA-PKCS1-v1_5 2048 bit Keys using SHA-256 Algorithms" , "RSASSA-PKCS1-v1_5 sign Example" , "RSASSA-PKCS1-v1_5 verify Example"],
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

 function RSASSA_Sign() {

    var cryptoObj = window.crypto || window.msCrypto;

    if(!cryptoObj)
    {
        alert("Crypto API is not supported by the Browser");
        return;
    }

    var plainText = document.getElementById("plainText").value;

    window.crypto.subtle.generateKey({
                name: "RSASSA-PKCS1-v1_5",
                modulusLength: 2048, //can be 1024, 2048, or 4096
                publicExponent: new Uint8Array([0x01, 0x00, 0x01]),
                hash: {name: "SHA-256"}, //can be "SHA-1", "SHA-256", "SHA-384", or "SHA-512"
            },
            true, //whether the key is extractable (i.e. can be used in exportKey)
            ["sign", "verify"] //can be any combination of "sign" and "verify"
        )
        .then(function(key) {

            publicKey = key.publicKey;
            privateKey = key.privateKey;
            // For Demo Purpos Only Exported in JWK format
            window.crypto.subtle.exportKey("jwk", key.publicKey).then(
                function(keydata) {
                    publicKeyhold = keydata;
                    publicKeyJson = JSON.stringify(publicKeyhold);
                    document.getElementById("rsapublic").value = publicKeyJson;
                }
            );

            window.crypto.subtle.exportKey("jwk", key.privateKey).then(
                function(keydata) {
                    privateKeyhold = keydata;
                    privateKeyJson = JSON.stringify(privateKeyhold);
                    document.getElementById("rsaprivate").value = privateKeyJson;
                }
            );

            window.crypto.subtle.sign({
                        name: "RSASSA-PKCS1-v1_5",
                    },
                    privateKey, //from generateKey or importKey above
                    asciiToUint8Array(plainText) //ArrayBuffer of data you want to sign
                )
                .then(function(signature) {
                    //returns an ArrayBuffer containing the signature
                    document.getElementById("cipherText").value = bytesToHexString(signature);
                })
                .catch(function(err) {
                    console.error(err);
                });


        })
        .catch(function(err) {
            console.error(err);
        });
}
    

    
    function RSASSA_Verify() {

    var cryptoObj = window.crypto || window.msCrypto;

    if(!cryptoObj)
    {
        alert("Crypto API is not supported by the Browser");
        return;
    }
    
    var cipherText = document.getElementById("cipherText").value;
    var plainText = document.getElementById("plainText").value;

    if(!publicKey)
    {
        alert("Generate RSASSA-PKCS1-v1_5 Keys First")
        return;
    }

    window.crypto.subtle.verify({
                name: "RSASSA-PKCS1-v1_5",
            },
            publicKey, //from generateKey or importKey above
            hexStringToUint8Array(cipherText), //ArrayBuffer of the data
            asciiToUint8Array(plainText)
        )
        .then(function(decrypted) {
            alert("Verified   " + decrypted);
        })
        .catch(function(err) {
            console.error(err);
        });

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
          <h1 class="mt-4">Web Crypto API RSASSA-PKCS1-v1_5 Generate Keys Sign &amp; verify Message</h1>

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



<p>The Web crypto api  RSASSA-PKCS1-v1_5 algorithm identifier is used to perform signing and verification using the RSASSA-PKCS1-v1_5 algorithm specified in [RFC3447] and using the SHA hash functions defined in this specification.</p>
<ul>
<li><strong>Sign</strong>: Perform the signature generation operation</li>
<li><strong>Verify</strong>: Perform the signature verification operation</li>
<li><strong>Generate Key</strong>: Generate an RSA key pair, with RSA modulus length equal to the modulusLength attribute of normalizedAlgorithm and RSA public exponent equal to the publicExponent attribute of normalizedAlgorithm</li>
</ul>
<h2 class="mt-4"><a id="RSASSAPKCS1v1_5_Demo_8"></a>RSASSA-PKCS1-v1_5 Demo</h2>
<p>This is the web cryptography api example of performing RSASSA-PKCS1-v1_5 message signing and verifying the signature, for the demo purpose the RSASSA-PKCS1-v1_5 keys are extracted in JWK format </p>

<div>

        Input Text to Signed<input type="text" class="form-control" name="plainText" value="Hello 8gwifi" id="plainText"> 

        <button type="button" class="btn btn-primary" onclick="RSASSA_Sign()">Generate RSASSA-PKCS1-v1_5 keys and Perform Sign </button>

        <button type="button" class="btn btn-primary" onclick="RSASSA_Verify()">Verify RSASSA-PKCS1-v1_5 Signature </button>
    </div>
    
    <div>
        Signature Output (Hex) <input class="form-control" type="text" size="90" name="cipherText" id="cipherText" readonly="true"><br>
        RSASSA-PKCS1-v1_5 Public Key (JWK) : <textarea class="form-control" readonly="true" name="rsapublic" id="rsapublic" cols="30" rows="10"> </textarea><br>
        RSASSA-PKCS1-v1_5 Private Key (JWK): <textarea class="form-control" readonly="true" name="rsaprivate" id="rsaprivate" cols="30" rows="10"></textarea>
    </div>

<hr>
<h2 class="mt-4"><a id="RSASSAPKCS1v1_5_Javascript_example_of_using_webcrypto_api_12"></a>RSASSA-PKCS1-v1_5 Javascript example of using webcrypto api</h2>
<p>Generate RSASSA-PKCS1-v1_5 Keys for the signing and verifying purpose, message signing is done through</p>
<pre><code class="html">   window.crypto.subtle.generateKey({
            name: &quot;RSASSA-PKCS1-v1_5&quot;,
            modulusLength: 2048, //can be 1024, 2048, or 4096
            publicExponent: new Uint8Array([0x01, 0x00, 0x01]),
            hash: {name: &quot;SHA-256&quot;}, //can be &quot;SHA-1&quot;, &quot;SHA-256&quot;, &quot;SHA-384&quot;, or &quot;SHA-512&quot;
        },
        true, //whether the key is extractable (i.e. can be used in exportKey)
        [&quot;sign&quot;, &quot;verify&quot;] //can be any combination of &quot;sign&quot; and &quot;verify&quot;
    )
    .then(function(key) {

        publicKey = key.publicKey;
        privateKey = key.privateKey;
        // For Demo Purpos Only Exported in JWK format
        window.crypto.subtle.exportKey(&quot;jwk&quot;, key.publicKey).then(
            function(keydata) {
                publicKeyhold = keydata;
                publicKeyJson = JSON.stringify(publicKeyhold);
                document.getElementById(&quot;rsapublic&quot;).value = publicKeyJson;
            }
        );

        window.crypto.subtle.exportKey(&quot;jwk&quot;, key.privateKey).then(
            function(keydata) {
                privateKeyhold = keydata;
                privateKeyJson = JSON.stringify(privateKeyhold);
                document.getElementById(&quot;rsaprivate&quot;).value = privateKeyJson;
            }
        );
</code></pre>
<p>The sign process using the user private key.</p>
<pre><code class="html">        window.crypto.subtle.sign({
                    name: &quot;RSASSA-PKCS1-v1_5&quot;,
                },
                privateKey, //from generateKey or importKey above
                asciiToUint8Array(plainText) //ArrayBuffer of data you want to sign
            )
            .then(function(signature) {
                //returns an ArrayBuffer containing the signature
                document.getElementById(&quot;cipherText&quot;).value = bytesToHexString(signature);
            })
            .catch(function(err) {
                console.error(err);
            });


    })
    .catch(function(err) {
        console.error(err);
    });
</code></pre>
<p>RSASSA-PKCS1-v1_5 Verify the message signature using the public key</p>
<pre><code class="html">    window.crypto.subtle.verify({
            name: &quot;RSASSA-PKCS1-v1_5&quot;,
        },
        publicKey, //from generateKey or importKey above
        hexStringToUint8Array(cipherText), //ArrayBuffer of the data
        asciiToUint8Array(plainText)
    )
    .then(function(decrypted) {
        alert(&quot;Verified   &quot; + decrypted);
    })
    .catch(function(err) {
        console.error(err);
    });
</code></pre>
<hr>
Download the sample code <a href="https://leanpub.com/cryptojs">here </a>

<hr>
Next Reading <a href="window-crypto-rsaoaep.jsp">RSA-OAEP generateKey/Encrypt/Decrypt </a>

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
         
         <%@ include file="related-go.jsp"%>

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