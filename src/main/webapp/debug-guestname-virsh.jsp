<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="virt-install ERROR    Guest name 'centos' is already in use.">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>virt-install ERROR    Guest name 'centos' is already in use </title>

    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/blog-post.css" rel="stylesheet">
    
    <link rel="stylesheet"  href="css/highlight/default.min.css">
	<script src="css/highlight/highlight.min.js"></script>
	<script>hljs.initHighlightingOnLoad();</script>
	
	
		<!-- JSON-LD markup generated by Google Structured Data Markup Helper. -->
<script type="application/ld+json">
{
  "@context" : "http://schema.org",
  "@type" : "Article",
  "mainEntityOfPage": {
    "@type": "WebPage",
    "@id": "https://8gwifi.org/docs/debug-guestname-virsh.jsp"
  },
  "name" : "virt-install ERROR    Guest name 'centos' is already in use",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "virt-install ERROR    Guest name 'centos' is already in use",
  "image":"https://8gwifi.org/docs/img/debug-guestname-virsh.png",
  "datePublished" : "2018-06-26",
  "dateModified": "2018-06-26",
  "articleSection" : "virt-install ERROR Guest name centos is already in use",
  "articleBody" : [ "virt-install ERROR Guest name centos is already in use", "undefine centos","virsh","virt-install"],
  "publisher" : {
    "@type" : "Organization",
    "name" : "8gwifi.org Tech Blog",
    "logo" :   {
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
          <h1 class="mt-4">virt-install ERROR Guest name 'centos' is already in use</h1>

          <!-- Author -->
          <p class="lead">
            by
            <a href="https://www.linkedin.com/in/anishnath">Anish</a>
          </p>

          <hr>

          <!-- Date/Time -->
          <p>Posted on Tuesday June 26</p>

          <hr>

        
          <!-- Preview Image 
          <img class="img-fluid rounded" src="http://placehold.it/900x300" alt="">
          -->
           <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>

          <hr>

          <!-- Post Content -->
          <p class="lead">Getting <strong>virt-install error guest name already in use </strong> </p>

          

          
       	  <pre><code class="html">virt-install --virt-type kvm --name centos --ram 1024 \
  --disk centos-7.qcow2,format=qcow2 \
  --network network=default \
  --graphics vnc,listen=0.0.0.0 --noautoconsole \
  --os-type=linux --os-variant=centos7.0 \
  --location=CentOS-7-x86_64-Minimal-1804.iso \
  --wait=-1 \
  --noreboot</code></pre>
          <pre><code class="html">ERROR    Guest name 'centos' is already in use.</code></pre>

          <p>Type the command <strong> virsh</strong> in console</p>
          <pre><code class="html">bash ~ virsh
Welcome to virsh, the virtualization interactive terminal.</code></pre>

          <p>Undefine <strong> centos </strong></p>
          <pre><code class="html">virsh # undefine centos
Domain centos has been undefined</code></pre>
          
          <p>Re-run the <strong>virt-install</strong> command </p>
          

          <!-- Comments Form -->
    

          <!-- Single Comment -->
 

          <!-- Comment with nested comments -->
          

        </div>

        <!-- Sidebar Widgets Column -->
        <div class="col-md-4">

          <!-- Ad Widget -->
         <%@ include file="footer_adsense.jsp"%> 

         <!-- Article Widget -->
         <%@ include file="related-openstack.jsp"%>
         
         
          <!-- Article Widget -->
         <%@ include file="related-linux.jsp"%>
         
           <!-- Article Widget -->
         <%@ include file="related-ansible.jsp"%>
         
         <%@ include file="related-kube.jsp"%>
         
         
         
         <%@ include file="related-cryptography.jsp"%>
         
         <!-- Topic Widget -->
         <%@ include file="side.jsp"%>
         
           <!-- Add Comments Support -->
         <%@ include file="addcomments.jsp"%>
         

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

    <!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  </body>

</html>