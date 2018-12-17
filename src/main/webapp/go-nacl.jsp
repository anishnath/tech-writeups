<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="go lang NACL Cryptography, Nacl Box,Nacl SecretBox,NaCl Message Authentication,Nacl Digital Signature ">
    <meta name="keywords" content="go lang NACL Cryptography, Nacl Box,Nacl SecretBox,NaCl Message Authentication,Nacl Digital Signature , go lang nacl example, nacl example, libsodium nacl go lang ">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>go lang rsa nacl cryptography</title>

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
    "@id": "https://8gwifi.org/docs/go-nacl.jsp"
  },
  "name" : "go lang rsa nacl cryptography",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "Go Lang NACL Cryptography",
  "image":"https://8gwifi.org/docs/img/go-nacl.png",
  "datePublished" : "2018-12-17",
  "dateModified": "2018-12-17",
  "articleSection" : "Go Lang NACL Cryptography ",
  "articleBody" : [ "Nacl Box", "Nacl Box Faster Computing with Shared Key" , "NACL Box Precompute Example", "Nacl SecretBox" , "NaCl Message Authentication" , "Nacl Digital Signature" , "go lang nacl example", "go lang nacl secret box" , "go nacl"],
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
          <h1 class="mt-4">Go Lang NACL Cryptography</h1>

          <!-- Author -->
          <p class="lead">
            by
            <a href="https://www.linkedin.com/in/anishnath">Anish</a>
            <p>Posted on Monday December 17 , 2018</p>
          </p>
          
           <img class="img-fluid rounded" src="img/go-nacl.png" height="400" width="600" alt="go lang nacl ">
          
          
          <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>
           
           <p><mark>This sample chapter </mark> extracted from the book, <a href="https://leanpub.com/cryptog">Go Lang Cryptography for Developers </a>. The Book theme is<mark>Cryptography is for EveryOne. Learn from Crypto Principle to Applied Cryptography With Practical Example</mark> </p>
		   <p><iframe class="embed-responsive-item" width='160' height='400' src='https://leanpub.com/cryptog/embed' frameborder='0' allowtransparency='true'></iframe></p>
           
          <hr>
          
          <p><strong>NaCl</strong> (pronounced &quot;<strong>salt</strong>&quot;) is a new easy-to-use high-speed software library for network communication, encryption, decryption, signatures, etc. NaCl's goal is to provide all of the core operations needed to build higher-level cryptographic tools.</p>
<h3 class="mt-4"><a id="Nacl_Box_4"></a>Nacl Box</h3>
<p>The Nacl <strong>Box</strong> uses the given public and private (secret) keys to <strong>derive</strong> a shared key, which is used with the nonce given to encrypt the given messages and to decrypt the given ciphertexts.</p>
<p>The same <strong>shared key</strong> will be generated from both pairing of keys, so given two keypairs belonging to <strong>Alice</strong> (pkalice, skalice) and <strong>Bob</strong> (pkbob, skbob), the key <strong>derived</strong> from (pkalice, skbob) will <strong>equal</strong> that from (pkbob, skalice).</p>
<p><a href="https://godoc.org/golang.org/x/crypto/nacl/box">golang.org/x/crypto/nacl/box</a>  authenticates and encrypts small messages using public-key cryptography.</p>
<p>Box uses <strong>Curve25519</strong>, <strong>XSalsa20</strong> and <strong>Poly1305</strong> to encrypt and authenticate messages. The length of messages is not hidden.</p>
<p><strong>func</strong> <code>Seal</code>   appends an encrypted and authenticated copy of message to out, which will be Overhead bytes longer than the original and must not overlap it. The nonce must be unique for each distinct message for a given pair of keys.</p>

<pre><code class="html">func Seal(out, message []byte, nonce *[24]byte, peersPublicKey, privateKey *[32]byte) []byte
</code></pre>
<p><strong>func</strong> <code>Open</code>   Open authenticates and decrypts a box produced by Seal and appends the message to out, which must not overlap box. The output will be Overhead bytes smaller than box</p>

<pre><code class="html">func Open(out, box []byte, nonce *[24]byte, peersPublicKey, privateKey *[32]byte) ([]byte, bool)
</code></pre>
<p><strong>func</strong> <code>GenerateKey</code>  GenerateKey generates a new public/private key pair suitable for use with Seal and Open</p>

