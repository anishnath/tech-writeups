<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="openstack glance images upload,delete,list,protect image, create image with default disk space">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>Openstack Image Adding Ova/ISO/qcow2 deleting </title>

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
    "@id": "https://8gwifi.org/docs/"
  },
  "name" : "Openstack glance Adding/Deleting Images",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "Openstack glance tutorial",
  "image":"https://8gwifi.org/docs/img/glance.jpg",
  "datePublished" : "2018-06-25",
  "dateModified": "2018-06-25",
  "articleSection" : "Openstack Image Service",
  "articleBody" : [ "Download the Cirros for Testing Image", "Upload the image to the Image service using the <B>QCOW2</B> disk format, <B>bare</B> container format, and public visibility so all projects can access it:", "Upload the image to the Image service using the <B>vmdk</B> disk format, <B>ova</B> container format, and public visibility so all projects can access", "Upload the image to the Image service using the <B>ISO</B> disk format, <B>bare</B> container format, and public visibility so all projects can access it", "Openstack List Images", "Openstack delete Images", "Openstack delete <B>protected</B> Images", "Openstack glance upload image with default disk requirement", "Glance Disks and Container Formats" ],
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
          <h1 class="mt-4">Openstack glance Adding/Deleting Images</h1>

          <!-- Author -->
          <p class="lead">
            by
            <a href="https://www.linkedin.com/in/anishnath">Anish</a>
          </p>

          <hr>

          <!-- Date/Time -->
          <p>Posted on Sunday June 24</p>

          <hr>

        
          <!-- Preview Image 
          <img class="img-fluid rounded" src="http://placehold.it/900x300" alt="">
          -->
           <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>

          <hr>

          <!-- Post Content -->
          <p class="lead">Openstack Image Service</p>

          <p>The Image service (glance) enables users to discover, register, and retrieve virtual machine</p>

          <p>Source the project credentials to gain access to project-only CLI commands:</p>
          <pre><code class="html">. project-openrc</code></pre>
          <p> Download the Cirros for Testing Image </p>
          <pre><code class="html">wget http://download.cirros-cloud.net/0.4.0/cirros-0.4.0-x86_64-disk.img</code></pre>

          <p>Upload the image to the Image service using the <b>QCOW2</b> disk format, <b>bare</b> container format, and public visibility so all projects can access it:</p>
          <pre><code class="html">openstack image create "cirros"  --file cirros-0.4.0-x86_64-disk.img --disk-format qcow2 --container-format bare --public</code></pre>

          <p>Upload the image to the Image service using the <b>vmdk</b> disk format, <b>ova</b> container format, and public visibility so all projects can access it</p>
          <pre><code class="html">openstack image create  centos-7-repo-mirror --container-format ova  --disk-format vmdk --file centos7-mirror-disk1.vmdk --public</code></pre>
          
          <p>Upload the image to the Image service using the <b>ISO</b> disk format, <b>bare</b> container format, and public visibility so all projects can access it</p>
          <pre><code class="html">openstack image create  rhel-workstation-7.3 --public  --container-format bare --disk-format iso --file rhel-workstation-7.3-x86_64-dvd.iso  --public</code></pre>

          <p>Openstack List Images</p>
          <pre><code class="html">openstack image list </code></pre>
          <pre><code class="html">+--------------------------------------+-----------------------------+--------+
| ID                                   | Name                        | Status |
+--------------------------------------+-----------------------------+--------+
| 50fc1d8b-7f7f-41d5-9ec8-8762d377a612 | CentOS-7-GenericCloud.qcow2 | active |
| 8758f8c4-f83b-4ecf-b833-9b6962bd894a | centos-7                    | active |
| 817a63fc-b4e7-4e75-b230-5d27a78ee56a | centos-7-repo-mirror        | active |
| f056158b-0750-4623-b42a-723dbedee99f | cirros                      | active |
| bee327db-797c-4014-8029-98ac7c21c6f1 | rhel-server-7.3-x86_64      | active |
| 61002bcf-c5bb-4c9e-81f5-b7ab184bddb7 | rhel-workstation-7.3        | active |
| 0b99acc1-b84b-46f3-a43a-aaf573a12a19 | rhel7-qcow2                 | active |
+--------------------------------------+-----------------------------+--------+</code></pre>

<p><strong>Openstack delete Images</strong></p>
 <pre><code class="html">openstack image delete 50fc1d8b-7f7f-41d5-9ec8-8762d377a612 </code></pre>

