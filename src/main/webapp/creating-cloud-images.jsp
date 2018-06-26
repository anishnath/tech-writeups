<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Creating centos/rhel7 Cloud Images using qemu-img and virt-install">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>Creating centos/rhel7 Cloud Images using qemu-img and virt-install </title>

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
    "@id": "https://8gwifi.org/docs/creating-cloud-images.jsp"
  },
  "name" : "Creating centos/rhel7 Cloud Images using qemu-img and virt-install",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "Install the OpenStack command-line clients on Centos/Rhel/Fedora Like System",
  "image":"https://8gwifi.org/docs/img/boot.jpg",
  "datePublished" : "2018-06-26",
  "dateModified": "2018-06-26",
    "articleSection" : "Cloud Image Manual Creation",
  "articleBody" : [ "Install the CPU checker", "Check for <STRONG> kvm support", "Install the <STRONG> qemu-img and virt-install </STRONG> packages", "Verify <STRONG> Network is Active", "Download the Centos ISO image from <STRONG>centos7 Minimal image from  mirror site", "Create the <STRONG> qemu </STRONG> centos img example 3G", "qemu-img create -f qcow2 centos7-minimal-cloud.qcow2 3G", "Run the <STRONG> osinfo-query os  </STRONG> command to see a range of allowed <STRONG> --os-variant options", "Install the Centos7 using  <STRONG> virt-install", "Connect through the VNC server  VNC password can be found at", "Login to the System with the configured user", "Update the <STRONG> /etc/sysconfig/network-scripts/ifcfg-eth0 </STRONG> file so it only contains the following values", "Disable the  <STRONG> zeroconf </STRONG> route", "Configure the  <STRONG> Console </STRONG>  Edit the File <STRONG> /etc/default/grub </STRONG> and add the console tty", "Generate Grub Configuration file", "Install the ACPI service , cloud-init  &amp; cloud-utils-growpart", "ENable the ACPI service", "Poweroff the Machine", "Finally cleanup the Machine remove MAC address", "virt-sysprep -d centos" ]
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
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
      <div class="container">
        <a class="navbar-brand" href="#">8gwifi.org - Tech Blog</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav ml-auto">
            <li class="nav-item active">
              <a class="nav-link" href="#">Home
                <span class="sr-only">(current)</span>
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="https://8gwifi.org">Services</a>
            </li>
          </ul>
        </div>
      </div>
    </nav>

    <!-- Page Content -->
    <div class="container">

      <div class="row">

        <!-- Post Content Column -->
        <div class="col-lg-8">

          <!-- Title -->
          <h1 class="mt-4">Creating centos/rhel7 Cloud Images using qemu-img and virt-install </h1>

          <!-- Author -->
          <p class="lead">
            by
            <a href="https://www.linkedin.com/in/anishnath">Anish</a>
          </p>

          <hr>

          <!-- Date/Time -->
          <p>Posted on Monday June 26</p>

          <hr>

        
          <!-- Preview Image 
          <img class="img-fluid rounded" src="http://placehold.it/900x300" alt="">
          -->
           <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>

          <hr>

          <!-- Post Content -->
          <p class="lead">Cloud Image Manual Creation</p>

          <p><strong>Install the CPU checker</strong></p>
		  <pre><code class="html">sudo apt install cpu-checker</code></pre>

		  <p>Check for <strong> kvm support</strong></p>
		  
		  <pre><code class="html">sudo kvm-ok</code></pre>
		  <pre><code class="html">INFO: /dev/kvm exists
KVM acceleration can be used
</code></pre>

          <p>Install the <strong> qemu-img and virt-install </strong> packages </p>
          <pre><code class="html">yum -y install qemu-img virt-install</code></pre>
          
          <p> Verify <strong> Network is Active </strong>   </p>
          <pre><code class="html">virsh net-list</code></pre>
          <pre><code class="html"> Name                 State      Autostart     Persistent
----------------------------------------------------------
 default              active     yes           yes</code></pre>

 <p> If network is <strong> not </strong> Active then start it by doing:    </p>
 <pre><code class="html">virsh net-start default</code></pre>
 
  <p> Download the Centos ISO image from <strong>centos7 Minimal image from  mirror site  </strong>   </p>
  <pre><code class="html">wget http://centos.excellmedia.net/7/isos/x86_64/CentOS-7-x86_64-Minimal-1804.iso</code></pre>
  
  <p> Create the <strong> qemu </strong> centos img example 3G    </p>
  <pre><code class="html">qemu-img create -f qcow2 centos7-minimal-cloud.qcow2 3G</code></pre>
  <pre><code class="html">Formatting 'centos7-minimal-cloud.qcow2', fmt=qcow2 size=3221225472 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16</code></pre>
  
  <p> Run the <strong> osinfo-query os  </strong> command to see a range of allowed <strong> --os-variant options. </strong>   </p>
  <pre><code class="html">osinfo-query os | grep centos7
 centos7.0            | CentOS 7.0                                         | 7.0      | http://centos.org/centos/7.0
</code></pre>

