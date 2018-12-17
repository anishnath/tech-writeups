<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="php Encryption/Decryption, aes,des,ofb,cbc,gcm,camelia,gost,rc4">
    <meta name="keywords" content="aes initial vector length, openssl_encrypt php openssl_decrypt example, php cryptography topics, php security, php interview questions, php openssl functions, php book">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>php Encryption/Decryption, aes,des,ofb,cbc,gcm,camelia,gost,rc4</title>

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
    "@id": "https://8gwifi.org/docs/php-encrypt.jsp"
  },
  "name" : "php Encryption/Decryption",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "php block cipher mode operation encryption decryption, aes,des,ofb,cbc,gcm,camelia,gost,rc4",
  "image":"https://8gwifi.org/docs/img/php/php-encrypt.png",
  "datePublished" : "2018-12-12",
  "dateModified": "2018-12-12",
  "articleSection" : "php openssl tutorial on openssl_decrypt",
  "articleBody" : [ "php openssl example ", "php openssl_decrypt" , "php openssl functions", "php cryptography", "block cipher modes initial vector minimum size", "php aes-128-cbc encrypt/decrypt example", "php aes-192-cfb encrypt/decrypt example" , "php aes-256-ofb encrypt/decrypt example" , "php aes-256-gcm encrypt/decrypt example" , "php camellia-256-ofb encrypt/decrypt example"],
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
          <h1 class="mt-4">php Encryption/Decryption</h1>

          <!-- Author -->
          <p class="lead">
            by
            <a href="https://www.linkedin.com/in/anishnath">Anish</a>
            <p>Posted on Thursday December 13 , 2018</p>
          </p>
          
          
          
          <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>
           
          
          <hr>

<h2><a id="openssl_encryptdecrypt_0"></a>openssl_encrypt/decrypt</h2>
<p><strong>openssl_encrypt</strong>: Encrypt the data<br>
<strong>openssl_decrypt</strong>: Decrypt the data</p>
<ul>
<li>Supported PHP Versions (<strong>PHP 5 &gt;= 5.3.0, PHP 7</strong>)</li>
</ul>
<p>The Syntax</p>
<p></p>
<pre><code class="language-php">string openssl_encrypt ( string <span class="hljs-variable">$data</span> , string <span class="hljs-variable">$method</span> , string <span class="hljs-variable">$key</span> [, int <span class="hljs-variable">$options</span> = <span class="hljs-number">0</span> [, string <span class="hljs-variable">$iv</span> = <span class="hljs-string">""</span> [, string <span class="hljs-variable">$tag</span> = <span class="hljs-keyword">NULL</span> [, string <span class="hljs-variable">$aad</span> = <span class="hljs-string">""</span> [, int <span class="hljs-variable">$tag_length</span> = <span class="hljs-number">16</span> ]]]]] )
</code></pre>
<pre><code class="language-php">string openssl_decrypt ( string <span class="hljs-variable">$data</span> , string <span class="hljs-variable">$method</span> , string <span class="hljs-variable">$key</span> [, int <span class="hljs-variable">$options</span> = <span class="hljs-number">0</span> [, string <span class="hljs-variable">$iv</span> = <span class="hljs-string">""</span> [, string <span class="hljs-variable">$tag</span> = <span class="hljs-string">""</span> [, string <span class="hljs-variable">$aad</span> = <span class="hljs-string">""</span> ]]]] )
</code></pre>
<ul>
<li><strong>data</strong>:  The plaintext message data to be encrypted.</li>
<li><strong>method</strong>: The cipher method, see  <a href="php-ciphermethods.jsp">openssl_get_cipher_methods()</a>  for a list of potential values.</li>
<li><strong>key</strong> : User supplied key</li>
<li><strong>IV</strong>: The Initialization Vector</li>
<li><strong>AAD</strong>: For Authenticated encryption</li>
<li><strong>Returns</strong>: Returns the encrypted string on success or <strong><code>FALSE</code></strong> on failure.</li>
</ul>
<p>Since <a href="https://en.wikipedia.org/wiki/Block_cipher_modes_of_operation">block cipher modes of operation</a> require an IV which is random and unpredictable, or at least unique for each message encrypted with a given key. Different  block cipher modes have different IV length requirement for example</p>
<table class="table table-striped table-bordered">
<thead>
<tr>
<th>Cipher Mode</th>
<th>IV Length</th>
</tr>
</thead>
<tbody>
<tr>
<td>aes-128-cbc</td>
<td>16</td>
</tr>
<tr>
<td>camellia-192-ofb</td>
<td>16</td>
</tr>
<tr>
<td>cast5-cbc</td>
<td>8</td>
</tr>
<tr>
<td>bf-cbc</td>
<td>8</td>
</tr>
<tr>
<td>aes-256-gcm</td>
<td>12</td>
</tr>
</tbody>
</table>
<p><strong>Examples</strong></p>