<p><strong>Openstack delete <b>protected</b> Images</strong></p>
<pre><code class="html">openstack image set --unprotected 50fc1d8b-7f7f-41d5-9ec8-8762d377a612
openstack image delete 50fc1d8b-7f7f-41d5-9ec8-8762d377a612</code></pre>

<p><strong>Openstack glance upload image with default disk requirement </strong></p>
<pre><code class="html">openstack image create  rhel-workstation-7.3 --public  --container-format bare --disk-format iso --file rhel-workstation-7.3-x86_64-dvd.iso  --public --protected --min-disk 20</code></pre>
          <hr>

<p> Glance Disks and Container Formats </p>

<table class="table" style="width: 604px; height: 1px;" border="1">
<tbody>
<tr>
<td style="width: 341px;" colspan="2">
<p style="text-align: center;"><strong>Disk Format</strong></p>
</td>
<td style="width: 478px;" colspan="2">
<p style="text-align: center;"><strong>Container Format</strong></p>
</td>
</tr>
<tr>
<td style="width: 72px;">
<p><strong>aki</strong></p>
</td>
<td style="width: 269px;">
<p>Amazon Kernel Package</p>
</td>
<td style="width: 10px;">
<p><strong>aki</strong></p>
</td>
<td style="width: 468px;">
<p>Amazon Kernel Package</p>
</td>
</tr>
<tr>
<td style="width: 72px;">
<p><strong>ami</strong></p>
</td>
<td style="width: 269px;">
<p>Amazon machine image</p>
</td>
<td style="width: 10px;">
<p><strong>ami</strong></p>
</td>
<td style="width: 468px;">
<p>Amazon machine image</p>
</td>
</tr>
<tr>
<td style="width: 72px;">
<p><strong>ari</strong></p>
</td>
<td style="width: 269px;">
<p>Amazon ramdisk Image</p>
</td>
<td style="width: 10px;">
<p><strong>ari</strong></p>
</td>
<td style="width: 468px;">
<p>Amazon ramdisk Image</p>
</td>
</tr>
<tr>
<td style="width: 72px;">
<p><strong>iso</strong></p>
</td>
<td style="width: 269px;">
<p>Optical disks</p>
</td>
<td style="width: 10px;">
<p><strong>bare</strong></p>
</td>
<td style="width: 468px;">
<p>The image does not have a container or metadata envelope. It is safe to specify&nbsp;bare&nbsp;as the container format if you are unsure.</p>
</td>
</tr>
<tr>
<td style="width: 72px;">
<p><strong>qcow2</strong></p>
<p>&nbsp;</p>
</td>
<td style="width: 269px;">
<p>Qemu Emulator</p>
</td>
<td style="width: 10px;">
<p><strong>Docker</strong></p>
</td>
<td style="width: 468px;">
<p>A docker container format.</p>
<p>&nbsp;</p>
</td>
</tr>
<tr>
<td style="width: 72px;">
<p><strong>raw</strong></p>
<p>&nbsp;</p>
</td>
<td style="width: 269px;">
<p>An unstructured disk image format</p>
<p>Usually without Extenstions</p>
</td>
<td style="width: 10px;">
<p><strong>ova</strong></p>
<p>&nbsp;</p>
</td>
<td style="width: 468px;">
<p>An OVF package in a tarfile.</p>
<p>&nbsp;</p>
</td>
</tr>
<tr>
<td style="width: 72px;">
<p><strong>vdi</strong></p>
</td>
<td style="width: 269px;">
<p>Oracle VirtualBox</p>
</td>
<td style="width: 10px;">
<p><strong>ovf</strong></p>
</td>
<td style="width: 468px;">
<p>The OVF container format.</p>
<p>&nbsp;</p>
</td>
</tr>
<tr>
<td style="width: 72px;">
<p><strong>vhd</strong></p>
</td>
<td style="width: 269px;">
<p>Used by Oracle Virtual Box, vmWare,Xen</p>
</td>
<td style="width: 478px;" colspan="2">
<p>&nbsp;</p>
</td>
</tr>
<tr>
<td style="width: 72px;">
<p><strong>vhdx</strong></p>
</td>
<td style="width: 269px;">
<p>Enhanced version of vhd format</p>
</td>
<td style="width: 478px;" colspan="2">
<p>&nbsp;</p>
</td>
</tr>
<tr>
<td style="width: 72px;">
<p><strong>vmdk</strong></p>
</td>
<td style="width: 269px;">
<p>Common disk format</p>
</td>
<td style="width: 478px;" colspan="2">
<p>&nbsp;</p>
</td>
</tr>
</tbody>
</table>
<p>&nbsp;</p>

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
         <%@ include file="related-window-crypto.jsp"%>
         
         <!-- Topic Widget -->
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