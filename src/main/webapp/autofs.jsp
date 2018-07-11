<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Auto-mounting an NFS share using autofs, troubleshoot autofs">
    <meta name="keywords" content="autofs,nfs share,freenas autoshare,nas mounting,troubleshoot autofs,How autofs works">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>Auto-mounting an NFS share using autofs </title>

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
    "@id": "https://8gwifi.org/docs/autofs.jsp"
  },
  "name" : "Auto-mounting an NFS share using autofs, troubleshoot autofs",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "Auto-mounting an NFS share using autofs",
  "image":"https://8gwifi.org/docs/img/autofs.png",
  "datePublished" : "2018-07-26",
  "dateModified": "2018-07-26",
  "articleSection" : "Auto-mounting an NFS share using autofs",
  "articleBody" : [ "Auto-mounting an NFS share using autofs", "Configuring user home directory in NFS share", "Troubleshooting autofs","The Name Service Switch (NSS) configuration file","/etc/auto.master and create an indirect maps"],
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
          <h1 class="mt-4">Auto-mounting an NFS share using autofs</h1>

          <!-- Author -->
          <p class="lead">
            by
            <a href="https://www.linkedin.com/in/anishnath">Anish</a>
          </p>

          <hr>

          <!-- Date/Time -->
          <p>Posted on Friday July 6</p>

          <hr>

        
 
          <img class="img-fluid rounded" src="img/autofs.png" alt="Referefce https://docs.oracle.com/cd/E23823_01/html/816-4555/rfsrefer-75.html">

           <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>

          <hr>

          <!-- Post Content -->
          
          
 

<p><strong>autofs</strong> is a program for automatically mounting directories on an as-needed basis. Auto-mounts are mounted only as they are accessed, and are unmounted after a period of inactivity. Because of this, automounting NFS/Samba shares conserves bandwidth and offers better overall performance compared to static mounts via fstab</p>

<p><strong>autofs</strong> uses <strong>/etc/auto.master</strong> (master map) as its default primary configuration file.</p>

<h2 lass="mt-4">Auto-mounting an NFS share</h2>

<p>First Verify the NFS mount is accessiblle and available for mount </p>

<pre><code class="html">[root@]showmount -e 192.0.2.68
Export list for 192.0.2.68:
/mnt/nfsvol (everyone)
</code></pre>

<p>Install autofs </p>

<pre><code class="html">[root@]yum -y install autofs 
*       -rw     192.0.2.68:/mnt/nfsvol
</code></pre>

<h3 class="mt-4">Configuring user home directory in NFS share</h3>

<p>Edit the file <strong>/etc/auto.master</strong> and create an indirect maps</p>

<pre><code class="html">[root@]cat /etc/auto.master
/home      /etc/auto.home
</code></pre>

<p>Edit/create the file <strong>/etc/auto.home</strong> and add <strong>automount location</strong></p>

<pre><code class="html">[root@]cat /etc/auto.home
*       -rw     192.0.2.68:/mnt/nfsvol
</code></pre>

<p>Changes to the <strong>The Name Service Switch (NSS) configuration file</strong>, <code>/etc/nsswitch.conf</code>
<code>automount: files nis</code></p>

<p>start the <strong>autos</strong> service
<code>root@host-172-16-9-16 home]# systemctl start autofs</code></p>

<p>check the status of <strong>autofs</strong> service is running, you will be noticing <strong>lookup<em>nss</em>read_map: reading map file /etc/auto.home</strong></p>

<pre><code class="html">Jul 06 04:27:07 host-172-16-9-16 automount[20523]: master_do_mount: mounting /home
Jul 06 04:27:07 host-172-16-9-16 automount[20523]: automount_path_to_fifo: fifo name /run/autofs.fifo-home
Jul 06 04:27:07 host-172-16-9-16 automount[20523]: lookup_nss_read_map: reading map file /etc/auto.home
</code></pre>

<h2 class="mt-4">Testing</h2>

<p>Login to the client </p>

<pre><code class="html">[root@host-172-16-9-16 home]# ssh test@172.16.9.16
test@172.16.9.16's password: 
Last login: Fri Jul  6 04:23:36 2018 from host-172-16-9-16
</code></pre>

<p>Check the <code>pwd</code> of the user it's mounted to the <strong>/home</strong></p>

<pre><code class="html">-bash-4.2$ pwd
/home/test
-bash-4.2$ 
</code></pre>

<p>Check the <code>df -kh</code> the volume will be mounted</p>
<pre><code class="html">-bash-4.2$ df -kh 
Filesystem              Size  Used Avail Use% Mounted on
/dev/mapper/cl-root     6.2G  1.3G  5.0G  20% /
devtmpfs                908M     0  908M   0% /dev
tmpfs                   920M     0  920M   0% /dev/shm
tmpfs                   920M  8.5M  911M   1% /run
tmpfs                   920M     0  920M   0% /sys/fs/cgroup
/dev/vda1              1014M  181M  834M  18% /boot
tmpfs                   184M     0  184M   0% /run/user/0
192.0.2.68:/mnt/nfsvol  7.7G  128K  7.7G   1% /home/test
</code></pre>

<h2 class="mt-4">Troubleshooting Autofs</h2>

<p>Enable logging, To do this, edit the file <code>vi /etc/sysconfig/autofs</code> and <code>set LOGGING=debug</code> and <code>restart autofs</code> service </p>

<p>All log message will be redirected to <strong>/var/log/messages</strong></p>

<pre><code class="html">tail -f /var/log/messages
Jul  6 04:22:40 host-172-16-9-16 automount[20421]: mount_mount: mount(nfs): calling mkdir_path /home/test
Jul  6 04:22:40 host-172-16-9-16 automount[20421]: mount_mount: mount(nfs): calling mount -t nfs -s -o rw 192.0.2.68:/mnt/nfsvol /home/test
Jul  6 04:22:40 host-172-16-9-16 automount[20421]: spawn_mount: mtab link detected, passing -n to mount
Jul  6 04:22:40 host-172-16-9-16 automount[20421]: mount_mount: mount(nfs): mounted 192.0.2.68:/mnt/nfsvol on /home/test
Jul  6 04:22:40 host-172-16-9-16 automount[20421]: dev_ioctl_send_ready: token = 1
Jul  6 04:22:40 host-172-16-9-16 automount[20421]: mounted /home/test
</code></pre>

<p><strong>Running automount in the foreground with verbose information</strong>
<pre><code class="html">systemctl stop  autofs</code></pre>
Run automount in the foreground with verbose information
<code>sudo automount -f -v</code></p>

<hr>
<p><strong> Thanku for reading !!! Give a Share for Support</strong></p>
          <!-- Comments Form -->
    

          <!-- Single Comment -->
 

          <!-- Comment with nested comments -->
          

        </div>

        <!-- Sidebar Widgets Column -->
        <div class="col-md-4">

          <!-- Ad Widget -->
         <%@ include file="footer_adsense.jsp"%> 

          <!-- Article Widget -->
         <%@ include file="related-linux.jsp"%>
         
           <!-- Article Widget -->
         <%@ include file="related-ansible.jsp"%>
         
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