<p> <mark>A Great Feedback by <a href="https://www.facebook.com/spaze">Michal Špaček</a></mark> </p>
<img class="img-fluid rounded" src="img/php/php-encrypt1.png" height="300" width="400" alt="https://www.facebook.com/spaze ">
<hr>

<h3><a id="aes128cbc__encryptdecrypt_example_38"></a>aes-128-cbc  encrypt/decrypt example</h3>
<p><strong>Note:</strong> AES-CBC mode  vulnerable to padding oracle attacks, Kindly Don't use these</p>
<pre><code class="language-php"><span class="hljs-comment">/**  
* Created by https://8gwifi.org  
* User: Anish Nath  
* Date: 2018-12-10  
* Time: 15:13  
*/</span>  
  
<span class="hljs-preprocessor">&lt;?php</span>  
  
<span class="hljs-comment">// php AES-128-CBC Encryption Example  </span>
<span class="hljs-variable">$plaintext</span> = <span class="hljs-string">"Hello 8gwifi.org"</span>;  
<span class="hljs-variable">$key</span> = <span class="hljs-string">"myverystrongpasswordo32bitleng"</span>;  
  
<span class="hljs-variable">$ivlen</span> = openssl_cipher_iv_length(<span class="hljs-variable">$cipher</span>=<span class="hljs-string">"aes-128-cbc"</span>);  
  
<span class="hljs-comment">//Generate Random IV  </span>
<span class="hljs-variable">$iv</span> = openssl_random_pseudo_bytes(<span class="hljs-variable">$ivlen</span>);  
<span class="hljs-variable">$ciphertext_raw</span> = openssl_encrypt(<span class="hljs-variable">$plaintext</span>, <span class="hljs-variable">$cipher</span>, <span class="hljs-variable">$key</span>, <span class="hljs-variable">$options</span>=OPENSSL_RAW_DATA, <span class="hljs-variable">$iv</span>);  
<span class="hljs-variable">$ciphertext</span> = base64_encode( <span class="hljs-variable">$iv</span>.<span class="hljs-variable">$ciphertext_raw</span> );  
  
<span class="hljs-keyword">echo</span> <span class="hljs-string">"Encrypted Text : $ciphertext \n"</span>;  
  
<span class="hljs-comment">//php AES-128-CBC Dec Example  </span>
<span class="hljs-variable">$c</span> = base64_decode(<span class="hljs-string">"$ciphertext"</span>);  
<span class="hljs-variable">$ivlen</span> = openssl_cipher_iv_length(<span class="hljs-variable">$cipher</span>=<span class="hljs-string">"aes-128-cbc"</span>);  
<span class="hljs-variable">$iv</span> = substr(<span class="hljs-variable">$c</span>, <span class="hljs-number">0</span>, <span class="hljs-variable">$ivlen</span>);  
<span class="hljs-variable">$ciphertext_raw</span> = substr(<span class="hljs-variable">$c</span>, <span class="hljs-variable">$ivlen</span>);  
  
