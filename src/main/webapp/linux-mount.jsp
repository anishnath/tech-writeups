<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="Linux mount/unmout,mount remote file system, make a mount,  linux device type">
<meta name="keywords"content="linux mount command,linux unmout command, making a mount point, remote mount, mount nfs share, linux interview questions,sshfs mount">
<meta name="author" content="Anish nath">
<meta name="robots" content="index,follow" />
<meta name="googlebot" content="index,follow" />
<meta name="resource-type" content="document" />
<meta name="classification" content="tools" />
<meta name="language" content="en" />

<title>Linux mount/unmout,mount remote file system, make a mount, device type, mount nfs, mount sshfs</title>

<!-- Bootstrap core CSS -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/blog-post.css" rel="stylesheet">

<link rel="stylesheet" href="css/highlight/default.min.css">
<script src="css/highlight/highlight.min.js"></script>
<script>
	hljs.initHighlightingOnLoad();
</script>


<!-- JSON-LD markup generated by Google Structured Data Markup Helper. -->
<script type="application/ld+json">
{
  "@context" : "http://schema.org",
  "@type" : "Article",
  "mainEntityOfPage": {
    "@type": "WebPage",
    "@id": "https://8gwifi.org/docs/linux-mount.jsp"
  },
  "name" : "Linux mount/unmout,mount remote file system, make a mount, device type, mount nfs, mount sshfs",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "Linux mount/unmout,mount remote file system, make a mount, device type, mount nfs, mount sshfs",
  "image":"linux-mount.png",
  "datePublished" : "2018-12-21",
  "dateModified": "2018-12-21",
  "articleSection" : "Lets Visit Linux Mount and Unmount Again",
  "articleBody" : [ "Windows Device type","Linux Device type", "lsblk displays block devices", "The basic mount option", "o mount the CDROM at device /dev/cdrom", "The unmount command", "Mounting the Remote File System", "How to Make a Mount Point" , "Device Names"],
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
				<h1 class="mt-4">Let's Visit Linux Mount and Unmount Again</h1>

				<!-- Author -->
				<p class="lead">
					by <a href="https://www.linkedin.com/in/anishnath">Anish</a>
				</p>

				<hr>

				<!-- Date/Time -->
				<p>Posted on Friday December 21</p>

				<hr>



				<!-- <img class="img-fluid rounded" src="img/linux-ps-monitor.gif"alt="Referefce 8gwifi.org"> -->

				<%@ include file="footer_adsense.jsp"%>
				<%@ include file="analytics.jsp"%>

				<hr>
					<h2 class="mt-4"> mount - mount a filesystem</h2>

				<p>By default, the mount command displays a list of media devices currently mounted on the system:</p>
<pre><code class="html">$ sudo mount
sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)
udev on /dev type devtmpfs (rw,nosuid,relatime,size=2002872k,nr_inodes=500718,mode=755)
tmpfs on /dev/shm type tmpfs (rw,nosuid,nodev)
/dev/vda1 on /boot type ext2 (rw,relatime,block_validity,barrier,user_xattr,acl)
/dev/mapper/ubuntu--vg-root on / type ext4 (rw,relatime,errors=remount-ro,data=ordered)
.....
.....
</code></pre>
<p>The <code>mount</code> command provides four  information:</p>
<ul>
<li>The device filename of the media</li>
<li>The mount point in the virtual directory where the media is mounted</li>
<li>The filesystem type</li>
<li>The access status of the mounted media</li>
</ul>
<p>The basic mount option</p>
<pre><code class="html">mount -t type device directory
</code></pre>
<p><strong>Windows Device type</strong></p>
<table class="table table-striped table-bordered">
<thead>
<tr>
<th>OS</th>
<th>File Systems</th>
</tr>
</thead>
<tbody>
<tr>
<td>Windows</td>
<td>vfat,ntfs,iso9660</td>
</tr>
</tbody>
</table>
<p><strong>Linux Device type</strong></p>
<p><strong>lsblk</strong> displays block devices</p>
<pre><code class="html">$ lsblk -f
NAME  FSTYPE  LABEL UUID MOUNTPOINT
vda
 vda1  ext2  eb311fb6-841d-4220-9994-046ff3b46721 /boot
 vda2
 vda5  LVM2_member Gx5XbE-coCx-2c9e-XuP3-qD7T-R8GR-0k0nwV
 ubuntu--vg-root ext4  e2a78946-d108-438c-ac8c-4b003f74ae64 /
 ubuntu--vg-swap_1 swap  710191d7-7abd-4fb7-b4d9-eae243cd6077 [SWAP]
