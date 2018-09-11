<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="How to generate random value using Window.crypto  getRandomValues() , Window.crypto tutorials, Web Cryptography API Tutorials">
    <meta name="keywords" content="How to generate random value using Window.crypto  getRandomValues() , Window.crypto tutorials, window.crypto example, windo.crypto javascript examples, Web Cryptography API">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>How to generate random value using Window.crypto  getRandomValues() , Window.crypto tutorials</title>

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
    "@id": "https://8gwifi.org/docs/window-crypto-random.jsp"
  },
  "name" : "How to generate random value using Window.crypto getRandomValues()",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "How to generate random value using Window.crypto getRandomValues() ",
  "image":"https://8gwifi.org/docs/img/getrandom00.png",
  "datePublished" : "2018-09-11",
  "dateModified": "2018-08-11",
  "articleSection" : "How to generate random value using Window.crypto getRandomValues()",
  "articleBody" : [ "The Window.crypto ", "The Javascript Code" , "The Html", "The Result" , "Broswer Support"],
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
          <h1 class="mt-4">How to generate random value using Window.crypto  getRandomValues()</h1>

          <!-- Author -->
          <p class="lead">
            by
            <a href="https://www.linkedin.com/in/anishnath">Anish</a>
            <p>Posted on Sunday september 11, 2018</p>
          </p>
          
          <img class="img-fluid rounded" src="img/getrandom00.png" height="400" width="600" alt="Referefce ">
          
          <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>
           
          <hr>
<p>The <a href="https://developer.mozilla.org/en-US/docs/Web/API/Window/crypto" title="The Window.crypto read-only property returns the Crypto object associated to the global object. This object allows web pages access to certain cryptographic related services."><code>Window.crypto</code></a> read-only property returns the <a href="https://developer.mozilla.org/en-US/docs/Web/API/Crypto" title="The Crypto interface represents basic cryptography features available in the current context. It allows access to a cryptographically strong random number generator and to cryptographic primitives."><code>Crypto</code></a> object associated to the global object. This object allows web pages access to certain cryptographic related services.</p>
<p>Using the  <a href="https://developer.mozilla.org/en-US/docs/Web/API/Window/crypto" title="The Window.crypto read-only property returns the Crypto object associated to the global object. This object allows web pages access to certain cryptographic related services."><code>Window.crypto</code></a>  property to access the  <a href="https://developer.mozilla.org/en-US/docs/Web/API/RandomSource/getRandomValues">getRandomValues()</a> method.</p>
<h2 class="mt-4">The Javascript Code </h2>
<pre><code class="html">&lt;script&gt;
genRandomNumbers = function getRandomNumbers() {
  if (window.crypto || window.msCrypto) 
  {
  var array = new Uint32Array(10);
  window.crypto.getRandomValues(array);
 
  var randText = document.getElementById(&quot;myRandText&quot;);
  randText.innerHTML = &quot;The random numbers are: &quot;
  for (var i = 0; i &lt; array.length; i++) {
    randText.innerHTML += array[i] + &quot; \n&quot;;
  }
} 
    else throw new Error(&quot;Your browser can't generate secure random numbers&quot;);
}
&lt;/script&gt;
</code></pre>
<h2 class="mt-4">The Html</h2>
<pre><code class="html">&lt;p id=&quot;myRandText&quot;&gt;The random numbers are: &lt;/p&gt;
&lt;button type=&quot;button&quot; onClick='genRandomNumbers()'&gt;Generate 10 random numbers&lt;/button&gt;
</code></pre>
<h2 class="mt-4">The Result</h2>
<img class="img-fluid rounded"  src="img/getrandom00.png" alt="enter image description here"></img>
<h2 class="mt-4">Broswer Support</h2>
<p><img class="img-fluid rounded"  src="img/getrandom01.png" alt="enter image description here"></p>

<hr>
Download the sample code <a href="https://drive.google.com/file/d/1S71nrE44QaUfiPRrVKKutSBBMjC8T-EK/view?usp=sharing">here </a>

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