<pre><code class="html">func GenerateKey(rand io.Reader) (publicKey, privateKey *[32]byte, err error)</code></pre>
<p>The following example will show how to use NACL box, to secretly send encrypted and authenticated copy of message from Alice to Bob</p>
<ul>
<li>Public Cryptography requires Key Pair, So first generate. In real world the receiver private key is not known to the sender, only the public key is known.</li>
<li>Nonce is appended to encrypted message and then send to the receiver.</li>
<li>Use the <strong>same</strong> nonce you used to encrypt the message, this is usually done by <strong>storing</strong> nonce <strong>alongside</strong> the encrypted message</li>
</ul>

<pre><code class="html">package main  
  
import (  
   crypto_rand "crypto/rand"  
  "fmt"  
  "golang.org/x/crypto/nacl/box" 
  "io"
  )  
func main() {  
   plaintext := "Hello 8gwifi.org using go lang Box Example"  
   pkalice, skalice, err := box.GenerateKey(crypto_rand.Reader)  
   if err != nil {  
      panic(err)  
   }  
   
   pkbob, skbob, err := box.GenerateKey(crypto_rand.Reader)  
   if err != nil {  
      panic(err)  
   }  
   fmt.Printf("Original Text:  %s\n", plaintext)  
   fmt.Println("====NACL Box Seal/ Open====")  
  
   // You must use a different nonce for each message you encrypt with the  
   // same key. Since the nonce here is 192 bits long, a random value 
   // provides a sufficiently small probability of repeats.  var nonce [24]byte  
   if _, err := io.ReadFull(crypto_rand.Reader, nonce[:]); err != nil {  
      panic(err)  
   }  
  
   // This encrypts msg and appends the result to the nonce.  
   encrypted := box.Seal(nonce[:], []byte(plaintext), &nonce, pkbob, skalice)  
   fmt.Printf("Alice Send Encrypted Message to Bob  %x\n", encrypted)  
  
   // The recipient can decrypt the message using their private key and the  
   // sender's public key. When you decrypt, you must use the same nonce you 
   // used to encrypt   the message. One way to achieve this is to store the 
   // nonce alongside the encrypted message. Above, we stored the nonce in the 
   // first 24 bytes of the encrypted text. 
   var decryptNonce [24]byte  
   copy(decryptNonce[:], encrypted[:24])  
   decrypted, ok := box.Open(nil, encrypted[24:], &decryptNonce, pkalice, skbob)  
   if !ok {  
      panic("decryption error")  
   }  
  
   fmt.Println("Bob Read Message[", string(decrypted), "]")  
  
}
</code></pre>
<p><strong>The output</strong></p>

<pre><code class="language-console">$ go run naclbox.go
Original Text:  Hello 8gwifi.org using go lang Box Example
====NACL Box Seal/ Open====
Alice Send Encrypted Message to Bob  420d83bc6d773bd0597002edc430ae44452d60ba7fa3402b3cdd827343b10a9c0c0a783a1aeb81829a52c3ed15b58568620fc4c807abbfbb48cafe9370567b6201bc33f5289a8d2cf227cd57d512177e22fa
Bob Read Message[ Hello 8gwifi.org using go lang Box Example ]
</code></pre>
<p><strong>Nacl Box Faster Computing with Shared Key</strong></p>
<p>The shared key can be used to speed up processing when using the same, pair of keys repeatedly. To achieve this use the go lang functions</p>
<p>func <code>SealAfterPrecomputation</code> performs the same actions as Seal, but takes a shared key as generated by Precompute.</p>

<pre><code class="language-go"><span class="hljs-keyword">func</span> SealAfterPrecomputation(out, message []<span class="hljs-typename">byte</span>, nonce *[<span class="hljs-number">24</span>]<span class="hljs-typename">byte</span>, sharedKey *[<span class="hljs-number">32</span>]<span class="hljs-typename">byte</span>) []<span class="hljs-typename">byte</span>
</code></pre>
<p>func <code>OpenAfterPrecomputation</code> n performs the same actions as Open, but takes a shared key as generated by Precompute.</p>
<pre><code class="language-go"><span class="hljs-keyword">func</span> OpenAfterPrecomputation(out, box []<span class="hljs-typename">byte</span>, nonce *[<span class="hljs-number">24</span>]<span class="hljs-typename">byte</span>, sharedKey *[<span class="hljs-number">32</span>]<span class="hljs-typename">byte</span>) ([]<span class="hljs-typename">byte</span>, <span class="hljs-typename">bool</span>)
</code></pre>
<p><strong>NACL Box Precompute Example</strong></p>

<pre><code class="html">package main  
  
import (  
   crypto_rand "crypto/rand" // Custom so it's clear which rand we're using.  
  "fmt"  
  "golang.org/x/crypto/nacl/box" 
  "io"
  )  
  