<span class="hljs-variable">$original_plaintext</span> = openssl_decrypt(<span class="hljs-variable">$ciphertext_raw</span>, <span class="hljs-variable">$cipher</span>, <span class="hljs-variable">$key</span>, <span class="hljs-variable">$options</span>=OPENSSL_RAW_DATA, <span class="hljs-variable">$iv</span>);  
<span class="hljs-keyword">echo</span> <span class="hljs-string">"Decrypted Text: $original_plaintext\n"</span>;  
  
<span class="hljs-preprocessor">?&gt;</span>
</code></pre>
<p>The above example will output something similar to:</p>
<p></p>
<pre><code class="language-console">$ /usr/bin/php aes-128-cbc.php
/**
* Created by https://8gwifi.org
* User: Anish Nath
* Date: 2018-12-10
* Time: 15:13
*/
Encrypted Text : CLBckQqECD15NoXSD3JZGknFlQtpGrYR7BFlUshUZ9t7pMdAz6FAR+dkym46+stX 
Decrypted Text: Hello 8gwifi.org

Process finished with exit code 0
</code></pre>
<h3><a id="aes192cfb__encryptdecrypt_example_93"></a>aes-192-cfb  encrypt/decrypt example</h3>
<p></p>
<pre><code class="language-php"><span class="hljs-comment">/**  
* Created by https://8gwifi.org  
* User: Anish Nath  
* Date: 2018-12-10  
* Time: 15:13  
*/</span>  
  
  
<span class="hljs-preprocessor">&lt;?php</span>  
  
<span class="hljs-comment">// php AES-192-CBC Encryption Example  </span>
<span class="hljs-variable">$plaintext</span> = <span class="hljs-string">"Hello 8gwifi.org"</span>;  
<span class="hljs-variable">$key</span> = <span class="hljs-string">"myverystrongpasswordo32bitlength"</span>;  

<span class="hljs-variable">$ivlen</span> = openssl_cipher_iv_length(<span class="hljs-variable">$cipher</span>=<span class="hljs-string">"aes-192-cfb"</span>);    
<span class="hljs-comment">//Generate Random IV  </span>
<span class="hljs-variable">$iv</span> = openssl_random_pseudo_bytes(<span class="hljs-variable">$ivlen</span>);  
<span class="hljs-variable">$ciphertext_raw</span> = openssl_encrypt(<span class="hljs-variable">$plaintext</span>, <span class="hljs-variable">$cipher</span>, <span class="hljs-variable">$key</span>, <span class="hljs-variable">$options</span>=OPENSSL_RAW_DATA, <span class="hljs-variable">$iv</span>);  
  
<span class="hljs-variable">$ciphertext</span> = base64_encode( <span class="hljs-variable">$iv</span>.<span class="hljs-variable">$ciphertext_raw</span> );  
<span class="hljs-keyword">echo</span> <span class="hljs-string">"Encrypted Text : $ciphertext \n"</span>;  
  
<span class="hljs-comment">//php AES-192-CBC Dec Example  </span>
<span class="hljs-variable">$c</span> = base64_decode(<span class="hljs-variable">$ciphertext</span>);  
<span class="hljs-variable">$ivlen</span> = openssl_cipher_iv_length(<span class="hljs-variable">$cipher</span>=<span class="hljs-string">"aes-192-cfb"</span>);  
<span class="hljs-variable">$iv</span> = substr(<span class="hljs-variable">$c</span>, <span class="hljs-number">0</span>, <span class="hljs-variable">$ivlen</span>);  
<span class="hljs-variable">$ciphertext_raw</span> = substr(<span class="hljs-variable">$c</span>, <span class="hljs-variable">$ivlen</span>);  
<span class="hljs-variable">$original_plaintext</span> = openssl_decrypt(<span class="hljs-variable">$ciphertext_raw</span>, <span class="hljs-variable">$cipher</span>, <span class="hljs-variable">$key</span>, <span class="hljs-variable">$options</span>=OPENSSL_RAW_DATA, <span class="hljs-variable">$iv</span>);  
  
