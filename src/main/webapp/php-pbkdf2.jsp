<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="php openssl tutorial on openssl_pbkdf2 php openssl_pbkdf2 example, php openssl functions, php pbkdf2 derive keys">
    <meta name="keywords" content="openssl_pbkdf2 php openssl_pbkdf2 example, php cryptography topics, php security, php interview questions, php openssl functions, php derive pbkdf2 keys , derive kdf keys php">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>php openssl tutorial on openssl_pbkdf2</title>

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
    "@id": "https://8gwifi.org/docs/php-pbkdf2.jsp"
  },
  "name" : "php get all ec curve names",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "php openssl tutorial on openssl_pbkdf2",
  "image":"https://8gwifi.org/docs/img/php/php-pbkdf2.png",
  "datePublished" : "2018-12-12",
  "dateModified": "2018-12-12",
  "articleSection" : "php openssl tutorial on openssl_pbkdf2",
  "articleBody" : [ "php openssl example ", "php openssl_pbkdf2" , "php openssl functions", "php cryptography", "openssl derive keys" , "derive pbkdf2 keys "],
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
          <h1 class="mt-4">php openssl_pbkdf2 example</h1>

          <!-- Author -->
          <p class="lead">
            by
            <a href="https://www.linkedin.com/in/anishnath">Anish</a>
            <p>Posted on Wednesday December 12 , 2018</p>
          </p>
          
          
          
          <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>
           
          
          <hr>

<p>In cryptography, <strong>PBKDF1</strong> and <strong>PBKDF2</strong> (<strong>Password-Based Key Derivation Function 2</strong>) are <a href="https://en.wikipedia.org/wiki/Key_derivation_function" title="Key derivation function">key derivation functions</a> with a sliding computational cost, aimed to reduce the vulnerability of encrypted keys to <a href="https://en.wikipedia.org/wiki/Brute_force_attack" title="Brute force attack">brute force attacks</a>.</p>
<p>The PBKDF2 key derivation function has five input parameters:</p>
<p></p>
<pre><code class="language-console">DK = PBKDF2(PRF, Password, Salt, c, dkLen)
</code></pre>
<p>where:</p>
<ul>
<li><em>PRF</em>  is a pseudorandom function of two parameters with output length  <em>hLen</em>  (e.g. a keyed HMAC)</li>
<li><em>Password</em>  is the master password from which a derived key is generated</li>
<li><em>Salt</em>  is a sequence of bits, known as a  <a href="https://en.wikipedia.org/wiki/Salt_(cryptography)">cryptographic salt</a></li>
<li><em>c</em>  is the number of iterations desired</li>
<li><em>dkLen</em>  is the desired bit-length of the derived key</li>
<li><em>DK</em>  is the generated derived key</li>
</ul>
<p>php openssl function <strong>openssl_pbkdf2</strong>: Generates a PKCS5 v2 PBKDF2 string, defaults to SHA-1</p>
<ul>
<li>Supported PHP Versions (<strong>PHP 5 &gt;= 5.5.0, PHP 7</strong>)</li>
</ul>
<p>The Syntax</p>
<p></p>
<pre><code class="language-php">string  openssl_pbkdf2 ( string  <span class="hljs-variable">$password</span> , string  <span class="hljs-variable">$salt</span> , int  <span class="hljs-variable">$key_length</span> , int  <span class="hljs-variable">$iterations</span> [, string  <span class="hljs-variable">$digest_algorithm</span> ] )
</code></pre>
<p><strong>Best Practice for PBKDF2 :</strong></p>
<ul>
<li>Use a unique 64-bit salt for each password.</li>
<li>Use SHA-512</li>
<li>Use iteration count of at least 10000, the more you can go do measure the server performance.</li>
</ul>
<p><strong>Examples</strong></p>
<p><strong>openssl_pbkdf2() example</strong> Deriving key for my given password</p>
<p></p>
<pre><code class="language-php"><span class="hljs-preprocessor">&lt;?php</span>  
<span class="hljs-comment">/**  
 * Created by https://8gwifi.org  
  * User: Anish Nath  
 * Date: 2018-12-17 * Time: 14:44 */</span>  
<span class="hljs-keyword">echo</span> <span class="hljs-string">"Deriving password for my Given Password\n"</span>;  
<span class="hljs-keyword">echo</span> <span class="hljs-string">"PBKDF2 Example of using SHA algorithms, with random salt value of 16 and the output keylength of 32\n"</span>;  
  
<span class="hljs-variable">$password</span>= <span class="hljs-string">"myverystrongpassword"</span>;  
<span class="hljs-variable">$salt</span>=openssl_cipher_iv_length(<span class="hljs-number">16</span>);  
<span class="hljs-variable">$key_length</span> =<span class="hljs-number">32</span>;  
<span class="hljs-variable">$iterations</span>=<span class="hljs-number">10000</span>;  
<span class="hljs-variable">$dk</span> = openssl_pbkdf2(<span class="hljs-variable">$password</span>,salt,<span class="hljs-variable">$key_length</span>,<span class="hljs-variable">$iterations</span>,<span class="hljs-string">"SHA"</span>);  
<span class="hljs-keyword">echo</span> base64_encode(<span class="hljs-variable">$dk</span>);
</code></pre>
<p>The above example will output something similar to:</p>
<p></p>
<pre><code class="language-console">$ /usr/bin/php pbkdf2.php
Deriving password for my Given Password

UhkRrY90Uu7JYNtBXZJszLr4vZ0NaAvBCRDhoNLPcZA=
</code></pre>

<p>Continue Reading <a href="php-asym.jsp#Generate_EC_Key_Pair_193">how to generate ec key pair</a></p>
<p><a href="https://8gwifi.org/pbkdf.jsp">Generate PBKDF2 Keys Online</a></p>

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