func main() {  
   plaintext := "Hello 8gwifi.org using go lang Box Example"  
   pkalice, skalice, err := box.GenerateKey(crypto_rand.Reader)  
   if err != nil {  
      panic(err)  
   }  
   pkbob, skbob, err := box.GenerateKey(crypto_rand.Reader)  
   if err != nil {  
      panic(err)  
   }  
   fmt.Printf("Original Text:  %s\n", plaintext)  
   fmt.Println("====NACL Box SealAfterPrecomputation/ OpenAfterPrecomputation====")  
  
   // You must use a different nonce for each message you encrypt with the  
   // same key. Since the nonce here is 192 bits long, a random value 
   // provides a sufficiently small probability of repeats.  
   var nonce [24]byte  
   if _, err := io.ReadFull(crypto_rand.Reader, nonce[:]); err != nil {  
      panic(err)  
   }  
   // The shared key can be used to speed up processing when using the same  
   // pair of keys repeatedly.  sharedEncryptKey := new([32]byte)  
   box.Precompute(sharedEncryptKey, pkbob, skalice)  
   fmt.Printf("Shared Key [%x\n", *sharedEncryptKey, "]")  
  
   // This encrypts msg and appends the result to the nonce.  
   encrypted := box.SealAfterPrecomputation(nonce[:], []byte(plaintext), &nonce, sharedEncryptKey)  
  
   fmt.Printf("Alice Send Encrypted Message to Bob  %x\n", &encrypted)  
   // The shared key can be used to speed up processing when using the same  
   // pair of keys repeatedly.  var sharedDecryptKey [32]byte  
   box.Precompute(&sharedDecryptKey, pkalice, skbob)  
   // The recipient can decrypt the message using their private key and the  
   // sender's public key. When you decrypt, you must use the same nonce you 
   // used to encrypt the message. One way to achieve this is to store the 
   // nonce alongside the encrypted message. Above, we stored the nonce in the 
   // first 24 bytes of the encrypted text.  var decryptNonce [24]byte  
   copy(decryptNonce[:], encrypted[:24])  
   decrypted, ok := box.OpenAfterPrecomputation(nil, encrypted[24:], &decryptNonce, &sharedDecryptKey)  
   if !ok {  
      panic("decryption error")  
   }  
   fmt.Println("Bob Read Message[", string(decrypted), "]")  
}
</code></pre>
<p><strong>The output</strong></p>

