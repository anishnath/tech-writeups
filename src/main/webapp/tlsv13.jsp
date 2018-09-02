<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="introduction to tlsv1.3, openssl tlsv1.3, tlsv1.3 ciphers, openssl tlsv1.3 server support, ciphersuites for tlsv1.3, tlsv1.3 wireshark, diffrence in tls1.2 and 1.3">
    <meta name="keywords" content="tlsv1.3 tutorial,introduction to tlsv1.3, openssl tlsv1.3, tlsv1.3 ciphers, openssl tlsv1.3 server support, ciphersuites for tlsv1.3, wireshark tlsv1.3, tls interview questions, tlsv1.3 vs tlsv1.2 ">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>Introduction to TLSv1.3</title>

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
    "@id": "tlsv13.jsp"
  },
  "name" : "TLSv1.3 in Nutshell",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "TLSv1.3 in Nutshell",
  "image":"img/tls1.3_06.png",
  "datePublished" : "2018-09-02",
  "dateModified": "2018-09-02",
  "articleSection" : "TLSv1.3 in Nutshel",
  "articleBody" : [ "TLSv1.3 Introduction","TLS Histrory and Development","Major Differences from TLS 1.2","TLS 1.3 Handshake","Ciphersuites","Start the TLS1.3 server in openssl", "Connect to TLS1.3" , "TLSv1.3 Ciphersuites","Browser Support"],
  "publisher" : {
    "@type" : "Organization",
    "name" : "8gwifi.org Tech Blog",
    "logo" :  {
      "@type": "ImageObject",
      "url": "img/logo.jpg"
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
          <h1 class="mt-4">TLSv1.3 in Nutshell</h1>

          <!-- Author -->
          <p class="lead">
            by
            <a href="https://www.linkedin.com/in/anishnath">Anish</a>
            <p>Posted on Sunday September 2, 2018</p>
          </p>
          
          <img class="img-fluid rounded" src="img/tls1.3_06.png" height="100" width="400" alt="Refrence 8gwifi ">
          
          <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>
           
          <hr>

<h2 class="mt-4">Reader Note </h3>

<p><mark>This sample chapter </mark> extracted from the book, <a href="https://leanpub.com/crypto">The Modern Cryptograhy CookBook </a>. The Book theme is<mark>Cryptography is for EveryOne. Learn from Crypto Principle to Applied Cryptography With Practical Example</mark> </p>
<p><mark>Get this book on Just  <a href="http://leanpub.com/crypto/c/NPsT3TZmqrNS" target="_blank" rel="noopener">  $9 </a> by availing coupon discount </mark>   </p>
<p><iframe class="embed-responsive-item" width='160' height='400' src='https://leanpub.com/crypto/embed' frameborder='0' allowtransparency='true'></iframe></p>

<hr>

<h2 class="mt-4">Introduction </h3>
<p>TLS stands for <a href="https://en.wikipedia.org/wiki/Transport_Layer_Security">Transport Layer Security</a> and is the successor to SSL (Secure Sockets Layer). TLS allows client/server applications to communicate over the Internet in a way that is designed to prevent eavesdropping, tampering, and message forgery.<br>
This write-up mostly focus on TLSv 1.3.  TLS 1.3 was defined in <a href="https://en.wikipedia.org/wiki/Request_for_Comments_(identifier)" title="Request for Comments (identifier)">RFC</a>  <a href="https://tools.ietf.org/html/rfc8446">8446</a> in August 2018. It is based on the earlier TLS 1.2 specification.</p>
<h2 class="mt-4"><a id="TLS_Histrory_and_Development_5"></a>TLS Histrory and Development</h2>
<table class="table table-striped table-bordered">
<thead>
<tr>
<th>Protocol</th>
<th>Published</th>
</tr>
</thead>
<tbody>
<tr>
<td>SSL 1.0</td>
<td>Unpublished</td>
</tr>
<tr>
<td>SSL 2.0</td>
<td>1995</td>
</tr>
<tr>
<td>SSL 3.0</td>
<td>1996</td>
</tr>
<tr>
<td>TLS 1.0</td>
<td>1999</td>
</tr>
<tr>
<td>TLS 1.1</td>
<td>2006</td>
</tr>
<tr>
<td>TLS 1.2</td>
<td>2008</td>
</tr>
<tr>
<td>TLS 1.3</td>
<td>2018</td>
</tr>
</tbody>
</table>
<p>TLS1.3  has been over eight years since the last encryption protocol update, but the final version of <strong>TLS 1.3 has now been published as of August 2018</strong> <a href="https://datatracker.ietf.org/doc/rfc8446/">Image Ref</a></p>
<p><img class="img-fluid rounded" src="img/tls1.3_00.png" height="500" alt="enter image description here"></p>

<h2 class="mt-4"><a id="Major_Differences_from_TLS_12_22"></a>Major Differences from TLS 1.2</h2>
<p><img class="img-fluid rounded" src="img/tls1.3_03.png" alt="enter image description here"></p>
<p>From the Wireshark packet capture, its clearly visible the TLSv.1.3, the number of <mark>TLS Handshake</mark> packets is being reduced this offer better speed in TLS v1.3 , and some of the major changes from TLS1.2 as follows</p>
<ul>
<li>The list of supported symmetric encryption algorithms has been pruned of all algorithms that are considered legacy.  Those that remain are all <strong>Authenticated Encryption with Associated Dat</strong>a (AEAD) algorithms.</li>
</ul>
<p><img class="img-fluid rounded" src="img/tls1.3_05.png" alt="enter image description here"></p>
<ul>
<li>The cipher suite concept has been changed to separate the authentication and key exchange mechanisms from the record protection algorithm (including secret key length) and a hash to be used with both the key derivation function and handshake message authentication code (MAC).</li>
</ul>
<ul>
<li>
<p><strong>A zero round-trip</strong> time (0-RTT) mode was added, saving a round trip  at connection setup for some application data, at the cost of certain security properties. <strong>IMP</strong> 0-rtt should be avoided , there are proven replay attack has been found</p>
</li>
<li>
<p>All handshake messages after the <strong>ServerHello</strong> are now <strong>encrypted</strong>.  The newly introduced EncryptedExtensions message allows various extensions previously sent in the clear in the ServerHello to also  enjoy confidentiality protection.</p>
</li>
</ul>
<p><img class="img-fluid rounded" src="img/tls1.3_04.png" alt="enter image description here"></p>
<ul>
<li>
<p>Static <strong>RSA</strong> and <strong>Diffie-Hellman</strong> cipher suites have been <strong>removed</strong>; all  public-key based key exchange mechanisms now provide forward secrecy.</p>
</li>
<li>
<p>The <strong>key derivation</strong> functions have been <strong>redesigned</strong>.</p>
</li>
<li>
<p>The handshake state machine has been significantly restructured to  be more consistent and to <strong>remove</strong> superfluous messages such as ChangeCipherSpec (except when needed for middlebox compatibility).</p>
</li>
<li>
<p>Elliptic curve algorithms are now in the base spec, and new signature algorithms, such as EdDSA, are included.  TLS 1.3 removed point format negotiation in favor of a single point format for each curve.</p>
</li>
<li>
<p>The TLS 1.2 version <strong>negotiation mechanism has been deprecated</strong> in favor of a version list in an extension.  This increases  compatibility with existing servers that incorrectly implemented version negotiation.</p>
</li>
<li>
<p>Session resumption with and without server-side state and the PSK-based ciphersuites of earlier versions of TLS have been replaced by a single new PSK exchange</p>
</li>
</ul>
<h2 class="mt-4"><a id="TLS_13_Handshake_54"></a>TLS 1.3 Handshake</h2>
<p>The handshake can be thought of as having three phases (indicated in the diagram below)<br>
<img class="img-fluid rounded" src="img/tls1.3_06.png" alt="enter image description here"></p>
<ol>
<li>
<p>In the first  phase, the client sends the ClientHello message, which contains</p>
<ul>
<li>random nonce (ClientHello.random);</li>
<li>protocol versions;</li>
<li>symmetric cipher/HKDF hash pairs; either a set of Diffie-Hellman key  shares (in the "key_share" extension</li>
<li>A set of  pre- shared key labels (in the "pre_shared_key" extension or both;</li>
<li>And  potentially additional extensions.</li>
</ul>
</li>
</ol>
<p><img class="img-fluid rounded" src="img/tls1.3_07.png" alt="enter image description here"></p>
<p>The &quot;<strong>key_share</strong>&quot; extension contains the endpoint’s cryptographic <a href="http://parameters.In">parameters.In</a> TLSv1.3 the client selects a “<strong>group</strong>” that it will use for key exchange.</p>
<p>The <strong>PSK</strong>: If clients offer &quot;<strong>pre_shared_key</strong>&quot; without a &quot;<strong>psk_key_exchange_modes</strong>&quot; extension, servers   abort the handshake and used to negotiate the identity of the pre-shared key to be used with a given handshake in association with PSK key establishment</p>
<ol start="2">
<li>The server processes the ClientHello and determines the appropriate cryptographic parameters for the connection.  It then responds with its own ServerHello which indicates the negotiated connection parameters.  The combination of the ClientHello and the ServerHello determines the shared keys</li>
</ol>
<p><img class="img-fluid rounded" src="img/tls1.3_08.png" alt="enter image description here"></p>
<ol start="3">
<li>Upon receiving the server’s messages, the client responds with its Authentication messages, namely Certificate and CertificateVerify (if requested), and Finished.</li>
</ol>
<p><img class="img-fluid rounded" src="img/tls1.3_09.png" alt="enter image description here"></p>
<h2 class="mt-4">TLSv1.3 Ciphersuites</h2>
<p>OpenSSL has implemented support for five TLSv1.3 ciphersuites as follows:</p>
<ol>
<li>
<p>TLS_AES_256_GCM_SHA384</p>
</li>
<li>
<p>TLS_CHACHA20_POLY1305_SHA256</p>
</li>
<li>
<p>TLS_AES_128_GCM_SHA256</p>
</li>
<li>
<p>TLS_AES_128_CCM_8_SHA256</p>
</li>
<li>
<p>TLS_AES_128_CCM_SHA256</p>
<pre><code class="html">openssl ciphers  -v | grep TLSv1.3
TLS_AES_256_GCM_SHA384  TLSv1.3 Kx=any  Au=any  Enc=AESGCM(256) Mac=AEAD
TLS_CHACHA20_POLY1305_SHA256 TLSv1.3 Kx=any  Au=any  Enc=CHACHA20/POLY1305(256) Mac=AEAD
TLS_AES_128_GCM_SHA256 **TLSv1.3** Kx=any  Au=any  Enc=AESGCM(128) Mac=AEAD
</code></pre>
</li>
</ol>
<h2 class="mt-4"></a>openssl Start the TLSv1.3 server</h2>
<p>The forthcoming openssl 1.1.1-pre9 (beta) release has included support for TLSv1.3.</p>
<pre><code class="html">openssl version
OpenSSL 1.1.1-pre9 (beta) 21 Aug 2018
</code></pre>
<p>openssl command to start the tls1.3 server</p>
<pre><code class="html">openssl s_server -accept 443  -tls1_3 -ciphersuites TLS_AES_256_GCM_SHA384 -key key.pem -cert cert.pem
Using default temp DH parameters
ACCEPT
</code></pre>
<h2 class="mt-4"></a>Openssl Connect to TLSv1.3</h2>
<p>The openssl command to connect to tlsv1.3.</p>
<pre><code class="html">openssl s_client -connect 127.0.0.1:443
-----
-----
<mark>New, TLSv1.3, Cipher is TLS_AES_256_GCM_SHA384
Server public key is 4096 bit
Secure Renegotiation IS NOT supported</mark>
Compression: NONE
Expansion: NONE
No ALPN negotiated
Early data was not sent
Verify return code: 18 (self signed certificate)
---
---
Post-Handshake New Session Ticket arrived:
SSL-Session:
   <mark> Protocol  : TLSv1.3
    Cipher    : TLS_AES_256_GCM_SHA384</mark>
    Session-ID: 2BC1AB6B0BE58B527AE4CAEFEABC6D9654094BC1F4D529E5F3F0912A80C97001
    Session-ID-ctx: 
    Resumption PSK: EA4A8E23B397F4F822B770C0922F47F7A66F6A7AA2F2DC4B94B961941AA87ACD611AC293259EFB130887F9A2D02AC89E
    PSK identity: None
    PSK identity hint: None
    SRP username: None
    TLS session ticket lifetime hint: 7200 (seconds)
    TLS session ticket:
</code></pre>

<h2 class="mt-4"></a>TLSv1.3 server with Preshared Key</h2>

First generate a PSK key, and use this PSK to start TLSv1.3 server
<pre><code class="html">PSK=b2c9b9f57ef2fbbba8b624070b301d7f278f1b39c352d5fa849f85a3e7a3f77b 
openssl s_server -accept 443  -tls1_3 -ciphersuites TLS_AES_256_GCM_SHA384 -key key.pem -cert cert.pem -psk $PSK</code></pre>

<p> Connect the TLSv1.3 server with same PSK</p>

<pre><code class="html">PSK=b2c9b9f57ef2fbbba8b624070b301d7f278f1b39c352d5fa849f85a3e7a3f77b
openssl s_client -connect 127.0.0.1:443 -tls1_3 -psk $PSK</code></pre>

<p>On the server side , By using PSK the server authentication is not done with a certificate but with a pre-shared key</p>
<pre><code class="html">
-----BEGIN SSL SESSION PARAMETERS-----
MFUCAQECAgMEBAITAgQABDAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAChBgIEW4wIbaIEAgIcIKQGBAQBAAAA
-----END SSL SESSION PARAMETERS-----
<mark>Shared ciphers:TLS_AES_256_GCM_SHA384
Signature Algorithms: ECDSA+SHA256:ECDSA+SHA384:ECDSA+SHA512:Ed25519:Ed448:RSA-PSS+SHA256:RSA-PSS+SHA384:RSA-PSS+SHA512:RSA-PSS+SHA256:RSA-PSS+SHA384:RSA-PSS+SHA512:RSA+SHA256:RSA+SHA384:RSA+SHA512
Shared Signature Algorithms: ECDSA+SHA256:ECDSA+SHA384:ECDSA+SHA512:Ed25519:Ed448:RSA-PSS+SHA256:RSA-PSS+SHA384:RSA-PSS+SHA512:RSA-PSS+SHA256:RSA-PSS+SHA384:RSA-PSS+SHA512:RSA+SHA256:RSA+SHA384:RSA+SHA512
Supported Elliptic Groups: X25519:P-256:X448:P-521:P-384
Shared Elliptic groups: X25519:P-256:X448:P-521:P-384</mark></code></pre>

<h2 class="mt-4"><a id="Browser_Support_141"></a>Browser Support</h2>
<p>Checkout the browser compatibility for TLS 1.3  here : <a href="https://caniuse.com/#feat=tls1-3">https://caniuse.com/#feat=tls1-3</a></p>
<p><img class="img-fluid rounded" src="img/tls1.3_10.png" alt="enter image description here"></p>
<h2 class="mt-4"><a id="Further_Reading_147"></a>Further Reading</h2>
<p><a href="https://en.wikipedia.org/wiki/Request_for_Comments_(identifier)" title="Request for Comments (identifier)">RFC</a>  <a  href="https://tools.ietf.org/html/rfc8446">8446</a><br>
<a href="https://blog.cloudflare.com/tls-1-3-overview-and-q-and-a/">Cloudflare TLS 1.3 and Q&amp;A</a></p>


<%@ include file="thanks.jsp"%>

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