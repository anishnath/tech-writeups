<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="php openssl tutorial on openssl_cipher_iv_length, php openssl_cipher_iv_length example, php openssl functions, php block cipher mode operation and initial vector length requirement">
    <meta name="keywords" content="aes initial vector length, openssl_cipher_iv_length, php openssl_cipher_iv_length example, php cryptography topics, php security, php interview questions, php openssl functions, php book">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>php openssl tutorial on openssl_cipher_iv_length</title>

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
    "@id": "https://8gwifi.org/docs/php-iv.jsp"
  },
  "name" : "Block Cipher Mode Initial Vector Length",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "php block cipher mode operation and initial vector length requirement",
  "image":"https://8gwifi.org/docs/img/php/php-iv.png",
  "datePublished" : "2018-12-12",
  "dateModified": "2018-12-12",
  "articleSection" : "php openssl tutorial on openssl_cipher_iv_length",
  "articleBody" : [ "php openssl example ", "php openssl_cipher_iv_length" , "php openssl functions", "php cryptography", "block cipher modes initial vector minimum size"],
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
          <h1 class="mt-4">php block cipher mode operation and initial vector length requirement</h1>

          <!-- Author -->
          <p class="lead">
            by
            <a href="https://www.linkedin.com/in/anishnath">Anish</a>
            <p>Posted on Thursday December 13 , 2018</p>
          </p>
          
          
          
          <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>
           
          
          <hr>
<h2><a id="openssl_cipher_iv_length_0"></a>openssl_cipher_iv_length</h2>
<p>An <a href="https://en.wikipedia.org/wiki/Initialization_vector"><strong>IV</strong></a> or initialization vector is, in its broadest sense, just the initial value used to start some iterated process. The term is used in a couple of different contexts, and implies different security requirements in each of them. For example, <a href="https://en.wikipedia.org/wiki/Cryptographic_hash_function">cryptographic hash functions</a> typically have a fixed IV.</p>
<p>Conversely, most <a href="https://en.wikipedia.org/wiki/Block_cipher_modes_of_operation">block cipher modes of operation</a> require an IV which is random and unpredictable, or at least unique for each message encrypted with a given key. Different  block cipher modes have different IV length requirement.</p>
<p><strong>openssl_cipher_iv_length</strong>: Gets the Cipher initialization vector (iv) Length</p>
<ul>
<li>Supported PHP Versions (<strong>PHP 5 &gt;= 5.3.0, PHP 7</strong>)</li>
</ul>
<p>The Syntax</p>
<p></p>
<pre><code class="language-php">int  openssl_cipher_iv_length ( string  <span class="hljs-variable">$method</span> )
</code></pre>
<ul>
<li><strong>method</strong>: The cipher method, see  <a href="php-ciphermethods.jsp">openssl_get_cipher_methods()</a>  for a list of potential values.</li>
<li><strong>Returns</strong>: Returns the cipher length on success, or <strong><code>FALSE</code></strong> on failure</li>
</ul>
<p><strong>Examples</strong></p>
<p><strong>openssl_cipher_iv_length()</strong>  example</p>
<p></p>
<pre><code class="language-php"><span class="hljs-preprocessor">&lt;?php</span>  
<span class="hljs-comment">/**  
 * Created by https://8gwifi.org  
 * User: Anish Nath  
 * Date: 2018-12-13 * Time: 09:25 
 * */</span>  
<span class="hljs-variable">$ciphers</span> = openssl_get_cipher_methods();  
  
<span class="hljs-comment">//ECB mode should be avoided  </span>
<span class="hljs-variable">$ciphers</span> = array_filter(<span class="hljs-variable">$ciphers</span>, <span class="hljs-function"><span class="hljs-keyword">function</span> <span class="hljs-params">(<span class="hljs-variable">$n</span>)</span> </span>{  
  <span class="hljs-keyword">return</span> stripos(<span class="hljs-variable">$n</span>, <span class="hljs-string">"ecb"</span>) === <span class="hljs-keyword">FALSE</span>;  
});  
  
<span class="hljs-comment">//  Openssl declared the following weak: RC2, RC4, DES, 3DES, MD5 based  </span>
<span class="hljs-variable">$ciphers</span> = array_filter(<span class="hljs-variable">$ciphers</span>, <span class="hljs-function"><span class="hljs-keyword">function</span> <span class="hljs-params">(<span class="hljs-variable">$c</span>)</span> </span>{  
  <span class="hljs-keyword">return</span> stripos(<span class="hljs-variable">$c</span>, <span class="hljs-string">"des"</span>) === <span class="hljs-keyword">FALSE</span>;  
});  
<span class="hljs-variable">$ciphers</span> = array_filter(<span class="hljs-variable">$ciphers</span>, <span class="hljs-function"><span class="hljs-keyword">function</span> <span class="hljs-params">(<span class="hljs-variable">$c</span>)</span> </span>{  
  <span class="hljs-keyword">return</span> stripos(<span class="hljs-variable">$c</span>, <span class="hljs-string">"rc2"</span>) === <span class="hljs-keyword">FALSE</span>;  
});  
<span class="hljs-variable">$ciphers</span> = array_filter(<span class="hljs-variable">$ciphers</span>, <span class="hljs-function"><span class="hljs-keyword">function</span> <span class="hljs-params">(<span class="hljs-variable">$c</span>)</span> </span>{  
  <span class="hljs-keyword">return</span> stripos(<span class="hljs-variable">$c</span>, <span class="hljs-string">"rc4"</span>) === <span class="hljs-keyword">FALSE</span>;  
});  
<span class="hljs-variable">$ciphers</span> = array_filter(<span class="hljs-variable">$ciphers</span>, <span class="hljs-function"><span class="hljs-keyword">function</span> <span class="hljs-params">(<span class="hljs-variable">$c</span>)</span> </span>{  
  <span class="hljs-keyword">return</span> stripos(<span class="hljs-variable">$c</span>, <span class="hljs-string">"md5"</span>) === <span class="hljs-keyword">FALSE</span>;  
});  
  