<span class="hljs-keyword">echo</span> <span class="hljs-string">"Decrypted Text: $original_plaintext\n"</span>;  
  
<span class="hljs-preprocessor">?&gt;</span>
</code></pre>
<p>The above example will output something similar to:</p>
<p></p>
<pre><code class="language-console">$ php aes-192-cfb.php
Encrypted Text : /72Gdi7jAqKVJ7APgtWXPKB+9s3+iS7/vwgOaO5/LEc= 
Decrypted Text: Hello 8gwifi.org
</code></pre>
<h3><a id="aes256ofb__encryptdecrypt_example_140"></a>aes-256-ofb  encrypt/decrypt example</h3>
<p></p>
<pre><code class="language-php">
<span class="hljs-preprocessor">&lt;?php</span>    
<span class="hljs-comment">// php AES-256-OFB Dec Example </span>
<span class="hljs-variable">$plaintext</span> = <span class="hljs-string">"Hello 8gwifi.org"</span>;  
<span class="hljs-variable">$key</span> = <span class="hljs-string">"myverystrongpasswordo32bitlength"</span>;  
  
<span class="hljs-variable">$ivlen</span> = openssl_cipher_iv_length(<span class="hljs-variable">$cipher</span>=<span class="hljs-string">"aes-256-ofb"</span>);  
<span class="hljs-comment">//Generate Random IV  </span>
<span class="hljs-variable">$iv</span> = openssl_random_pseudo_bytes(<span class="hljs-variable">$ivlen</span>);  
<span class="hljs-variable">$ciphertext_raw</span> = openssl_encrypt(<span class="hljs-variable">$plaintext</span>, <span class="hljs-variable">$cipher</span>, <span class="hljs-variable">$key</span>, <span class="hljs-variable">$options</span>=OPENSSL_RAW_DATA, <span class="hljs-variable">$iv</span>);  
  
<span class="hljs-variable">$ciphertext</span> = base64_encode( <span class="hljs-variable">$iv</span>.<span class="hljs-variable">$ciphertext_raw</span> );  
  
<span class="hljs-keyword">echo</span> <span class="hljs-string">"Encrypted Text : $ciphertext \n"</span>;  
  
<span class="hljs-comment">//php AES-256-OFB Dec Example  </span>
<span class="hljs-variable">$c</span> = base64_decode(<span class="hljs-variable">$ciphertext</span>);  
<span class="hljs-variable">$ivlen</span> = openssl_cipher_iv_length(<span class="hljs-variable">$cipher</span>=<span class="hljs-string">"aes-256-ofb"</span>);  
<span class="hljs-variable">$iv</span> = substr(<span class="hljs-variable">$c</span>, <span class="hljs-number">0</span>, <span class="hljs-variable">$ivlen</span>);  
<span class="hljs-variable">$ciphertext_raw</span> = substr(<span class="hljs-variable">$c</span>, <span class="hljs-variable">$ivlen</span>);  
<span class="hljs-variable">$original_plaintext</span> = openssl_decrypt(<span class="hljs-variable">$ciphertext_raw</span>, <span class="hljs-variable">$cipher</span>, <span class="hljs-variable">$key</span>, <span class="hljs-variable">$options</span>=OPENSSL_RAW_DATA, <span class="hljs-variable">$iv</span>);  
  
<span class="hljs-keyword">echo</span> <span class="hljs-string">"Decrypted Text: $original_plaintext\n"</span>;  
  