<p>Install the Centos7 using  <strong> virt-install   </strong>   </p>
<pre><code class="html">virt-install --virt-type kvm --name centos7-minimal-cloud --ram 2048 --cdrom CentOS-7-x86_64-Minimal-1804.iso --disk centos7-minimal-cloud.qcow2,format=qcow2 --network=bridge:virbr0 --graphics vnc,listen=0.0.0.0 --wait=-1  --noautoconsole --os-type=linux --os-variant=centos7.0 --noreboot</code></pre>
<pre><code class="html">Starting install...
Creating domain...                                                                                                       |    0 B  00:00:02     
Domain installation still in progress. Waiting for installation to complete.
</code></pre>
<hr>

<p> Connect through the VNC server  VNC password can be found at .</p>
<pre><code class="html">cat /etc/libvirt/qemu.conf | grep vnc_password
vnc_password = "XYZ12345"
</code></pre>
<p> Install Centos7 .</p>
<p><img alt="" src="img/boot.png"></img></p>
<p> Verify Installation Destinations .</p>
<p><img alt="" src="img/boot1.png"></img></p>
<p> Create Necessary Users .</p>
<p><img alt="" src="img/boot2.png"></img></p>
<p> Reboot the Server When Prompted .</p>
<p><img alt="" src="img/boot3.png"></img></p>
<p> After the reboot check the console. it will display the below messages</p>
<pre><code class="html">Domain creation completed.
You can restart your domain by running:
virsh --connect qemu:///system start centos7-minimal-cloud</code></pre>
<p> Re-Connect to the VNC </p>
<pre><code class="html">virsh --connect qemu:///system start centos7-minimal-cloud</code></pre>

<p> Login to the System with the configured user </p>
<hr>
<p> Update the <strong> /etc/sysconfig/network-scripts/ifcfg-eth0 </strong> file so it only contains the following values </p>
<pre><code class="html">cat /etc/sysconfig/network-scripts/ifcfg-eth0 
TYPE=Ethernet
DEVICE=eth0
ONBOOT=yes
BOOTPROTO=dhcp
NM_CONTROLLED=no
</code></pre>
<p>Disable the  <strong> zeroconf </strong> route </p>
<pre><code class="html">echo "NOZEROCONF=yes" >> /etc/sysconfig/network</code></pre>

<p>Configure the  <strong> Console </strong>  Edit the File <strong> /etc/default/grub </strong> and add the console tty  </p>
<pre><code class="html">GRUB_CMDLINE_LINUX="crashkernel=auto rd.lvm.lv=cl/root rd.lvm.lv=cl/swap console=tty0 console=ttyS0,115200n8"</code></pre>

<p>Generate Grub Configuration file </p>
<pre><code class="html"></code>grub2-mkconfig -o /boot/grub2/grub.cfg</pre>
<pre><code class="html"></code>Generating grub configuration file ...
Found linux image: /boot/vmlinuz-3.10.0-514.el7.x86_64
Found initrd image: /boot/initramfs-3.10.0-514.el7.x86_64.img
Found linux image: /boot/vmlinuz-0-rescue-c1b5666cc6334b14bfcf1f9b18bd1e4a
Found initrd image: /boot/initramfs-0-rescue-c1b5666cc6334b14bfcf1f9b18bd1e4a.img
Done
</code></pre>
<hr>
<p>Install the ACPI service , cloud-init  & cloud-utils-growpart </p>
<pre><code class="html">yum -y  install acpid cloud-init cloud-utils-growpart</code></pre>

<p>ENable the ACPI service </p>
<pre><code class="html">systemctl enable acpid</code></pre>

<p> Poweroff the Machine </p>
<pre><code class="html">poweroff</code></pre>

<p>Finally cleanup the Machine remove MAC address </p>
<pre><code class="html">virt-sysprep -d centos</code></pre>

<pre><code class="html">[   0.0] Examining the guest ...
[  38.0] Performing "abrt-data" ...
[  38.0] Performing "bash-history" ...
[  38.0] Performing "blkid-tab" ...
[  38.0] Performing "crash-data" ...
[  38.0] Performing "cron-spool" ...
[  38.0] Performing "dhcp-client-state" ...
[  38.0] Performing "dhcp-server-state" ...
[  38.0] Performing "dovecot-data" ...
[  38.0] Performing "logfiles" ...
[  38.1] Performing "machine-id" ...
[  38.1] Performing "mail-spool" ...
[  38.1] Performing "net-hostname" ...
[  38.1] Performing "net-hwaddr" ...
[  38.1] Performing "pacct-log" ...
[  38.1] Performing "package-manager-cache" ...
[  38.1] Performing "pam-data" ...
[  38.1] Performing "puppet-data-log" ...
[  38.1] Performing "rh-subscription-manager" ...
[  38.1] Performing "rhn-systemid" ...
[  38.1] Performing "rpm-db" ...
[  38.1] Performing "samba-db-log" ...
[  38.1] Performing "script" ...
[  38.1] Performing "smolt-uuid" ...
[  38.1] Performing "ssh-hostkeys" ...
[  38.1] Performing "ssh-userdir" ...
[  38.2] Performing "sssd-db-log" ...
[  38.2] Performing "tmp-files" ...
[  38.2] Performing "udev-persistent-net" ...
[  38.2] Performing "utmp" ...
[  38.2] Performing "yum-uuid" ...
[  38.2] Performing "customize" ...
[  38.2] Setting a random seed
[  38.5] Performing "lvm-uuids" ...</code></pre>

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