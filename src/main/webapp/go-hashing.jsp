<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="go lang   hashing,digest  example sha,sha512,sha224,md5, the crypto.subtle.digest ">
    <meta name="keywords" content="go lang hashing,digest example , windo.crypto javascript examples, golang, sha hashing using crypto">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>how to perform hashing/digest using golang sha,sha-1,sha224,sha-512 </title>

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
    "@id": "https://8gwifi.org/docs/go-hashing.jsp"
  },
  "name" : "how to perform hashing/digest using golang  sha,sha-1,sha224,sha-512 ",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "how to perform hashing/digest using golang sha,sha-1,sha224,sha-512 ",
  "image":"https://8gwifi.org/docs/img/hash.png",
  "datePublished" : "2018-10-31",
  "dateModified": "2018-10-31",
  "articleSection" : "how to perform hashing/digest using golang sha,sha-1,sha224,sha-512 ",
  "articleBody" : [ "Digest/Hashing using golang ", "sha1" , "sha224", "The SHA-1 Hashing Example for golang digest" , "golang digest" , "sha512" , "go lang example", "go lang RIPEMD160" , "BLAKE2b_512"],
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
          <h1 class="mt-4">Go Lang Hashing Example</h1>

          <!-- Author -->
          <p class="lead">
            by
            <a href="https://www.linkedin.com/in/anishnath">Anish</a>
            <p>Posted on Wednesday October 31 , 2018</p>
          </p>
          
          
          
          <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>
           
          <hr>
          
          <h2><a id="Hashing_0"></a>Hashing</h2>
<p>A  <strong><a href="https://simple.wikipedia.org/wiki/Cryptography" title="Cryptography">cryptographic</a>  hash function</strong>  is a  <a href="https://simple.wikipedia.org/wiki/Hash_function" title="Hash function">hash function</a>  which takes an input (or 'message') and returns a fixed-size alphanumeric string. The string is called the 'hash value', 'message digest', 'digital fingerprint', 'digest' or 'checksum'.</p>
<p><img src="img/hash.png" alt=""></p>
<p>The ideal hash function has three main properties:</p>
<ol>
<li>It is extremely easy to calculate a hash for any given data.</li>
<li>It is  <a href="https://simple.wikipedia.org/wiki/Computational_complexity_theory" title="Computational complexity theory">extremely computationally difficult</a>  to calculate an alphanumeric text that has a given hash.</li>
<li>It is extremely unlikely that two slightly different messages will have the same hash.</li>
</ol>
<p><code>Go</code> provides built-in support for hash algorithms, supported Hashing Algorithms and their Digest Sizes</p>
<table class="table table-striped table-bordered">
<thead>
<tr>
<th>Hash</th>
<th>Digest Size</th>
</tr>
</thead>
<tbody>
<tr>
<td>MD4</td>
<td>16</td>
</tr>
<tr>
<td>MD5</td>
<td>16</td>
</tr>
<tr>
<td>SHA1</td>
<td>20</td>
</tr>
<tr>
<td>SHA224</td>
<td>28</td>
</tr>
<tr>
<td>SHA256</td>
<td>32</td>
</tr>
<tr>
<td>SHA384</td>
<td>48</td>
</tr>
<tr>
<td>SHA512</td>
<td>64</td>
</tr>
<tr>
<td>RIPEMD160</td>
<td>20</td>
</tr>
<tr>
<td>SHA3_224</td>
<td>28</td>
</tr>
<tr>
<td>SHA3_256</td>
<td>32</td>
</tr>
<tr>
<td>SHA3_384</td>
<td>48</td>
</tr>
<tr>
<td>SHA3_512</td>
<td>64</td>
</tr>
<tr>
<td>SHA512_224</td>
<td>28</td>
</tr>
<tr>
<td>SHA512_256</td>
<td>32</td>
</tr>
<tr>
<td>BLAKE2s_256</td>
<td>32</td>
</tr>
<tr>
<td>BLAKE2b_256</td>
<td>32</td>
</tr>
<tr>
<td>BLAKE2b_384</td>
<td>48</td>
</tr>
<tr>
<td>BLAKE2b_512</td>
<td>64</td>
</tr>
</tbody>
</table>
<p><code>type Hash</code> : Hash identifies a cryptographic hash function that is implemented in another package</p>

