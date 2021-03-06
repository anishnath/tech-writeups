<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="web crypto api aes encryption decryption example aes-ctr,aes-gcm,aes-cbc,aes-ctr ">
    <meta name="keywords" content="web crypto api aes encryption decryption example aes-ctr,aes-gcm,aes-cbc,aes-ctr , windo.crypto javascript examples, Web Cryptography API">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>web crypto api aes encryption decryption example aes-ctr,aes-gcm,aes-cbc,aes-ctr </title>

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
    "@id": "https://8gwifi.org/docs/window-crypto-aes.jsp"
  },
  "name" : "web crypto api aes encryption decryption example aes-ctr,aes-gcm,aes-cbc,aes-ctr ",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "web crypto api aes encryption decryption example aes-ctr,aes-gcm,aes-cbc,aes-ctr ",
  "image":"https://8gwifi.org/docs/img/window.crypto.aes.png",
  "datePublished" : "2018-09-16",
  "dateModified": "2018-08-16",
  "articleSection" : "web crypto api aes encryption decryption example aes-ctr,aes-gcm,aes-cbc,aes-ctr ",
  "articleBody" : [ "The AES Encryption/Decryption Mode ", "AES-CTR" , "AES-CBC", "AES-GCM" , "AES-KW" , "The importKey method" , "The Web Cryptography javascript code"],
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
    var keyData = hexStringToUint8Array("1bf8be421b201adf247297140aa76cc8211620976125db505d348cd60bee4198");
    var iv = crypto.getRandomValues(new Uint8Array(16));   

     function AES_CTR_encrypt()
        {
            crypto.subtle.importKey("raw", keyData, "aes-ctr", false, ["encrypt"]).then(function(key) {
                var plainText = document.getElementById("plainTextGCM").value;
                return crypto.subtle.encrypt({name: "aes-ctr", counter: iv,length: 128}, key, asciiToUint8Array(plainText));
            }, failAndLog).then(function(cipherText) {
                document.getElementById("cipherTextGCM").value = bytesToHexString(cipherText);
            }, failAndLog);
        }

    function AES_GCM_encrypt()
    {
        crypto.subtle.importKey("raw", keyData, "aes-gcm", false, ["encrypt"]).then(function(key) {
            var plainText = document.getElementById("plainTextGCM").value;
            return crypto.subtle.encrypt({name: "aes-gcm", iv: iv}, key, asciiToUint8Array(plainText));
        }, failAndLog).then(function(cipherText) {
            document.getElementById("cipherTextGCM").value = bytesToHexString(cipherText);
        }, failAndLog);
    }
    function AES_GCM_decrypt()
    {
        crypto.subtle.importKey("raw", keyData, "aes-gcm", false, ["decrypt"]).then(function(key) {
            var cipherText = document.getElementById("cipherTextGCM").value;
            return crypto.subtle.decrypt({name: "aes-gcm", iv: iv}, key, hexStringToUint8Array(cipherText));
        }, failAndLog).then(function(plainText) {
            document.getElementById("resultGCM").innerHTML = "Result: " + bytesToASCIIString(plainText);
        }, function(result) {
            document.getElementById("resultGCM").innerHTML = "Result: " + result;
        });
    }
    function AES_CBC_encrypt()
    {
        crypto.subtle.importKey("raw", keyData, "aes-cbc", false, ["encrypt"]).then(function(key) {
            var plainText = document.getElementById("plainTextGCM").value;
            return crypto.subtle.encrypt({name: "aes-cbc", iv: iv}, key, asciiToUint8Array(plainText));
        }, failAndLog).then(function(cipherText) {
            document.getElementById("cipherTextGCM").value = bytesToHexString(cipherText);
        }, failAndLog);
    }

    function AES_CTR_decrypt()
        {
            crypto.subtle.importKey("raw", keyData, "aes-ctr", false, ["decrypt"]).then(function(key) {
                var cipherText = document.getElementById("cipherTextGCM").value;
                return crypto.subtle.decrypt({name: "aes-ctr", counter: iv, length:128}, key, hexStringToUint8Array(cipherText));
            }, failAndLog).then(function(plainText) {
                document.getElementById("resultGCM").innerHTML = "Result: " + bytesToASCIIString(plainText);
            }, function(result) {
                document.getElementById("resultGCM").innerHTML = "Result: " + result;
            });
        }

    function AES_CBC_decrypt()
    {
        crypto.subtle.importKey("raw", keyData, "aes-cbc", false, ["decrypt"]).then(function(key) {
            var cipherText = document.getElementById("cipherTextGCM").value;
            return crypto.subtle.decrypt({name: "aes-cbc", iv: iv}, key, hexStringToUint8Array(cipherText));
        }, failAndLog).then(function(plainText) {
            document.getElementById("resultGCM").innerHTML = "Result: " + bytesToASCIIString(plainText);
        }, failAndLog);
    }

    function hexStringToUint8Array(hexString)
    {
        if (hexString.length % 2 != 0)
            throw "Invalid hexString";
        var arrayBuffer = new Uint8Array(hexString.length / 2);

        for (var i = 0; i < hexString.length; i += 2) {
            var byteValue = parseInt(hexString.substr(i, 2), 16);
            if (byteValue == NaN)
                throw "Invalid hexString";
            arrayBuffer[i/2] = byteValue;
        }

        return arrayBuffer;
    }