</code></pre>
<p>To mount the USB memory stick at device <strong>/dev/sdb1</strong> at location <strong>/media/disk</strong>, you use the following command:</p>
<pre><code class="html">mount -t vfat /dev/sdb1 /media/disk
</code></pre>
<p>To mount the CDROM  at device <strong>/dev/cdrom</strong> at location <strong>/mnt/disk</strong>, you use the following command:</p>
<pre><code class="html">mount /dev/cdrom /mnt/cdrom
</code></pre>
<p>mount Command options</p>
<table class="table table-striped table-bordered">
<thead>
<tr>
<th>Parameter</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>-a</td>
<td>All the filesystems listed via getfsent(3) are mounted</td>
</tr>
<tr>
<td>-d</td>
<td>Causes everything to be done except for the actual system call</td>
</tr>
<tr>
<td>-f</td>
<td>Causes the mount command to simulate mounting a device, but not actually
mount it</td>
</tr>
<tr>
<td>-s</td>
<td>Ignores mount options not supported by the filesystem</td>
</tr>
<tr>
<td>-o</td>
<td>async,force,noasync,noauto,nodev,noexec,noowners,nosuid,rdonly,sync,update,union,noatime,nobrowse <code>mount -t hfs -o nosuid,-w,-m=755 /dev/disk2s9 /tmp</code></td>
</tr>
<tr>
<td><strong>-r</strong></td>
<td>Mount the file system read-only</td>
</tr>
</tbody>
</table>
<p>mounts all filesystems except those of type NFS and HFS.</p>
<pre><code class="html">mount -a -t nonfs,hfs
</code></pre>
<p>mounts NFS share</p>
<pre><code class="html">mount -t nfs ip_address:/dirname /mnt/localdiskname
</code></pre>
<h2><a id="The_unmount_command_80"></a>The unmount command</h2>
<p>To remove a removable media device, you should never just remove it from the system. Instead, you should always unmount it first</p>
<pre><code class="html">umount [directory | device ]
</code></pre>
<p>To unmount the data directory</p>
<pre><code class="html">sudo umount /data
</code></pre>
<p>If any program has a fi le open on a device, the system won't let you unmount it.</p>
<pre><code class="html">$  umount /data
umount: /data: device is busy 
umount: /data: device is busy
</code></pre>
<hr>
<h2><a id="remotefilesystemmount"></a>Mounting the Remote File System</h2>
<p>SSHFS is Linux based software that needs to be installed on your local computer</p>
<pre><code class="html">sudo mkdir /data
sudo chown user:group /data
sudo sshfs -o allow_other,defer_permissions root@<IP_ADDR>:/ /mnt/data
or for Key Based
sudo sshfs -o allow_other,defer_permissions,IdentityFile=~/.ssh/id_rsa root@<IP_ADDR>:/ /mnt/data
</code></pre>
<h2><a id="How_to_Make_a_Mount_Point_98"></a>How to Make a Mount Point</h2>
<p>A mount point is "just" a directory. So all you need to do is to create a directory, then mount it, the only <mark>tricky part is the device name </mark>which you are mounting</p>
<pre><code class="html">mkdir /data
chown user:group /data
mount /dev/sdb1 /data
</code></pre>
<ul>
<li>/dev/sda - <strong>raw</strong> device</li>
<li>/dev/sda1 - <strong>virtual</strong> device, like a partition</li>
</ul>