<span class="hljs-keyword">if</span> (is_array(<span class="hljs-variable">$ciphers</span>)) {  
  <span class="hljs-keyword">foreach</span> (<span class="hljs-variable">$ciphers</span> <span class="hljs-keyword">as</span> <span class="hljs-variable">$cipher</span>) {  
  <span class="hljs-keyword">echo</span> <span class="hljs-variable">$cipher</span>.<span class="hljs-string">': '</span>;  
  <span class="hljs-keyword">echo</span> openssl_cipher_iv_length(<span class="hljs-variable">$cipher</span>);  
  <span class="hljs-keyword">echo</span> <span class="hljs-string">"\n"</span>;  
  }  
}
</code></pre>
<p>The above example will output something similar to:</p>
<p></p>
<pre><code class="language-console">$ /usr/bin/php get_iv_length.php
AES-128-CBC: 16
AES-128-CFB: 16
AES-128-CFB1: 16
AES-128-CFB8: 16
AES-128-CTR: 16
AES-128-OFB: 16
AES-128-XTS: 16
AES-192-CBC: 16
AES-192-CFB: 16
AES-192-CFB1: 16
AES-192-CFB8: 16
AES-192-CTR: 16
AES-192-OFB: 16
AES-256-CBC: 16
AES-256-CFB: 16
AES-256-CFB1: 16
AES-256-CFB8: 16
AES-256-CTR: 16
AES-256-OFB: 16
AES-256-XTS: 16
BF-CBC: 8
BF-CFB: 8
BF-OFB: 8
CAMELLIA-128-CBC: 16
CAMELLIA-128-CFB: 16
CAMELLIA-128-CFB1: 16
CAMELLIA-128-CFB8: 16
CAMELLIA-128-OFB: 16
CAMELLIA-192-CBC: 16
CAMELLIA-192-CFB: 16
CAMELLIA-192-CFB1: 16
CAMELLIA-192-CFB8: 16
CAMELLIA-192-OFB: 16
CAMELLIA-256-CBC: 16
CAMELLIA-256-CFB: 16
CAMELLIA-256-CFB1: 16
CAMELLIA-256-CFB8: 16
CAMELLIA-256-OFB: 16
CAST5-CBC: 8
CAST5-CFB: 8
CAST5-OFB: 8
ChaCha: 8
GOST 28147-89: 8
aes-128-cbc: 16
aes-128-cfb: 16
aes-128-cfb1: 16
aes-128-cfb8: 16
aes-128-ctr: 16
aes-128-gcm: 12
aes-128-ofb: 16
aes-128-xts: 16
aes-192-cbc: 16
aes-192-cfb: 16
aes-192-cfb1: 16
aes-192-cfb8: 16
aes-192-ctr: 16
aes-192-gcm: 12
aes-192-ofb: 16
aes-256-cbc: 16
aes-256-cfb: 16
aes-256-cfb1: 16
aes-256-cfb8: 16
aes-256-ctr: 16
aes-256-gcm: 12
aes-256-ofb: 16
aes-256-xts: 16
bf-cbc: 8
bf-cfb: 8
bf-ofb: 8
camellia-128-cbc: 16
camellia-128-cfb: 16
camellia-128-cfb1: 16
camellia-128-cfb8: 16
camellia-128-ofb: 16
camellia-192-cbc: 16
camellia-192-cfb: 16
camellia-192-cfb1: 16
camellia-192-cfb8: 16
camellia-192-ofb: 16
camellia-256-cbc: 16
camellia-256-cfb: 16
camellia-256-cfb1: 16
camellia-256-cfb8: 16
camellia-256-ofb: 16
cast5-cbc: 8
cast5-cfb: 8
cast5-ofb: 8
chacha: 8
gost89: 8
gost89-cnt: 8
id-aes128-GCM: 12
id-aes192-GCM: 12
id-aes256-GCM: 12
</code></pre>
<p></p>

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
         
         
         <%@ include file="related-go.jsp"%>
         
         <%@ include file="related-cryptography.jsp"%>
         
         <%@ include file="related-window-crypto.jsp"%>

		 
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
    

    <!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>


  </body>

</html>