<span class="hljs-preprocessor">?&gt;</span>
</code></pre>
<p>The above example will output something similar to:</p>
<p></p>
<pre><code class="language-console">$/usr/bin/php aes-256-ofb.php
Encrypted Text : FtsxVyVc5zi/x/1oEpEoaVzNJKw6bYkgDH2kST2PLug= 
Decrypted Text: Hello 8gwifi.org
</code></pre>
<h3><a id="aes256gcm__encryptdecrypt_example_180"></a>aes-256-gcm  encrypt/decrypt example</h3>
<p><strong>Note</strong>: AEAD is not supported for all version prior to the PHP 7.1, This example utilizes php 7.1</p>
<p></p>
<pre><code class="language-php"><span class="hljs-comment">/**  
* Created by https://8gwifi.org  
* User: Anish Nath  
* Date: 2018-12-10  
* Time: 15:13  
*/</span>  
  
<span class="hljs-preprocessor">&lt;?php</span>  
  
<span class="hljs-comment">// php aes-256-gcm Encryption Example  </span>
<span class="hljs-variable">$plaintext</span> = <span class="hljs-string">"Hello 8gwifi.org"</span>;  
<span class="hljs-variable">$key</span> = <span class="hljs-string">"myverystrongpasswordo32bitlength"</span>;  
<span class="hljs-variable">$aad</span> = <span class="hljs-string">"not secret"</span>;  
  
<span class="hljs-variable">$ivlen</span> = openssl_cipher_iv_length(<span class="hljs-variable">$cipher</span>=<span class="hljs-string">"aes-256-gcm"</span>);  
  
<span class="hljs-comment">//Generate Random IV  </span>
<span class="hljs-variable">$iv</span> = openssl_random_pseudo_bytes(<span class="hljs-variable">$ivlen</span>);  
  
<span class="hljs-variable">$ciphertext_raw</span> = openssl_encrypt(<span class="hljs-variable">$plaintext</span>, <span class="hljs-variable">$cipher</span>, <span class="hljs-variable">$key</span>, <span class="hljs-variable">$options</span>=OPENSSL_RAW_DATA, <span class="hljs-variable">$iv</span>,<span class="hljs-variable">$aad</span>);  
  
  
<span class="hljs-variable">$ciphertext</span> = base64_encode( <span class="hljs-variable">$iv</span>.<span class="hljs-variable">$ciphertext_raw</span> );  
  
<span class="hljs-keyword">echo</span> <span class="hljs-string">"Encrypted Text : $ciphertext \n"</span>;  
  
<span class="hljs-comment">//php aes-256-gcm Dec Example  </span>
<span class="hljs-variable">$c</span> = base64_decode(<span class="hljs-variable">$ciphertext</span>);  
<span class="hljs-variable">$ivlen</span> = openssl_cipher_iv_length(<span class="hljs-variable">$cipher</span>=<span class="hljs-string">"aes-256-gcm"</span>);  
<span class="hljs-variable">$iv</span> = substr(<span class="hljs-variable">$c</span>, <span class="hljs-number">0</span>, <span class="hljs-variable">$ivlen</span>);  
<span class="hljs-variable">$ciphertext_raw</span> = substr(<span class="hljs-variable">$c</span>, <span class="hljs-variable">$ivlen</span>);  
<span class="hljs-variable">$original_plaintext</span> = openssl_decrypt(<span class="hljs-variable">$ciphertext_raw</span>, <span class="hljs-variable">$cipher</span>, <span class="hljs-variable">$key</span>, <span class="hljs-variable">$options</span>=OPENSSL_RAW_DATA, <span class="hljs-variable">$iv</span>,<span class="hljs-variable">$aad</span>);  
<span class="hljs-keyword">echo</span> <span class="hljs-string">"Decrypted Text: $original_plaintext\n"</span>;  
<span class="hljs-preprocessor">?&gt;</span>
</code></pre>
<p>The above example will output something similar to:</p>
<p></p>
<pre><code class="language-console">$ /bin/php-7.1.19 aes-256-gcm.php 
/**
* Created by https://8gwifi.org
* User: Anish Nath
* Date: 2018-12-10
* Time: 15:13
*/
Encrypted Text : p3pzMb42n03a9GZTwLHHVf2EPT8OcKrbAg/CVQ== 
Decrypted Text: Hello 8gwifi.org
</code></pre>
<h3><a id="camellia256ofb__encryptdecrypt_example_238"></a>camellia-256-ofb  encrypt/decrypt example</h3>
<p></p>
<pre><code class="language-php"><span class="hljs-comment">/**  
* Created by https://8gwifi.org  
* User: Anish Nath  
* Date: 2018-12-10  
* Time: 15:13  
*/</span>  
  
  
<span class="hljs-preprocessor">&lt;?php</span>  
  