<hr>
<h2><a id="devicenames"></a>Device Names</h2>

				<p>
					<strong>IDE controller naming convention</strong>
				</p>
				<table class="table table-striped table-bordered">
					<tbody>
						<tr>
							<td>drive name</td>
							<td>drive
								controller</td>
							<td>drive number</td>
						</tr>
						<tr>
							<td>/dev/hda</td>
							<td>1</td>
							<td>1</td>
						</tr>
						<tr>
							<td>/dev/hdb</td>
							<td>1</td>
							<td>2</td>
						</tr>
						<tr>
							<td>/dev/hdc</td>
							<td>2</td>
							<td>1</td>
						</tr>
						<tr>
							<td>/dev/hdd</td>
							<td>2</td>
							<td>2</td>
						</tr>
					</tbody>
				</table>
				<p>
					<strong>partition names</strong>

				</p>
				<table class="table table-striped table-bordered">
					<tbody>
						<tr>
							<td>drive name</td>
							<td>drive
								controller</td>
							<td>drive number</td>
							<td>partition
								type</td>
							<td>partition
								number</td>
						</tr>
						<tr>
							<td>/dev/hda1</td>
							<td>1</td>
							<td>1</td>
							<td>primary</td>
							<td>1</td>
						</tr>
						<tr>
							<td>/dev/hda2</td>
							<td>1</td>
							<td>1</td>
							<td>primary</td>
							<td>2</td>
						</tr>
						<tr>
							<td>/dev/hda3</td>
							<td>1</td>
							<td>1</td>
							<td>primary</td>
							<td>3</td>
						</tr>
						<tr>
							<td>/dev/hda4</td>
							<td>1</td>
							<td>1</td>
							<td>swap</td>
							<td>NA</td>
						</tr>
						<tr>
							<td>/dev/hdb1</td>
							<td>1</td>
							<td>2</td>
							<td>primary</td>
							<td>1</td>
						</tr>
						<tr>
							<td>/dev/hdb2</td>
							<td>1</td>
							<td>2</td>
							<td>primary</td>
							<td>2</td>
						</tr>
						<tr>
							<td>/dev/hdb3</td>
							<td>1</td>
							<td>2</td>
							<td>primary</td>
							<td>3</td>
						</tr>
						<tr>
							<td>/dev/hdb4</td>
							<td>1</td>
							<td>2</td>
							<td>primary</td>
							<td>4</td>
						</tr>
					</tbody>
				</table>

				<p>
					<strong>SCSI Drives</strong>
				</p>

				<table class="table table-striped table-bordered">
					<tbody>
						<tr>
							<td>drive name</td>
							<td>drive
								controller</td>
							<td>drive number</td>
							<td>partition
								type</td>
							<td>partition
								number</td>
						</tr>
						<tr>
							<td>/dev/sda1</td>
							<td>1</td>
							<td>6</td>
							<td>primary</td>
							<td>1</td>
						</tr>
						<tr>
							<td>/dev/sda2</td>
							<td>1</td>
							<td>6</td>
							<td>primary</td>
							<td>2</td>
						</tr>
						<tr>
							<td>/dev/sda3</td>
							<td>1</td>
							<td>6</td>
							<td>primary</td>
							<td>3</td>
						</tr>
					</tbody>
				</table>

				<p>
					Next Reading : <a href="linux-monitor-commands.jsp">How to
						Monitoring All Executed Commands in Linux </a>
				</p>

				<hr>
				<%@ include file="thanks.jsp"%>
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

				<%@ include file="related-kube.jsp"%>

				<%@ include file="related-openstack.jsp"%>

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
			<p class="m-0 text-center text-white">Copyright &copy; 8gwifi.org
				2018</p>
		</div>
		<!-- /.container -->
	</footer>

	 <!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>