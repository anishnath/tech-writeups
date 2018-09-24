<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Web Crypto API Generate ECDSA Public Private Keys and perform Sign and Verify Message, jwk format ecdsa ">
    <meta name="keywords" content="Web Crypto API ecdsa named curved generate keys sign verify the message,  ECDSA generate keys, ECDSA keys export to jwk, web crypto deriveKeys ,web crypto live tutorial, windo.crypto javascript examples, Web Cryptography API">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>Web Crypto API Generate ECDSA Public Private Keys and perform Sign and Verify Message</title>

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
    "@id": "https://8gwifi.org/docs/window-crypto-ecdsa.jsp"
  },
  "name" : "Web Crypto API Generate ECDSA Public Private Keys and perform Sign and Verify Message",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "Web Crypto API Generate ECDSA Public Private Keys and perform Sign and Verify Message ",
  "image":"https://8gwifi.org/docs/img/ecdsa.png",
  "datePublished" : "2018-09-24",
  "dateModified": "2018-09-24",
  "articleSection" : "Web Crypto API Generate ECDSA Public Private Keys and perform Sign and Verify Message",
  "articleBody" : [ "Web Crypto API Generate ECDSA Public Private Keys and perform Sign and Verify Message", "ECDSA Javascript example of using webcrypto api" , "Generate ECDSA Keys using the named curved   P-256, P-384,  or P-521", "ECDSA Sign the Message and generate signature" , "ECDSA Verify the message signature", "ecdsa keys jwk format" ],
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

 function ECDSA_Sign() {

    var cryptoObj = window.crypto || window.msCrypto;

    if(!cryptoObj)
    {
        alert("Crypto API is not supported by the Browser");
        return;
    }

    var plainText = document.getElementById("plainText").value;
    var curve = document.getElementById("curve").value;

    window.crypto.subtle.generateKey({
                name: "ECDSA",
                namedCurve: curve, //can be "P-256", "P-384", or "P-521"
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
                    document.getElementById("ecdsapublic").value = publicKeyJson;
                }
            );

            window.crypto.subtle.exportKey("jwk", key.privateKey).then(
                function(keydata) {
                    privateKeyhold = keydata;
                    privateKeyJson = JSON.stringify(privateKeyhold);
                    document.getElementById("ecdsaprivate").value = privateKeyJson;
                }
            );

            window.crypto.subtle.sign({
                        name: "ECDSA",
                        hash: {
                            name: "SHA-256"
                        }, //can be "SHA-1", "SHA-256", "SHA-384", or "SHA-512"
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
    

    
    function ECDSA_Verify() {

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
        alert("Generate ECDSA Keys First")
        return;
    }

    window.crypto.subtle.verify({
                name: "ECDSA",
                hash: {name: "SHA-256"}, //can be "SHA-1", "SHA-256", "SHA-384", or "SHA-512"
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
          <h1 class="mt-4">Web Crypto API ECDSA Generate Keys Sign &amp; verify Message</h1>

          <!-- Author -->
          <p class="lead">
            by
            <a href="https://www.linkedin.com/in/anishnath">Anish</a>
            <p>Posted on Monday september 24, 2018</p>
          </p>
          
          
          
          <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>
           
          <hr>


<p>The Web crypto api ECDSA algorithm identifier is used to perform signing and verification using the ECDSA algorithm specified in RFC6090 and using the SHA hash functions and elliptic curves defined in this specification.</p>

<h2 class="mt-4"><a id="The_Demo_4"></a>ECDSA Web crypto api Demo</h2>
<div>

        SelectNamed Curve <select class="form-control" name="curve" id="curve">
            <option value="P-256">P-256</option>
            <option value="P-384">P-384</option>
            <option value="P-521">P-521</option>
        </select>

        Input Text to Signed<input class="form-control" type="text" name="plainText" value="Hello 8gwifi" id="plainText"> 

        <button type="button" class="btn btn-primary" onclick="ECDSA_Sign()">Generate ECDSA keys and Perform Sign </button>

        <button type="button" class="btn btn-primary" onclick="ECDSA_Verify()">Verify ECDSA Signature </button>
    </div>
    
    <div>
        Signature Output (Hex) <input class="form-control" type="text" size="30" name="cipherText" id="cipherText" readonly="true"><br>
        ECDSA Public Key (JWK) : <textarea class="form-control" readonly="true" name="ecdsapublic" id="ecdsapublic" cols="5" rows="5"></textarea><br>
        ECDSA Private Key (JWK): <textarea class="form-control" readonly="true" name="ecdsaprivate" id="ecdsaprivate" cols="5" rows="5"></textarea>
    </div>
<hr>
<p>This is the web cryptography api example of performing ecdsa message signing and verifying the signature</p>
<h2><a id="ECDSA_Javascript_example_of_using_webcrypto_api_10"></a>ECDSA Javascript example of using webcrypto api</h2>
<p>Generate ECDSA Keys using the named curved  P-256, P-384,  or P-521, The generated ECDSA keys is outputed in JWK format for demo purpose only </p>
<pre><code class="html">  window.crypto.subtle.generateKey({
                name: &quot;ECDSA&quot;,
                namedCurve: curve, //can be &quot;P-256&quot;, &quot;P-384&quot;, or &quot;P-521&quot;
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
                document.getElementById(&quot;ecdsapublic&quot;).value = publicKeyJson;
            }
        );

        window.crypto.subtle.exportKey(&quot;jwk&quot;, key.privateKey).then(
            function(keydata) {
                privateKeyhold = keydata;
                privateKeyJson = JSON.stringify(privateKeyhold);
                document.getElementById(&quot;ecdsaprivate&quot;).value = privateKeyJson;
            }
        );
</code></pre>
<p>ECDSA Sign the Message and generate signature</p>
<pre><code class="html">        window.crypto.subtle.sign({
                    name: &quot;ECDSA&quot;,
                    hash: {
                        name: &quot;SHA-256&quot;
                    }, //can be &quot;SHA-1&quot;, &quot;SHA-256&quot;, &quot;SHA-384&quot;, or &quot;SHA-512&quot;
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
<p>ECDSA Verify the message signature</p>
<pre><code class="html">    window.crypto.subtle.verify({
            name: &quot;ECDSA&quot;,
            hash: {name: &quot;SHA-256&quot;}, //can be &quot;SHA-1&quot;, &quot;SHA-256&quot;, &quot;SHA-384&quot;, or &quot;SHA-512&quot;
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
Download the sample code <a href="https://drive.google.com/file/d/1vbmOSGuy9Plf_DDqK5Lo2_j5IqSOVm4i/view?usp=sharing">here </a>

<hr>
Next Reading <a href="window-crypto-rsaoaep.jsp">RSA Generate Keys and perform Encryption Decryption </a>

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