<pre><code class="language-console">        MD4                         // import crypto/md4
        MD5                         // import crypto/md5
        SHA1                        // import crypto/sha1
        SHA224                      // import crypto/sha256
        SHA256                      // import crypto/sha256
        SHA384                      // import crypto/sha512
        SHA512                      // import crypto/sha512
        MD5SHA1                     // no implementation; MD5+SHA1 used for TLS RSA
        RIPEMD160                   // import golang.org/x/crypto/ripemd160
        SHA3_224                    // import golang.org/x/crypto/sha3
        SHA3_256                    // import golang.org/x/crypto/sha3
        SHA3_384                    // import golang.org/x/crypto/sha3
        SHA3_512                    // import golang.org/x/crypto/sha3
        SHA512_224                  // import crypto/sha512
        SHA512_256                  // import crypto/sha512
        BLAKE2s_256                 // import golang.org/x/crypto/blake2s
        BLAKE2b_256                 // import golang.org/x/crypto/blake2b
        BLAKE2b_384                 // import golang.org/x/crypto/blake2b
        BLAKE2b_512                 // import golang.org/x/crypto/blake2b
</code></pre>
<p><strong>SHA-1 Hashing Example</strong></p>

<pre><code class="language-go"><span class="hljs-keyword">package</span> main
<span class="hljs-keyword">import</span> <span class="hljs-string">"crypto/sha1"</span>
<span class="hljs-keyword">import</span> <span class="hljs-string">"fmt"</span>
<span class="hljs-keyword">func</span> main() {
    s := <span class="hljs-string">"Hello 8gwifi.org"</span>
    <span class="hljs-comment">// The pattern for generating a hash is `sha1.New()`,</span>
    <span class="hljs-comment">// `sha1.Write(bytes)`, then `sha1.Sum([]byte{})`.</span>
    <span class="hljs-comment">// Here we start with a new hash.</span>
    h := sha1.New()
    
    <span class="hljs-comment">// `Write` expects bytes. If you have a string `s`,</span>
    <span class="hljs-comment">// use `[]byte(s)` to coerce it to bytes.</span>
    h.Write([]<span class="hljs-typename">byte</span>(s))

    <span class="hljs-comment">// This gets the finalized hash result as a byte</span>
    <span class="hljs-comment">// slice. The argument to `Sum` can be used to append</span>
    <span class="hljs-comment">// to an existing byte slice: it usually isn't needed.</span>
    bs := h.Sum(<span class="hljs-constant">nil</span>)

    <span class="hljs-comment">// SHA1 values are often printed in hex, for example</span>
    <span class="hljs-comment">// in git commits. Use the `%x` format verb to convert</span>
    <span class="hljs-comment">// a hash results to a hex string.</span>
    fmt.Println(s)
    fmt.Printf(<span class="hljs-string">"%x\n"</span>, bs)
}
</code></pre>
<p>The output</p>

<pre><code class="language-console">Hello 8gwifi.org
5523bdf845330363e738519c87f5f0dafe72c051
</code></pre>
<p><strong>MD5 Hashing Example</strong></p>

<pre><code class="language-go"><span class="hljs-keyword">package</span> main
<span class="hljs-keyword">import</span> <span class="hljs-string">"crypto/md5"</span>
<span class="hljs-keyword">import</span> <span class="hljs-string">"fmt"</span>
<span class="hljs-keyword">func</span> main() {
    s := <span class="hljs-string">"Hello 8gwifi.org"</span>
    <span class="hljs-comment">// The pattern for generating a hash is `sha1.New()`,</span>
    <span class="hljs-comment">// `sha1.Write(bytes)`, then `sha1.Sum([]byte{})`.</span>
    <span class="hljs-comment">// Here we start with a new hash.</span>
    h := md5.New()
    
    <span class="hljs-comment">// `Write` expects bytes. If you have a string `s`,</span>
    <span class="hljs-comment">// use `[]byte(s)` to coerce it to bytes.</span>
    h.Write([]<span class="hljs-typename">byte</span>(s))

    <span class="hljs-comment">// This gets the finalized hash result as a byte</span>
    <span class="hljs-comment">// slice. The argument to `Sum` can be used to append</span>
    <span class="hljs-comment">// to an existing byte slice: it usually isn't needed.</span>
    bs := h.Sum(<span class="hljs-constant">nil</span>)

    <span class="hljs-comment">// MD5 values are often printed in hex, for example</span>
    <span class="hljs-comment">// in git commits. Use the `%x` format verb to convert</span>
    <span class="hljs-comment">// a hash results to a hex string.</span>
    fmt.Println(s)
    fmt.Printf(<span class="hljs-string">"%x\n"</span>, bs)
}
</code></pre>
<p>The output</p>

<pre><code class="language-console">Hello 8gwifi.org
5d567716bc513834a40ecf179fcab1ba
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
    
    Here

    <!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>


  </body>

</html>