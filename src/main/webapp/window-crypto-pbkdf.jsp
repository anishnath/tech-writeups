<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Web Crypto API PBKDF2 Generate Password, web crypto live tutorial ">
    <meta name="keywords" content="Web Crypto API PBKDF2 Generate Password, web crypto deriveKeys ,web crypto live tutorial, windo.crypto javascript examples, Web Cryptography API">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>Web Crypto API PBKDF2 Generate Password through deriveKey </title>

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
    "@id": "https://8gwifi.org/docs/window-crypto-pbkdf.jsp"
  },
  "name" : "Web Crypto API PBKDF2 Generate Password",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "Web Crypto API AES-GCM Export Keys with JWK format ",
  "image":"https://8gwifi.org/docs/img/window-crypto-aes3.png",
  "datePublished" : "2018-09-20",
  "dateModified": "2018-09-20",
  "articleSection" : "Web Crypto API PBKDF2 Generate Password example ",
  "articleBody" : [ "Web Crypto API PBKDF2 Generate Password ", "Here's an example showing how to use deriveKey() to create a Secure Remote Password (also known as Proof of Secret) from a user's password" , "TThe Web crypto api Javascript example PBKDF"],
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
function generateKey(password,iterations) {
	// salt should be Uint8Array or ArrayBuffer

	var saltBuffer = crypto.getRandomValues(new Uint8Array(8));
	var encoder = new TextEncoder('utf-8');
	var passphraseKey = encoder.encode("password");

	// You should firstly import your passphrase Uint8array into a CryptoKey
window.crypto.subtle.importKey(
  'raw', 
  passphraseKey, 
  {name: 'PBKDF2'}, 
  false, 
  ['deriveBits', 'deriveKey']
).then(function(key) {

  return window.crypto.subtle.deriveKey(
    { "name": 'PBKDF2',
      "salt": saltBuffer,
      // don't get too ambitious, or at least remember
      // that low-power phones will access your app
      "iterations": iterations,
      "hash": 'SHA-256'
    },
    key,

    // Note: for this demo we don't actually need a cipher suite,
    // but the api requires that it must be specified.
    // For AES the length required to be 128 or 256 bits (not bytes)
    { "name": 'AES-CBC', "length": 256 },

    // Whether or not the key is extractable (less secure) or not (more secure)
    // when false, the key can only be passed as a web crypto object, not inspected
    true,

    // this web crypto object will only be allowed for these functions
    [ "encrypt", "decrypt" ]
  )
}).then(function (webKey) {

  return crypto.subtle.exportKey("raw", webKey);

}).then(function (buffer) {

    document.getElementById("key").value= bytesToHexString(buffer);
    document.getElementById("salt").value= bytesToHexString(saltBuffer);
});

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

function generateKey1() {
	var password = document.getElementById("password").value;
	var iteration = document.getElementById("iteration").value;
	generateKey(password,iteration);
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
          <h1 class="mt-4">Web Crypto API PBKDF2 Generate Password</h1>

          <!-- Author -->
          <p class="lead">
            by
            <a href="https://www.linkedin.com/in/anishnath">Anish</a>
            <p>Posted on Monday september 17, 2018</p>
          </p>
          
          
          
          <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>
           
          <hr>

<p>Here's an example showing how to use <strong>deriveKey()</strong> to create a <strong>Secure Remote Password</strong> (also known as <strong>Proof of Secret</strong>) from a user's password using pbkdf2 algorithm </p>
<h2 class="mt-4"><a id="The_Demo_4"></a>The PBKDF2 Demo</h2>

<label><b>Input Iteration in Numbers:</b></label> <input class="form-control" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" type="text" id="iteration" size="5" value="1000" /><br />
<label><b>Provide Password:</b></label> <input class="form-control" type="password" id="password" value="hello8gwifi" /><br />


<br/>
<input class="btn btn-primary" type="button" onclick="generateKey1()" value="Generate PBKDF2 Keys" />

<hr/>
PBKDF2 Derived Key (Hex): <input class="form-control" readonly="true" size="50" type="text" id="key" /><br />
Random Salt (Hex) : <input class="form-control" readonly="true" type="text" size="40" id="salt" /><br />

<small>Note: Using Fixed salt will generate the same derive key</small>
<hr>
<h2 class="mt-4"><a id="The_Web_crypto_api_Javascript_example__PBKDF_7"></a>The Web crypto api Javascript example  PBKDF</h2>
<pre><code class="html">function generateKey(password,iterations) {
    // salt should be Uint8Array or ArrayBuffer

    var saltBuffer = crypto.getRandomValues(new Uint8Array(8));
    var encoder = new TextEncoder('utf-8');
    var passphraseKey = encoder.encode(&quot;password&quot;);

    // You should firstly import your passphrase Uint8array into a CryptoKey
window.crypto.subtle.importKey(
  'raw', 
  passphraseKey, 
  {name: 'PBKDF2'}, 
  false, 
  ['deriveBits', 'deriveKey']
).then(function(key) {

  return window.crypto.subtle.deriveKey(
    { &quot;name&quot;: 'PBKDF2',
      &quot;salt&quot;: saltBuffer,
      // don't get too ambitious, or at least remember
      // that low-power phones will access your app
      &quot;iterations&quot;: iterations,
      &quot;hash&quot;: 'SHA-256'
    },
    key,

    // Note: for this demo we don't actually need a cipher suite,
    // but the api requires that it must be specified.
    // For AES the length required to be 128 or 256 bits (not bytes)
    { &quot;name&quot;: 'AES-CBC', &quot;length&quot;: 256 },

    // Whether or not the key is extractable (less secure) or not (more secure)
    // when false, the key can only be passed as a web crypto object, not inspected
    true,

    // this web crypto object will only be allowed for these functions
    [ &quot;encrypt&quot;, &quot;decrypt&quot; ]
  )
}).then(function (webKey) {

  return crypto.subtle.exportKey(&quot;raw&quot;, webKey);

}).then(function (buffer) {

     document.getElementById(&quot;key&quot;).value= bytesToHexString(buffer);
     document.getElementById(&quot;salt&quot;).value= bytesToHexString(saltBuffer);
});

}
</code></pre>
<hr>
Download the sample code <a href="https://drive.google.com/file/d/1JzIwodskBoV9mAuzpxnX9-FTgHQVkavc/view?usp=sharing">here </a>

<hr>
Next Reading <a href="window-crypto-aes.jsp">Perform AES Encryption Using importKey Method </a>

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