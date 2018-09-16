<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="web crypto api  hashing,digest  example sha,sha512,sha224,md5, the crypto.subtle.digest ">
    <meta name="keywords" content="web crypto api hashing,digest example , windo.crypto javascript examples, Web Cryptography API, sha hashing using crypto.subtle.digest">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>how to perform hashing/digest using web crypto api sha,sha-1,sha224,sha-512 </title>

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
    "@id": "https://8gwifi.org/docs/window-crypto-digest.jsp"
  },
  "name" : "how to perform hashing/digest using web crypto api sha,sha-1,sha224,sha-512 ",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "how to perform hashing/digest using web crypto api sha,sha-1,sha224,sha-512 ",
  "image":"https://8gwifi.org/docs/img/window.crypto.digest.png",
  "datePublished" : "2018-09-16",
  "dateModified": "2018-08-16",
  "articleSection" : "how to perform hashing/digest using web crypto api sha,sha-1,sha224,sha-512 ",
  "articleBody" : [ "Digest/Hashing using Web Cryptography API ", "sha1" , "sha224", "The java script code for crypto.subtle.digest" , "crypto.subtle.digest(algo, buffer)" , "sha512" , "Download the sample code"],
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

<script>

    function SHA_256_HASH() {

        var str = document.getElementById("plainTextGCM").value;
        var buffer = new TextEncoder("utf-8").encode(str);
        return crypto.subtle.digest("SHA-256", buffer).then(
            function (hash) {
                document.getElementById("hashtext").value = hex(hash)
            }
        );
    }
    function SHA_512_HASH() {

        var str = document.getElementById("plainTextGCM").value;
        var buffer = new TextEncoder("utf-8").encode(str);
        return crypto.subtle.digest("SHA-512", buffer).then(
            function (hash) {
                document.getElementById("hashtext").value = hex(hash)
            }
        );
    }

    function SHA_1_HASH() {

        var str = document.getElementById("plainTextGCM").value;
        var buffer = new TextEncoder("utf-8").encode(str);
        return crypto.subtle.digest("SHA-1", buffer).then(
            function (hash) {
                document.getElementById("hashtext").value = hex(hash)
            }
        );
    }



function hex(buffer) {
    var hexCodes = [];
    var view = new DataView(buffer);
    for (var i = 0; i < view.byteLength; i += 4) {
        // Using getUint32 reduces the number of iterations needed (we process 4 bytes each time)
        var value = view.getUint32(i)
        // toString(16) will give the hex representation of the number without padding
        var stringValue = value.toString(16)
        // We use concatenation and slice for padding
        var padding = '00000000'
        var paddedValue = (padding + stringValue).slice(-padding.length)
        hexCodes.push(paddedValue);
    }
    // Join all the hex strings into one

    return hexCodes.join("");
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
          <h1 class="mt-4">Digest/Hashing using Web Cryptography API</h1>

          <!-- Author -->
          <p class="lead">
            by
            <a href="https://www.linkedin.com/in/anishnath">Anish</a>
            <p>Posted on Sunday september 16, 2018</p>
          </p>
          
          
          
          <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>
           
          <hr>

<p>The <a href="https://www.w3.org/TR/WebCryptoAPI/#dfn-Crypto">Crypto</a> interface represents an interface to general purpose cryptographic functionality including a cryptographically strong pseudo-random number generator seeded with truly random values.</p>
<p>The <strong>SubtleCrypto.digest()</strong> method returns a Promise of a digest generated from the hash function and text given as parameters.</p>
<p>The Syntax</p>
<pre><code class="html">var hash = crypto.subtle.digest(algo, buffer);
</code></pre>
<p>web crypto <strong>digest</strong> api supports family of  <strong>SHA</strong> algorithms, older hashing algorithms family like <strong>MD5</strong> is <strong>not</strong> supported by this api</p>

<hr>
<h3 class="mt-4">The Demo</strong></h3>

<p>
<div>
        Plain Text: <input class="form-control" type="text" id="plainTextGCM" value="Hello 8gwifi.org">
        <button class="btn btn-primary"  type="button" onclick="SHA_1_HASH()">sha1</button>
        <button class="btn btn-primary"  type="button" onclick="SHA_256_HASH()">sha256</button>
        <button class="btn btn-primary"  type="button" onclick="SHA_512_HASH()">sha512</button>
        

    </div>
</p>
<p>
    <div>
        Hashed Text: <input class="form-control" type="text" id="hashtext" size="120">
    </div>
</p>

<hr>
<h3 class="mt-4">The java script code for crypto.subtle.digest</h3>
<pre><code class="html"> &lt;script type=&quot;text/javascript&quot;&gt;
    function SHA_256_HASH() {

        var str = document.getElementById(&quot;plainTextGCM&quot;).value;
        var buffer = new TextEncoder(&quot;utf-8&quot;).encode(str);
        return crypto.subtle.digest(&quot;SHA-256&quot;, buffer).then(
            function (hash) {
                document.getElementById(&quot;hashtext&quot;).value = hex(hash)
            }
        );
    }
    function SHA_512_HASH() {

        var str = document.getElementById(&quot;plainTextGCM&quot;).value;
        var buffer = new TextEncoder(&quot;utf-8&quot;).encode(str);
        return crypto.subtle.digest(&quot;SHA-512&quot;, buffer).then(
            function (hash) {
                document.getElementById(&quot;hashtext&quot;).value = hex(hash)
            }
        );
    }

    function SHA_1_HASH() {

        var str = document.getElementById(&quot;plainTextGCM&quot;).value;
        var buffer = new TextEncoder(&quot;utf-8&quot;).encode(str);
        return crypto.subtle.digest(&quot;SHA-1&quot;, buffer).then(
            function (hash) {
                document.getElementById(&quot;hashtext&quot;).value = hex(hash)
            }
        );
    }

function hex(buffer) {
    var hexCodes = [];
    var view = new DataView(buffer);
    for (var i = 0; i &lt; view.byteLength; i += 4) {
        // Using getUint32 reduces the number of iterations needed (we process 4 bytes each time)
        var value = view.getUint32(i)
        // toString(16) will give the hex representation of the number without padding
        var stringValue = value.toString(16)
        // We use concatenation and slice for padding
        var padding = '00000000'
        var paddedValue = (padding + stringValue).slice(-padding.length)
        hexCodes.push(paddedValue);
    }
    // Join all the hex strings into one

    return hexCodes.join(&quot;&quot;);
}
&lt;/script&gt;
</code></pre>
<p><strong>The HTML</strong></p>
<pre><code class="html"> &lt;div&gt;
    Plain Text: &lt;input type=&quot;text&quot; id=&quot;plainTextGCM&quot; value=&quot;Hello 8gwifi.org&quot;&gt;
    &lt;button type=&quot;button&quot; onclick=&quot;SHA_1_HASH()&quot;&gt;sha1&lt;/button&gt;
    &lt;button type=&quot;button&quot; onclick=&quot;SHA_256_HASH()&quot;&gt;sha256&lt;/button&gt;
    &lt;button type=&quot;button&quot; onclick=&quot;SHA_512_HASH()&quot;&gt;sha512&lt;/button&gt;
    

&lt;/div&gt;
&lt;div&gt;
    Hashed Text: &lt;input type=&quot;text&quot; id=&quot;hashtext&quot; size=&quot;120&quot;&gt;
&lt;/div&gt;
</code></pre>
<hr>
Download the sample code <a href="https://drive.google.com/file/d/1uOQretHfNXphDM4sdnq7CCvRge4iEh22/view?usp=sharing">here </a>

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