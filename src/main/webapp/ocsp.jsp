<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="pki concepts,  ocsp example openssl ">
    <meta name="keywords" content="pki tutorial,pki concepts, ocsp concept, ocsp request data, ocsp response data , ocsp openssl example, ocsp Determine the ocsp URI, ocsp certificate verification process">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>Understanding ocsp</title>

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
    "@id": "https://8gwifi.org/docs/ocsp.jsp"
  },
  "name" : "OCSP Introduction",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "Online Certificate Status Protocol (OCSP) ",
  "image":"https://8gwifi.org/docs/img/ocsp.png",
  "datePublished" : "2018-08-12",
  "dateModified": "2018-08-12",
  "articleSection" : "Online Certificate Status Protocol (OCSP)",
  "articleBody" : [ "PUBLIC KEY INFRASTRUCTURES", "OCSP stands for the Online Certificate Status Protocol" , "The OCSP Response", "Determine the ocsp URI" , "Build the certificate chain" , ]
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
          <h1 class="mt-4">Online Certificate Status Protocol (OCSP)</h1>

          <!-- Author -->
          <p class="lead">
            by
            <a href="https://www.linkedin.com/in/anishnath">Anish</a>
            <p>Posted on Sunday August 12, 2018</p>
          </p>
          
          <img class="img-fluid rounded" src="img/ocsp.png" height="400" width="600" alt="Referefce ">
          
          <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>
           
          <hr>

<h2 class="mt-4">Introduction </h3>

<p><mark>This sample chapter </mark> extracted from the book, <a href="https://leanpub.com/crypto">The Modern Cryptograhy CookBook </a>. The Book theme is<mark>Cryptography is for EveryOne. Learn from Crypto Principle to Applied Cryptography With Practical Example</mark> </p>
<p><mark>Get 20% discount Coupon on this book </mark> By Commenting and Sharing this Article </p>
<p><iframe class="embed-responsive-item" width='160' height='400' src='https://leanpub.com/crypto/embed' frameborder='0' allowtransparency='true'></iframe></p>

<hr>
<p> In the previous article we have cover the <a href="pki.jsp">PKI in Nutshell</a> </p>
<p><b>OCSP</b> stands for the Online Certificate Status Protocol and is one way to validate a certificate status. It is an alternative to the CRL, certificate revocation list.</p>
<p>The OCSP precess is very simple:</p>
<ol>
<li>Client receives the certificate</li>
<li>Client sends OCSP request to the OCSP server and it query by the serial number of the certificate</li>
<li>OCSP response with a certificate status Good, Revoked or Unknown</li>
</ol>
<p>Working Demo</p>
<ul>
<li>
<p>Get the certificate you want to verify for example <a href="https://8gwifi.org">8gwifi.org</a></p>
<pre><code class="html">  openssl s_client -servername 8gwifi.org -connect 8gwifi.org:443 2&gt;&amp;1 &lt; /dev/null | sed -n '/-----BEGIN/,/-----END/p' &gt; 8gwifi.pem
</code></pre>
</li>
<li>
<p>Build the certificate chain</p>
<pre><code class="html">  openssl s_client -servername 8gwifi.org  -connect 8gwifi.com:443 -showcerts 2&gt;&amp;1 &lt; /dev/null &gt; cacert.pem
</code></pre>
</li>
</ul>
<p>edit the file cacert.pem and add necessary chain certificate, remove any unwanted lines</p>
<ul>
<li>
<p>Determine the <strong>ocsp URI </strong></p>
<pre><code class="html">  openssl x509 -noout -ocsp_uri -in 8gwifi.pem
  http://ocsp.int-x3.letsencrypt.org
