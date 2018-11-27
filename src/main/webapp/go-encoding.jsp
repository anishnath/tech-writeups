<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="go lang encoding decoding example, go lang tutorial ">
    <meta name="keywords" content="go lang encoding decoding example ">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>go lang encoding decoding example</title>

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
  "name" : "go lang encoding decoding",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "how to perform hashing/digest using golang sha,sha-1,sha224,sha-512 ",
  "image":"https://8gwifi.org/docs/img/base64.png",
  "datePublished" : "2018-11-04",
  "dateModified": "2018-11-04",
  "articleSection" : "go lang encoding decoding",
  "articleBody" : [ "go lang encoding decoding ", "URL Encoding/Decoding" , "Base64 Encoding/Decoding", "Go provides built-in support for base64 encoding/decoding." , "EncodeToString" , "DecodeString" , "URL-compatible base64", "StdEncoding method for base64 encode/decode" , "RFC 4648"],
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
          <h1 class="mt-4">Go lang base64 Encoding/Decoding Example</h1>

          <!-- Author -->
          <p class="lead">
            by
            <a href="https://www.linkedin.com/in/anishnath">Anish</a>
            <p>Posted on Sunday November 4 , 2018</p>
          </p>
          
          
          
          <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>
           
          <hr>
<h3><a id="URL_EncodingDecoding_2"></a>URL Encoding/Decoding</h3>
<p>URLs can only be sent over the Internet using the ASCII character set, Since URLs often contain characters outside the ASCII set, the URL has to be converted into a valid ASCII format.</p>
<ul>
<li>URL encoding replaces unsafe ASCII characters with a "%" followed by two hexadecimal digits.</li>
<li>URLs cannot contain spaces.</li>
<li>URL encoding normally replaces a space with a plus (+) sign or with %20</li>
<li>In go lang the function <code>URLEncoding</code> is the alternate <code>base64</code> encoding defined in RFC 4648. It is typically used in URLs and file names.</li>
</ul>
<p>Reference ASCII table</p>
<p><img src="img/ascii.png" alt=""></p>
<h3><a id="Base64_EncodingDecoding_15"></a>Base64 Encoding/Decoding</h3>
<p>Base64 is a group of similar binary-to-text encoding schemes that represent binary data in an ASCII string format by translating it into a radix-64 representation. The term Base64 originates from a specific MIME content transfer encoding. Each Base64 digit represents exactly 6 bits of data. Three 8-bit bytes (i.e., a total of 24 bits) can therefore be represented by four 6-bit Base64 digits.</p>
<p>The Base64 index table:</p>
<p><img src="img/base64.png" alt=""></p>
<p>Go provides built-in support for  <a href="http://en.wikipedia.org/wiki/Base64">base64 encoding/decoding</a>.</p>
<pre><code class="html"><span class="hljs-keyword">import</span> (   
 <span class="hljs-string">"encoding/base64"</span>)
</code></pre>
<p>Go supports both <code>standard</code> and <code>URL-compatible</code> base64</p>
<p><strong>For URL  compatible encoding use the below function,</strong></p>
<p>EncodeToString returns the <code>base64</code> encoding of src.</p>
<pre><code class="html"><span class="hljs-keyword">func</span> (enc *Encoding) EncodeToString(src []<span class="hljs-typename">byte</span>) <span class="hljs-typename">string</span>
</code></pre>
<p><strong>For URL compatible Decoding use the below function</strong></p>
<p>DecodeString returns the bytes represented by the base64 string s.</p>
<pre><code class="html"><span class="hljs-keyword">func</span> (enc *Encoding) DecodeString(s <span class="hljs-typename">string</span>) ([]<span class="hljs-typename">byte</span>, error)
</code></pre>
<p>The complete example using <code>URL-compatible</code> base64</p>
<pre><code class="html"><span class="hljs-keyword">package</span> main  
  
<span class="hljs-keyword">import</span> (  
   <span class="hljs-string">"fmt"</span>  
 <span class="hljs-string">"encoding/base64"</span>)  
  
<span class="hljs-keyword">func</span> main() {  
  
   msg := <span class="hljs-string">"https://8gwifi.org"</span>  
  <span class="hljs-comment">// Base64 Encoding  </span>
  encmess := base64.URLEncoding.EncodeToString([]<span class="hljs-typename">byte</span>(msg))  
  fmt.Println(<span class="hljs-string">"Base64 Encoded Message"</span>, encmess)  
  
   <span class="hljs-comment">// Base64 Decoding  </span>
   decode, err := base64.URLEncoding.DecodeString(encmess)  
   
   <span class="hljs-keyword">if</span> err != <span class="hljs-constant">nil</span> {  
      fmt.Println(<span class="hljs-string">"Falied to Perfrom URL Encoding"</span>, encmess)  
      <span class="hljs-keyword">return</span>  
  }   
   fmt.Println(<span class="hljs-string">"Base64 Decoded Message"</span>, <span class="hljs-typename">string</span>(decode))  
  
}
</code></pre>
<p>The output</p>
<pre><code class="language-console">Base64 Encoded Message aHR0cHM6Ly84Z3dpZmkub3Jn
Base64 Decoded Message https://8gwifi.org
</code></pre>
<p>By Using <strong>StdEncoding</strong> method for base64 encode/decode.</p>
<pre><code class="html"><span class="hljs-keyword">package</span> main  
  
<span class="hljs-keyword">import</span> (  
   <span class="hljs-string">"fmt"</span>  
 <span class="hljs-string">"encoding/base64"</span>)  
  
<span class="hljs-keyword">func</span> main() {  
  
   msg := <span class="hljs-string">"https://8gwifi.org"</span>  
  <span class="hljs-comment">// Base64 Encoding  </span>
  encmess := base64.StdEncoding.EncodeToString([]<span class="hljs-typename">byte</span>(msg))  
   fmt.Println(<span class="hljs-string">"Base64 Encoded Message"</span>, encmess)  
  
   <span class="hljs-comment">// Base64 Decoding  </span>
  decode, err := base64.StdEncoding.DecodeString(encmess)  
  
   <span class="hljs-keyword">if</span> err != <span class="hljs-constant">nil</span> {  
      fmt.Println(<span class="hljs-string">"Falied to Perfrom URL Encoding"</span>, encmess)  
      <span class="hljs-keyword">return</span>  
  }  
   fmt.Println(<span class="hljs-string">"Base64 Decoded Message"</span>, <span class="hljs-typename">string</span>(decode))  
     
  
}
</code></pre>
<p>The output</p>
<pre><code class="language-console">Base64 Encoded Message aHR0cHM6Ly84Z3dpZmkub3Jn
Base64 Decoded Message https://8gwifi.org
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