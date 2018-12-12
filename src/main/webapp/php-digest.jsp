<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="php openssl tutorial on openssl_digest, php openssl_digest example, php openssl functions, php hashing example">
    <meta name="keywords" content="openssl list-cipher-commands openssl_digest, php openssl_digest example, php cryptography topics, php security, php interview questions, php openssl functions, php book, php hashing example">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>php openssl tutorial on openssl_digest</title>

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
    "@id": "https://8gwifi.org/docs/php-digest.jsp"
  },
  "name" : "go lang encoding decoding",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "php openssl tutorial on openssl_digest",
  "image":"https://8gwifi.org/docs/img/php/php-digest.png",
  "datePublished" : "2018-12-12",
  "dateModified": "2018-12-12",
  "articleSection" : "php openssl tutorial on openssl_digest",
  "articleBody" : [ "php openssl example ", "php openssl_digest" , "php openssl functions", "php cryptography", "php hashing example"],
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
          <h1 class="mt-4">php openssl_digest example</h1>

          <!-- Author -->
          <p class="lead">
            by
            <a href="https://www.linkedin.com/in/anishnath">Anish</a>
            <p>Posted on Wednesday December 12 , 2018</p>
          </p>
          
          
          
          <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>
           
          
          <hr>
<h2><a id="openssl_digest_0"></a>openssl_digest</h2>
<p><strong>openssl_digest</strong>: Computes a digest.</p>
<ul>
<li>Supported PHP Versions (<strong>PHP 5 &gt;= 5.3.0, PHP 7</strong>)</li>
</ul>
<p>The Syntax</p>
<p></p>
<pre><code class="language-php">string openssl_digest ( string <span class="hljs-variable">$data</span> , string <span class="hljs-variable">$method</span> [, bool <span class="hljs-variable">$raw_output</span> = <span class="hljs-keyword">FALSE</span> ] )
</code></pre>
<ul>
<li><strong>data</strong>: The data</li>
<li><strong>Method</strong> The digest method to use, e.g. "sha256", see <a href="php-digestmethod.jsp">openssl_get_md_methods()</a> for a list of available digest methods</li>
<li><strong>Returns</strong>: The digest Value</li>
</ul>
<p><strong>Examples</strong></p>
<p><strong>openssl_digest()</strong>  example  Shows how to digest a given value</p>
<p></p>
<pre><code class="language-php"><span class="hljs-preprocessor">&lt;?php</span>  
<span class="hljs-comment">/**  
 * Created by https://8gwifi.org  
 * User: Anish Nath  
 * Date: 2018-12-12 * Time: 11:46 
 * */</span>  
<span class="hljs-variable">$plaintext</span> = <span class="hljs-string">"Hello 8gwifi.org"</span>;  
<span class="hljs-variable">$digest</span> = openssl_digest(<span class="hljs-variable">$plaintext</span>, <span class="hljs-string">'sha512'</span>);  
<span class="hljs-keyword">echo</span> <span class="hljs-string">"SHA-512 Digest: $digest\n"</span> ;  
  
<span class="hljs-variable">$digest</span> = openssl_digest(<span class="hljs-variable">$plaintext</span>, <span class="hljs-string">'sha'</span>);  
<span class="hljs-keyword">echo</span> <span class="hljs-string">"SHA Digest: $digest\n"</span> ;  
  
<span class="hljs-variable">$digest</span> = openssl_digest(<span class="hljs-variable">$plaintext</span>, <span class="hljs-string">'sha1'</span>);  
<span class="hljs-keyword">echo</span> <span class="hljs-string">"SHA1 Digest: $digest\n"</span> ;  
  
<span class="hljs-variable">$digest</span> = openssl_digest(<span class="hljs-variable">$plaintext</span>, <span class="hljs-string">'SHA224'</span>);  
<span class="hljs-keyword">echo</span> <span class="hljs-string">"SHA-224 Digest: $digest\n"</span> ;  
  
<span class="hljs-variable">$digest</span> = openssl_digest(<span class="hljs-variable">$plaintext</span>, <span class="hljs-string">'ripemd160'</span>);  
<span class="hljs-keyword">echo</span> <span class="hljs-string">"ripemd160 Digest: $digest\n"</span> ;  
  
<span class="hljs-variable">$digest</span> = openssl_digest(<span class="hljs-variable">$plaintext</span>, <span class="hljs-string">'MD5'</span>);  
<span class="hljs-keyword">echo</span> <span class="hljs-string">"MD5 Digest: $digest\n"</span> ;
</code></pre>
<p>The above example will output something similar to:</p>
<p></p>
<pre><code class="language-console">$ /usr/bin/php digest.php
SHA-512 Digest: 4f3fe637ab817caaeeccec2662afa312d2a23bf7c1218e8b54dcac005ff156242e33240bf2a66f5de6eee0f3b58b188abb8aca636eccb67a28dcd82a71ed6c2a
SHA Digest: 21cf6e105172354b7285787b84c3787e43c56ffe
SHA1 Digest: 5523bdf845330363e738519c87f5f0dafe72c051
SHA-224 Digest: 357b2b4194d0edc884337b77d43f92f85378f60c354cb5c745c63a4b
ripemd160 Digest: 839c924c99a21aec2bf6b7d04fe663509a406ff7
MD5 Digest: 5d567716bc513834a40ecf179fcab1ba
</code></pre>
<p>In <code>openssl</code> You can digest the given value using using <code>openssl dgst</code> option</p>
<p></p>
<pre><code class="language-console">$ echo -n  'Hello 8gwifi.org' | openssl dgst -sha512 -hex
4f3fe637ab817caaeeccec2662afa312d2a23bf7c1218e8b54dcac005ff156242e33240bf2a66f5de6eee0f3b58b188abb8aca636eccb67a28dcd82a71ed6c2a

$ echo -n  'Hello 8gwifi.org' | openssl dgst -sha1 -hex
5523bdf845330363e738519c87f5f0dafe72c051

$ echo -n  'Hello 8gwifi.org' | openssl dgst -ripemd160 -hex
839c924c99a21aec2bf6b7d04fe663509a406ff7
</code></pre>


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