<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Openstack freenas installation">
    <meta name="keywords" content="Openstack freenas installation,freenas in openstack, how to install freenas in openstack,freenas openstack volume">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>freenas installation in openstack </title>

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
    "@id": "https://8gwifi.org/docs/openstack-nfs.jsp"
  },
  "name" : "freenas installation in openstack",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "freenas installation in openstack",
  "image":"https://8gwifi.org/docs/img/freenas15.png",
  "datePublished" : "2018-07-07",
  "dateModified": "2018-07-07",
  "articleSection" : "FreeNas installation in Openstack",
  "articleBody" : [ "FreeNas installation in Openstack", "openstack create a non-bootable volume first", "Upload the latest ISO of free NAS in the openstack Image ","Launch an openstack server instance using the FreeNas-ISO image","No go the openstack volume and attach this volume to the currently launched openstack instance","Perform a hardreboot in the openstack server instance, when the instance is running, go to the console, you will be noticing the below screen" ,"Follow the freenas installation instruction"],
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
          <h1 class="mt-4">FreeNas installation in Openstack  </h1>
          <%@ include file="footer_adsense.jsp"%>

          <!-- Author -->
          <p class="lead">
            by
            <a href="https://www.linkedin.com/in/anishnath">Anish</a>
          </p>

          <hr>
          
          <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>

          <!-- Date/Time -->
          <p>Posted on Saturday July 7 2018</p>
          
          <p>FreeNAS is a Free and Open Source Network Attached Storage (NAS) software appliance. This means that you can use FreeNAS to share data over file-based sharing protocols, including CIFS for Windows users, NFS for Unix-like operating systems, and AFP for Mac OS X users. FreeNAS uses the ZFS file system to store, manage, and protect data. ZFS provides advanced features like snapshots to keep old versions of files, incremental remote backups to keep your data safe on another device without huge file transfers, and intelligent compression, which reduces the size of files so quickly and efficiently that it actually helps transfers happen faster.</p>
		  <img class="img-fluid rounded" src="img/freenas15.png" alt="">
          <hr>

		
		
		<p><b>Step-1</b> Upload the latest ISO of free NAS in the openstack Image This can be found at the location 
<code>http://www.freenas.org/download-freenas-release/</code>
		</p>        
          <img class="img-fluid rounded" src="img/freenas1.png" alt="">
          <p><b>Step-2</b> In openstack create a non-bootable volume first</p>
          <img class="img-fluid rounded" src="img/freenas2.png" alt="">
          <p><b>Step-3</b> Launch an openstack server instance using the FreeNas-ISO image </p>
          <img class="img-fluid rounded" src="img/freenas3.png" alt="">
          <p><b>Step-4</b> No go the openstack volume and attach this volume to the currently launched openstack instance  </p>
          <img class="img-fluid rounded" src="img/freenas4.png" alt="">
          <p><b>Step-5</b> Perform a hardreboot in the openstack server instance, when the instance is running, go to the console, you will be noticing the below screen  </p>
          <img class="img-fluid rounded" src="img/freenas5.png" alt="">
          <p><b>Step-6</b> The new openstack volume is detected by the freenas </p>
          <img class="img-fluid rounded" src="img/freenas6.png" alt="">
          <p><b>Step-7</b> Follow the freenas installation instruction  </p>
          <img class="img-fluid rounded" src="img/freenas7.png" alt="">
          <p><b>Step-8</b> Setup the freenas root password   </p>
          <img class="img-fluid rounded" src="img/freenas8.png" alt="">
          <p><b>Step-9</b> Boot vis BIOS   </p>
          <img class="img-fluid rounded" src="img/freenas9.png" alt="">
          <p><b>Step-10</b> Rebbot the Server   </p>
          <img class="img-fluid rounded" src="img/freenas10.png" alt="">
          <p><b>Step-11</b> Delete the openstack Instance running freenas   </p>
          <img class="img-fluid rounded" src="img/freenas11.png" alt="">
          <p><b>Step-12</b> Make the created volume bootable   </p>
          <img class="img-fluid rounded" src="img/freenas12.png" alt="">
          <p><b>Step-13</b> Launch a new openstack instance with this bootable volume , freenas Minimum ram requirement is 8GB    </p>
          <img class="img-fluid rounded" src="img/freenas13.png" alt="">
          <p><b>Step-14</b> Verify the VNC openstack console, freenas server should be up and running on the webserver  </p>
          <img class="img-fluid rounded" src="img/freenas14.png" alt="">
		  <p><b>Step-15</b> Login to freenas webserver <br>
<code>Username: root<br>
Password: setup during the freenas Installation</code>
   </p>
          <img class="img-fluid rounded" src="img/freenas15.png" alt="">
          
          <hr>
<p><strong> Thanku for reading !!! Give a Share for Support</strong></p>
           <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>

          <hr>


          



      <!-- Comments Form -->
    

          <!-- Single Comment -->
 

          <!-- Comment with nested comments -->
          

        </div>

        <!-- Sidebar Widgets Column -->
        <div class="col-md-4">

          <!-- Ad Widget -->
         <%@ include file="footer_adsense.jsp"%> 

          <!-- Categories Widget -->
         <%@ include file="related-openstack.jsp"%>
         
         <%@ include file="related-cryptography.jsp"%>
         
          <!-- Side Widget -->
         <%@ include file="side.jsp"%>
         
         
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