<pre><code class="language-console">$ go run naclbox1.go
Original Text:  Hello 8gwifi.org using go lang Box Example
====NACL Box SealAfterPrecomputation/ OpenAfterPrecomputation====
Shared Key [20e4228e59d552f15ab04a67269b792957d7a71400b353940bcd13b225795ec3
Alice Send Encrypted Message to Bob  &amp;3e6b0011dfcfcd9163f7d3cb68eeadf683f941f7dfca1b3c7637bf9e0fe75563b3db93ef7f357f475b7c4d1c9789c8e396951488b0cc1892668dcf9b3ed10d37feebd059622175071de065394c31478bdb0d
Bob Read Message[ Hello 8gwifi.org using go lang Box Example ]
</code></pre>
<h3 class="mt-4"><a id="Nacl_SecretBox_192"></a>Nacl SecretBox</h3>
<p>Secret key encryption (also called symmetric key encryption) is analogous to a safe. You can store something secret through it and anyone who has the key can open it and view the contents.  <a href="https://godoc.org/golang.org/x/crypto/nacl/secretbox">SecretBox</a>  functions as just such a safe, and like any good safe any attempts to tamper with the contents are easily detected.</p>
<p>Go lang Package <a href="https://godoc.org/golang.org/x/crypto/nacl/secretbox">secretbox</a>  uses XSalsa20 and Poly1305 to encrypt and authenticate messages with secret-key cryptography. The length of messages is not hidden.</p>
<p>func <code>Seal</code> appends an encrypted and authenticated copy of message to out, which must not overlap message. The key and nonce pair must be unique for each distinct message and the output will be Overhead bytes longer than message</p>

<pre><code class="language-go"><span class="hljs-keyword">func</span> Seal(out, message []<span class="hljs-typename">byte</span>, nonce *[<span class="hljs-number">24</span>]<span class="hljs-typename">byte</span>, key *[<span class="hljs-number">32</span>]<span class="hljs-typename">byte</span>) []<span class="hljs-typename">byte</span>
</code></pre>
<p>func <code>open</code> authenticates and decrypts a box produced by Seal and appends the message to out, which must not overlap box. The output will be Overhead bytes smaller than box.</p>

<pre><code class="language-go"><span class="hljs-keyword">func</span> Open(out, box []<span class="hljs-typename">byte</span>, nonce *[<span class="hljs-number">24</span>]<span class="hljs-typename">byte</span>, key *[<span class="hljs-number">32</span>]<span class="hljs-typename">byte</span>) ([]<span class="hljs-typename">byte</span>, <span class="hljs-typename">bool</span>)
</code></pre>
<p><strong>Note: secretbox encrypts and authenticates small messages.</strong></p>
<p>The following example will show how to use NACL <strong>secretbox</strong>, to perform Secret key encryption.</p>
<ul>
<li>nonce must be 24 bytes</li>
<li>secret key must be of 32 bytes</li>
</ul>

<pre><code class="html">import (  
 "crypto/rand"  
 "fmt" 
 "golang.org/x/crypto/nacl/secretbox" 
 "io"
 )   
func main() {  
   plaintext := "Hello 8gwifi.org using go lang secretbox esample"  
  // Do not Use this Key, This is for Demo Purpose only  
  key := "myverystrongpasswordo32bitlength"  
  var secretKey [32]byte  
  copy(secretKey[:], key)  

  fmt.Printf("Original Text:  %s\n", plaintext)  
  fmt.Println("====NACL secretbox Seal/ Open====")
  
   // You must use a different nonce for each message you encrypt with the  
   // same key. Since the nonce here is 192 bits long, a random value 
   // provides a sufficiently small probability of repeats.  
   var nonce [24]byte  
   if _, err := io.ReadFull(rand.Reader, nonce[:]); err != nil {  
      panic(err)  
   }  
   encrypted := secretbox.Seal(nonce[:], []byte(plaintext), &nonce, &secretKey)  
   fmt.Printf("Encrypted Message:  %x\n", encrypted)  
  
   // When you decrypt, you must use the same nonce and key you used to  
   // encrypt the message. One way to achieve this is to store the nonce 
   // alongside the encrypted message. Above, we stored the nonce in the first 
   // 24 bytes of the encrypted text.  var decryptNonce [24]byte  
   copy(decryptNonce[:], encrypted[:24])  
   decrypted, ok := secretbox.Open(nil, encrypted[24:], &decryptNonce, &secretKey)  
   if !ok {  
      panic("decryption error")  
   }  
   fmt.Println(string(decrypted))  
}
</code></pre>
<p><strong>The output</strong></p>

<pre><code class="language-console">$ go run naclsecretbox.go
Original Text:  Hello 8gwifi.org using go lang secretbox esample
====NACL secretbox Seal/ Open====
Encrypted Message:  fc62734e5c73ceec5e3dfe75a439bc85d13138e97423e79a7fbb17ceef34cc0f47fe26d330cf83fe3210d2a93815e3706be29dce5a282c764001dd6d471781efdf5568a2cc3220cba7f29a7fa041565010c04a0ed1b76b78
Hello 8gwifi.org using go lang secretbox esample
</code></pre>
<h3 class="mt-4"><a id="NaCl_Message_Authentication_273"></a>NaCl Message Authentication</h3>
<p>Nacl Message is done with go lang function <a href="https://godoc.org/golang.org/x/crypto/nacl/auth">auth</a></p>
<p>func <code>sum</code> generates an authenticator for m using a secret key and returns the 32-byte digest.</p>

<pre><code class="language-go"><span class="hljs-keyword">func</span> Sum(m []<span class="hljs-typename">byte</span>, key *[KeySize]<span class="hljs-typename">byte</span>) *[Size]<span class="hljs-typename">byte</span>
</code></pre>
<p>func <code>verify</code> checks that digest is a valid authenticator of message m under the given secret key. Verify does not leak timing information.</p>

<pre><code class="language-go"><span class="hljs-keyword">func</span> Verify(digest []<span class="hljs-typename">byte</span>, m []<span class="hljs-typename">byte</span>, key *[KeySize]<span class="hljs-typename">byte</span>) <span class="hljs-typename">bool</span>
</code></pre>
<p>The following example will show how to use NACL <strong>auth</strong>, to perform message authentication of a given message</p>
<ul>
<li>secret key must be of 32 bytes.</li>
</ul>

<pre><code class="html">package main  
  
import (  
   "fmt"  
   "golang.org/x/crypto/nacl/auth"
   )  
func main() {  
  
    plaintext := "Hello 8gwifi.org using go lang auth esample"  
   // Do not Use this Key, This is for Demo Purpose only  
   key := "myverystrongpasswordo32bitlengt"  
   var secretKey [32]byte  
   copy(secretKey[:], key)  
  
   fmt.Printf("Original Text:  %s\n", plaintext)  
   fmt.Println("====NACL Message Authentication====")  
  
   mac := auth.Sum([]byte(plaintext), &secretKey)  
   fmt.Printf("MAC %x\n", *mac)  
   result := auth.Verify(mac[:], []byte(plaintext), &secretKey)  
   fmt.Println("Verified : ", result)  
  
   badResult := auth.Verify(mac[:], []byte("different message"), &secretKey)  
   fmt.Println("Verified : ", badResult)  
}
</code></pre>
<p><strong>The output</strong></p>

<pre><code class="language-console">$ go run naclauth.go
Original Text:  Hello 8gwifi.org using go lang auth esample
====NACL Message Authentication====
MAC 2a6bb7feb6b2c175219abcc16fb7c472e48752212cebc4aada48a49d767cdbb5
Verified :  true
Verified :  false
</code></pre>
<hr>
<%@ include file="footer_adsense.jsp"%> 
<h3 class="mt-4"><a id="Nacl_Digital_Signature_336"></a>Nacl Digital Signature</h3>
<p>Digital signatures allow you to publish a public key, and then you can use your private signing key to sign messages. Others who have your public key can then use it to validate that your messages are actually authentic.</p>
<p>Nacl Digital Signature is done with go lang function <a href="https://godoc.org/golang.org/x/crypto/nacl/sign">sign</a></p>
<p>func  <code>GenerateKey</code> generates a new public/private key pair suitable for use with Sign and Open.</p>

<pre><code class="language-go"><span class="hljs-keyword">func</span> GenerateKey(rand io.Reader) (publicKey *[<span class="hljs-number">32</span>]<span class="hljs-typename">byte</span>, privateKey *[<span class="hljs-number">64</span>]<span class="hljs-typename">byte</span>, err error)
</code></pre>
<p>func <code>Open</code> verifies a signed message produced by Sign and appends the message to out, which must not overlap the signed message.</p>

<pre><code class="language-go"><span class="hljs-keyword">func</span> Open(out, signedMessage []<span class="hljs-typename">byte</span>, publicKey *[<span class="hljs-number">32</span>]<span class="hljs-typename">byte</span>) ([]<span class="hljs-typename">byte</span>, <span class="hljs-typename">bool</span>)
</code></pre>
<p>func <code>sign</code> appends a signed copy of message to out</p>

<pre><code class="language-go"><span class="hljs-keyword">func</span> Sign(out, message []<span class="hljs-typename">byte</span>, privateKey *[<span class="hljs-number">64</span>]<span class="hljs-typename">byte</span>) []<span class="hljs-typename">byte</span>
</code></pre>
<p>The following example will show how to use NACL <strong>digital signature</strong>.</p>
<ul>
<li>Private key for producing digital signatures using the Ed25519 algorithm.</li>
<li>Message is Signed with private key</li>
<li>Signature is verified using public key.</li>
</ul>

<pre><code class="html">package main  
import (  
   "crypto/rand"  
   "fmt" 
   "golang.org/x/crypto/nacl/sign"  
)  
func main() {  
   plaintext := "Hello 8gwifi.org using go lang nacl signing esample"  
   fmt.Printf("Original Text:  %s\n", plaintext)  
   fmt.Println("====NACL Digital Signature====")  
     
   publicKey, privateKey, _ := sign.GenerateKey(rand.Reader)  
   // Signing of Message is Perfomed with Private Key  
   signedMessage := sign.Sign(nil, []byte(plaintext), privateKey)  
   fmt.Printf("Message Signature %x\n ", signedMessage)  
   // Verification of the Message is performed with Public Key  
  _ , ok := sign.Open(nil, signedMessage, publicKey)  
   
   f !ok {  
      fmt.Printf("failed to verify signed message")  
      return  
  }  
   fmt.Printf("Verification  Passed ")  
  
}
</code></pre>
<p><strong>The output</strong></p>

<pre><code class="language-console">$ go run naclsign.go
Original Text:  Hello 8gwifi.org using go lang nacl signing esample
====NACL Digital Signature====
Message Signature 1020e3901fc37f3c792a3d435ce7abca877c5171971227b6430f778ef8c245764149185abcef409de7e8e221afa723356363c017a1a46273c969b4809d52920e48656c6c6f203867776966692e6f7267207573696e6720676f206c616e67206e61636c207369676e696e67206573616d706c65
 Verifification Passed
</code></pre>
<p>{pagebreak}</p>

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