<span class="hljs-comment">// php camellia-256-ofb Encryption Example  </span>
<span class="hljs-variable">$plaintext</span> = <span class="hljs-string">"Hello 8gwifi.org"</span>;  
<span class="hljs-variable">$key</span> = <span class="hljs-string">"myverystrongpasswordo32bitlength"</span>;  
<span class="hljs-variable">$ivlen</span> = openssl_cipher_iv_length(<span class="hljs-variable">$cipher</span>=<span class="hljs-string">"camellia-256-ofb"</span>);  
  
<span class="hljs-comment">//Generate Random IV  </span>
<span class="hljs-variable">$iv</span> = openssl_random_pseudo_bytes(<span class="hljs-variable">$ivlen</span>);  
  
<span class="hljs-variable">$ciphertext_raw</span> = openssl_encrypt(<span class="hljs-variable">$plaintext</span>, <span class="hljs-variable">$cipher</span>, <span class="hljs-variable">$key</span>, <span class="hljs-variable">$options</span>=OPENSSL_RAW_DATA, <span class="hljs-variable">$iv</span>);  
  
<span class="hljs-variable">$ciphertext</span> = base64_encode( <span class="hljs-variable">$iv</span>.<span class="hljs-variable">$ciphertext_raw</span> );  
  
<span class="hljs-keyword">echo</span> <span class="hljs-string">"Encrypted Text : $ciphertext \n"</span>;  
  
<span class="hljs-comment">//php camellia-256-ofb Dec Example  </span>
<span class="hljs-variable">$c</span> = base64_decode(<span class="hljs-variable">$ciphertext</span>);  
<span class="hljs-variable">$ivlen</span> = openssl_cipher_iv_length(<span class="hljs-variable">$cipher</span>=<span class="hljs-string">"camellia-256-ofb"</span>);  
<span class="hljs-variable">$iv</span> = substr(<span class="hljs-variable">$c</span>, <span class="hljs-number">0</span>, <span class="hljs-variable">$ivlen</span>);  
<span class="hljs-variable">$ciphertext_raw</span> = substr(<span class="hljs-variable">$c</span>, <span class="hljs-variable">$ivlen</span>);  
<span class="hljs-variable">$original_plaintext</span> = openssl_decrypt(<span class="hljs-variable">$ciphertext_raw</span>, <span class="hljs-variable">$cipher</span>, <span class="hljs-variable">$key</span>, <span class="hljs-variable">$options</span>=OPENSSL_RAW_DATA, <span class="hljs-variable">$iv</span>);  
  
<span class="hljs-keyword">echo</span> <span class="hljs-string">"Decrypted Text: $original_plaintext\n"</span>;  
  
<span class="hljs-preprocessor">?&gt;</span>
</code></pre>
<p>The above example will output something similar to:</p>
<p></p>
<pre><code class="language-console">/usr/bin/php camellia-256-ofb.php
Encrypted Text : AgSQP79ml7W/sTBWdtmzkQRgMc8R2L2Nm3LnrOC2+xc= 
Decrypted Text: Hello 8gwifi.org
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