function bytesToHexString(bytes)
{
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
function asciiToUint8Array(str)
{
    var chars = [];
    for (var i = 0; i < str.length; ++i)
        chars.push(str.charCodeAt(i));
    return new Uint8Array(chars);
}
function bytesToASCIIString(bytes)
{
    return String.fromCharCode.apply(null, new Uint8Array(bytes));
}
function failAndLog(error)
{
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
          <h1 class="mt-4">AES Encryption/Decryption using Web Cryptography API</h1>

          <!-- Author -->
          <p class="lead">
            by
            <a href="https://www.linkedin.com/in/anishnath">Anish</a>
            <p>Posted on Sunday september 16, 2018</p>
          </p>
          
          
          
          <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>
           
          <hr>

<p><mark>This sample chapter </mark> extracted from the book, <a href="https://leanpub.com/crypto">Cryptography for JavaScript Developers</a>. </p>
<p><iframe width='160' height='400' src='https://leanpub.com/cryptojs/embed' frameborder='0' allowtransparency='true'></iframe></p>
<hr>
<p>The <a href="https://www.w3.org/TR/WebCryptoAPI/#dfn-Crypto">Crypto</a> interface represents an interface to general purpose cryptographic functionality including a cryptographically strong pseudo-random number generator seeded with truly random values.</p>
<h3 class="mt-4">The AES Encryption/Decryption Mode</h3>
<ul>
<li>
<p>The <code>AES-CTR</code> algorithm identifier is used to perform encryption and decryption using AES in Counter mode.</p>
</li>
<li>
<p>The <code>&quot;AES-CBC&quot;</code> algorithm identifier is used to perform encryption and decryption using AES in Cipher Block Chaining mode</p>
</li>
<li>
<p>The <code>&quot;AES-GCM&quot;</code> algorithm identifier is used to perform authenticated encryption and decryption using AES in Galois/Counter Mode mode</p>
</li>
<li>
<p>The <code>&quot;AES-KW&quot;</code> algorithm identifier is used to perform key wrapping using AES,</p>
</li>
</ul>
<hr>
<h3 class="mt-4">The Demo</h3>

<p>AES key is hardcoded in the javascript code.</p>
<p>
<div>
        Plain Text: <input class="form-control" type="text" id="plainTextGCM" value="Hello, 8gwifi.org">
        <br>
        <button  class="btn btn-primary" type="button" onclick="AES_GCM_encrypt()">Encrypt-GCM</button>
        <button class="btn btn-primary" type="button" onclick="AES_CBC_encrypt()">Encrypt-CBC</button>
        <button class="btn btn-primary" type="button" onclick="AES_CTR_encrypt()">Encrypt-CTR</button>
    </div>
</p>
<p>
    <div>
        Cipher Text: <input class="form-control" type="text" id="cipherTextGCM" size="50">
        <br/>
        <button class="btn btn-primary" type="button" onclick="AES_GCM_decrypt()">Decrypt-GCM</button>
        <button class="btn btn-primary" type="button" onclick="AES_CBC_decrypt()">Decrypt-CBC</button>
        <button class="btn btn-primary" type="button" onclick="AES_CTR_decrypt()">Decrypt-CTR</button>
    </div>
    <div id="resultGCM">
        Result:
    </div>
</p>
    <hr>

<p><strong>The importKey method</strong></p>
<p>The SubtleCrypto.importKey() method returns a Promise of the CryptoKey generated from the data given in parameters.</p>
<pre><code class="html"> var result = crypto.subtle.importKey(_format_, keyData, algo, extractable, usages);
</code></pre>
<p><strong>The Web Cryptography javascript code</strong></p>
<pre><code class="html">&lt;script type=&quot;text/javascript&quot;&gt;
    var keyData = hexStringToUint8Array(&quot;1bf8be421b201adf247297140aa76cc8211620976125db505d348cd60bee4198&quot;);
    var iv = crypto.getRandomValues(new Uint8Array(16));   

     function AES_CTR_encrypt()
        {
            crypto.subtle.importKey(&quot;raw&quot;, keyData, &quot;aes-ctr&quot;, false, [&quot;encrypt&quot;]).then(function(key) {
                var plainText = document.getElementById(&quot;plainTextGCM&quot;).value;
                return crypto.subtle.encrypt({name: &quot;aes-ctr&quot;, counter: iv,length: 128}, key, asciiToUint8Array(plainText));
            }, failAndLog).then(function(cipherText) {
                document.getElementById(&quot;cipherTextGCM&quot;).value = bytesToHexString(cipherText);
            }, failAndLog);
        }

    function AES_GCM_encrypt()
    {
        crypto.subtle.importKey(&quot;raw&quot;, keyData, &quot;aes-gcm&quot;, false, [&quot;encrypt&quot;]).then(function(key) {
            var plainText = document.getElementById(&quot;plainTextGCM&quot;).value;
            return crypto.subtle.encrypt({name: &quot;aes-gcm&quot;, iv: iv}, key, asciiToUint8Array(plainText));
        }, failAndLog).then(function(cipherText) {
            document.getElementById(&quot;cipherTextGCM&quot;).value = bytesToHexString(cipherText);
        }, failAndLog);
    }
    function AES_GCM_decrypt()
    {
        crypto.subtle.importKey(&quot;raw&quot;, keyData, &quot;aes-gcm&quot;, false, [&quot;decrypt&quot;]).then(function(key) {
            var cipherText = document.getElementById(&quot;cipherTextGCM&quot;).value;
            return crypto.subtle.decrypt({name: &quot;aes-gcm&quot;, iv: iv}, key, hexStringToUint8Array(cipherText));
        }, failAndLog).then(function(plainText) {
            document.getElementById(&quot;resultGCM&quot;).innerHTML = &quot;Result: &quot; + bytesToASCIIString(plainText);
        }, function(result) {
            document.getElementById(&quot;resultGCM&quot;).innerHTML = &quot;Result: &quot; + result;
        });
    }
    function AES_CBC_encrypt()
    {
        crypto.subtle.importKey(&quot;raw&quot;, keyData, &quot;aes-cbc&quot;, false, [&quot;encrypt&quot;]).then(function(key) {
            var plainText = document.getElementById(&quot;plainTextGCM&quot;).value;
            return crypto.subtle.encrypt({name: &quot;aes-cbc&quot;, iv: iv}, key, asciiToUint8Array(plainText));
        }, failAndLog).then(function(cipherText) {
            document.getElementById(&quot;cipherTextGCM&quot;).value = bytesToHexString(cipherText);
        }, failAndLog);
    }

    function AES_CTR_decrypt()
        {
            crypto.subtle.importKey(&quot;raw&quot;, keyData, &quot;aes-ctr&quot;, false, [&quot;decrypt&quot;]).then(function(key) {
                var cipherText = document.getElementById(&quot;cipherTextGCM&quot;).value;
                return crypto.subtle.decrypt({name: &quot;aes-ctr&quot;, counter: iv, length:128}, key, hexStringToUint8Array(cipherText));
            }, failAndLog).then(function(plainText) {
                document.getElementById(&quot;resultGCM&quot;).innerHTML = &quot;Result: &quot; + bytesToASCIIString(plainText);
            }, function(result) {
                document.getElementById(&quot;resultGCM&quot;).innerHTML = &quot;Result: &quot; + result;
            });
        }

    function AES_CBC_decrypt()
    {
        crypto.subtle.importKey(&quot;raw&quot;, keyData, &quot;aes-cbc&quot;, false, [&quot;decrypt&quot;]).then(function(key) {
            var cipherText = document.getElementById(&quot;cipherTextGCM&quot;).value;
            return crypto.subtle.decrypt({name: &quot;aes-cbc&quot;, iv: iv}, key, hexStringToUint8Array(cipherText));
        }, failAndLog).then(function(plainText) {
            document.getElementById(&quot;resultGCM&quot;).innerHTML = &quot;Result: &quot; + bytesToASCIIString(plainText);
        }, failAndLog);
    }
</code></pre>
<p><strong>The HTML</strong></p>
<pre><code class="html">&lt;div&gt;
        Plain Text: &lt;input type=&quot;text&quot; id=&quot;plainTextGCM&quot; value=&quot;Hello, 8gwifi.org&quot;&gt;
        &lt;button type=&quot;button&quot; onclick=&quot;AES_GCM_encrypt()&quot;&gt;encryptGCM&lt;/button&gt;
        &lt;button type=&quot;button&quot; onclick=&quot;AES_CBC_encrypt()&quot;&gt;encryptCBC&lt;/button&gt;
        &lt;button type=&quot;button&quot; onclick=&quot;AES_CTR_encrypt()&quot;&gt;encryptCTR&lt;/button&gt;
    &lt;/div&gt;
    &lt;div&gt;
        Cipher Text: &lt;input type=&quot;text&quot; id=&quot;cipherTextGCM&quot; size=&quot;50&quot;&gt;
        &lt;button type=&quot;button&quot; onclick=&quot;AES_GCM_decrypt()&quot;&gt;decryptGCM&lt;/button&gt;
        &lt;button type=&quot;button&quot; onclick=&quot;AES_CTR_decrypt()&quot;&gt;decryptCTR&lt;/button&gt;
    &lt;/div&gt;
  
    &lt;div id=&quot;resultGCM&quot;&gt;
        Result:
    &lt;/div&gt;
</code></pre>
<hr>
<hr>
Next Reading <a href="window-crypto-aes2.jsp">Perform AES-GCM Encryption Using generateKey Method </a>

<hr>
Download the sample code <a href="https://leanpub.com/cryptojs">here </a>

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