</code></pre>
</li>
<li>
<p>Invoke the <strong>openssl ocsp client</strong></p>
<pre><code class="html">  openssl ocsp -no_nonce -issuer cacert.pem -cert 8gwifi.pem  -VAfile cacert.pem -text -url http://ocsp.int-x3.letsencrypt.org/ -header Host ocsp.int-x3.letsencrypt.org -respout ocsptest
</code></pre>
</li>
</ul>
<p> <strong>The OCSP Response</strong></p>
<pre><code class="html"><mark>OCSP Request Data:</mark>
    Version: 1 (0x0)
  <mark>  Requestor List: </mark>
        Certificate ID:
          Hash Algorithm: sha1
          Issuer Name Hash: 7EE66AE7729AB3FCF8A220646C16A12D6071085D
          Issuer Key Hash: A84A6A63047DDDBAE6D139B7A64565EFF3A8ECA1
          Serial Number: 03FF3497BFA5D45C36C511809F9FD5F28C20
<mark>OCSP Response Data: </mark>
    OCSP Response Status: successful (0x0)
    Response Type: Basic OCSP Response
    Version: 1 (0x0)
    Responder Id: C = US, O = Let's Encrypt, CN = Let's Encrypt Authority X3
    Produced At: Aug  6 08:59:00 2018 GMT
    Responses:
    Certificate ID:
      Hash Algorithm: sha1
      Issuer Name Hash: 7EE66AE7729AB3FCF8A220646C16A12D6071085D
      Issuer Key Hash: A84A6A63047DDDBAE6D139B7A64565EFF3A8ECA1
      Serial Number: 03FF3497BFA5D45C36C511809F9FD5F28C20
     
   <mark> Cert Status: good</mark>
    This Update: Aug  6 08:00:00 2018 GMT
    Next Update: Aug 13 08:00:00 2018 GMT

    Signature Algorithm: sha256WithRSAEncryption
         39:3d:96:78:44:9f:03:29:bc:83:35:32:1a:d7:6d:05:f9:59:
         63:9e:52:6f:06:8e:9f:74:d1:f9:aa:18:2b:e2:13:61:5a:d1:
         ad:7a:67:9e:2b:a1:12:83:92:92:f3:c0:dc:4b:2a:ee:96:85:
         f0:5b:39:30:2f:17:ed:20:a3:ae:de:c1:41:e1:26:8d:70:c5:
         fe:79:9c:37:7b:b7:75:93:61:f7:5f:8b:7f:6f:99:7a:5a:19:
         a4:e7:4b:41:ad:e5:92:71:44:11:75:67:68:0d:0c:b6:be:ef:
         70:a0:a7:c6:fa:6e:06:08:5a:7c:2e:f0:41:7a:55:a3:21:74:
         89:2c:e5:f9:ab:58:5c:97:1d:89:a8:65:a3:be:f7:0a:e5:5c:
         4f:a9:61:f2:04:d5:f2:18:6b:74:e7:b5:c8:12:db:9c:70:89:
         e7:c6:e3:43:70:18:41:d6:4b:a9:15:94:13:4b:00:75:d2:2a:
         fe:fb:e4:a8:cf:e5:aa:56:d6:e1:91:55:06:d1:33:43:d9:4b:
         82:a6:bc:10:a1:42:d0:e2:49:fe:18:08:44:d4:a7:4f:b6:3f:
         00:95:72:11:d7:e3:14:eb:6b:51:7a:e7:c1:40:42:2e:da:c4:
         be:1a:ce:8c:48:f2:03:ed:c0:93:19:c9:26:93:1e:f0:d2:56:
         bc:70:39:db
 <mark>Response verify OK
8gwifi.pem: good
    This Update: Aug  6 08:00:00 2018 GMT </mark>
    Next Update: Aug 13 08:00:00 2018 GMT
</code></pre>


<%@ include file="footer_adsense.jsp"%> 
<p><strong> Thanku for reading !!! Give a Share for Support</strong></p>

<hr>


      <!-- Comments Form -->
    

          <!-- Single Comment -->
 

          <!-- Comment with nested comments -->
        
          

        </div>

		
        
        <!-- Sidebar Widgets Column -->
        <div class="col-md-4">

          <!-- Ad Widget -->
         <%@ include file="footer_adsense.jsp"%> 

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


	<%@ include file="addcomments.jsp"%>
    
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