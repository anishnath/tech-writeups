<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="container runtime introduction runc,containerd,rkt,docker,cri">
<meta name="keywords"content="container runtime, runc tutorials, rkt tutorials, what is rkt,frakti,CRI-O,runc, low level container runtime, high level container runtime">
<meta name="author" content="Anish nath">
<meta name="robots" content="index,follow" />
<meta name="googlebot" content="index,follow" />
<meta name="resource-type" content="document" />
<meta name="classification" content="tools" />
<meta name="language" content="en" />

<title>container runtime introduction runc,containerd,rkt,docker,cri</title>

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
    "@id": "https://8gwifi.org/docs/containers.jsp"
  },
  "name" : "container runtime introduction runc,containerd,rkt,docker,cri",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "container runtime introduction runc,containerd,rkt,docker,cri",
  "image":"https://8gwifi.org/docs/img/container.png",
  "datePublished" : "2019-11-04",
  "dateModified": "2019-11-04",
  "articleSection" : "container runtime introduction runc,containerd,rkt,docker,cri",
  "articleBody" : [ "Container Runtime","Low level container runtime" , "High Level container runtime" ,"RunC" , "Creating nginx OCI Bundle", "Rootless containers" , "CRI containerd" , "RKT" , "How to install RKT" ],
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
				<h1 class="mt-4">container runtime runc,containerd,rkt,docker,cri</h1>

				<!-- Author -->
				<p class="lead">
					by <a href="https://www.linkedin.com/in/anishnath">Anish</a>
				</p>

				<hr>

				<!-- Date/Time -->
				<p>Posted on Monday November 04-2019</p>

				<hr>



				<img class="img-fluid rounded" src="img/container.png"alt="Referefce 8gwifi.org">

				<%@ include file="footer_adsense.jsp"%>
				<%@ include file="analytics.jsp"%>

				<hr>

<p class="has-line-data" data-line-start="1" data-line-end="2">To run containers in Pods, we need to uses a container runtime. Here various runtimes by popularity (The popularity measured ny number of questions posted in stackoverflow.)</p>
<ul>
<li class="has-line-data" data-line-start="3" data-line-end="4"><strong><a href="https://www.docker.com/">Docker</a></strong> : The most popular container runtime needs no Introduction</li>
<li class="has-line-data" data-line-start="4" data-line-end="5"><strong><a href="https://linuxcontainers.org/">lxc</a></strong> : LXC is the well known set of tools, templates, library and language bindings. It's pretty low level, very flexible and covers just about every containment feature supported by the upstream kernel.</li>
<li class="has-line-data" data-line-start="5" data-line-end="6"><strong><a href="https://github.com/containerd/containerd">containerd</a></strong></li>
<li class="has-line-data" data-line-start="6" data-line-end="7"><strong><a href="https://github.com/opencontainers/runc">runc</a></strong> : RunC is a container runtime originally developed as part of Docker and later extracted out as a separate open source tool and library. Gaining Popularity day-by-day</li>
<li class="has-line-data" data-line-start="7" data-line-end="8"><strong><a href="https://cri-o.io/">CRI-O</a></strong> : Lightweight container runtime for kubernetes</li>
<li class="has-line-data" data-line-start="8" data-line-end="9"><strong><a href="https://github.com/kubernetes/frakti">frakti</a></strong> : The hypervisor-based container runtime for Kubernetes.</li>
<li class="has-line-data" data-line-start="9" data-line-end="11"><strong><a href="https://coreos.com/rkt/">rkt</a></strong> : CoreOS application container engine developed for modern production cloud-native environments</li>
</ul>
<p class="has-line-data" data-line-start="11" data-line-end="12">Too many container runtime means to many standard to follow and developers/maintainer will have hard time to maintain it across the Infrastructure.</p>
<p class="has-line-data" data-line-start="13" data-line-end="14">This opportunity has given birth to <a href="https://www.opencontainers.org/">Open Container Initiative (OCI)</a>.  There are currently two specifications in development and in use: Runtime Specification (runtime-spec) and the Image Specification (image-spec).</p>
<p class="has-line-data" data-line-start="15" data-line-end="16">Well coming back to  <code>containers runtime</code> Let's break this in two parts</p>
<ul>
<li class="has-line-data" data-line-start="17" data-line-end="18"><strong>Low level container runtime</strong> :   This involves running a specialized tool that configures the kernel to run the container like <a href="https://github.com/opencontainers/runc">runc</a>,<a href="https://coreos.com/rkt/">rkt</a></li>
<li class="has-line-data" data-line-start="18" data-line-end="19"><strong>High Level container runtime</strong> :  like <a href="https://www.docker.com/">Docker</a>, <a href="https://github.com/kubernetes-incubator/cri-o">CRI-O</a>,  <a href="https://containerd.io/">containerd</a> and come with developer functionality. They are API driven.</li>
</ul>
<h2 class="code-line" data-line-start=21 data-line-end=22 ><a id="RunC_21"></a>RunC</h2>
<p class="has-line-data" data-line-start="23" data-line-end="24"><a href="https://github.com/opencontainers/runc">runC</a> is a low-level container runtime and an implementation of the <a href="https://github.com/opencontainers/specs">Open Container Initiative specification</a>. runC exposes and expects a user to understand low-level details of the host operating system and configuration. runC does not have a centralized daemon, and, given a properly configured “OCI bundle”, can be integrated with init systems such as upstart and systemd</p>
<p class="has-line-data" data-line-start="25" data-line-end="26">In order to use <strong><code>runc</code></strong> you must have your container in the format of an OCI bundle. If you have <code>Docker</code> installed you can use its <code>export</code> method to acquire a root filesystem from an existing Docker container.</p>
<p class="has-line-data" data-line-start="27" data-line-end="28"><strong>Example</strong>: Creating nginx OCI Bundle</p>
<ul>
<li class="has-line-data" data-line-start="29" data-line-end="30">To Create an OCI bundle we need root filesystem</li>
<li class="has-line-data" data-line-start="30" data-line-end="31">Once rootfs is downloaded or extracted from existing image, <strong><code>runc</code></strong>  provides a <code>spec</code> command to generate a base template spec  name <code>config.json</code></li>
</ul>
<p class="has-line-data" data-line-start="33" data-line-end="34">First Get <code>runc</code></p>
<p class="has-line-data" data-line-start="35" data-line-end="36">For Fedora/Centos7+/RHEL7.5+</p>
<pre><code class="html">yum -y install runc
</code></pre>
<p class="has-line-data" data-line-start="40" data-line-end="41">Once <code>runc</code> is installed create root file system, In this example <strong>nginx</strong> rootfs is extracted using the <code>docker</code> command</p>
<pre><code class="html">[root@localhost ~]# mkdir nginx
[root@localhost ~]# cd nginx/
[root@localhost nginx]# mkdir rootfs
[root@localhost nginx]# docker export $(docker create nginx) | tar -C rootfs -xvf -
</code></pre>
<p class="has-line-data" data-line-start="50" data-line-end="51">Generate the spec file.</p>
<pre><code class="html">[root@localhost nginx]# runc spec
</code></pre>
<p class="has-line-data" data-line-start="56" data-line-end="57">After successfull run of the above command  <code>config.json</code> is created.</p>
<pre><code class="html">[root@localhost nginx]# ls -ltr 
total 4
drwxr-xr-x. 21 root root  242 Oct 31 06:57 rootfs
-rw-r--r--.  1 root root 2618 Oct 31 06:58 config.json
</code></pre>
<p class="has-line-data" data-line-start="65" data-line-end="66">Content of the <code>config.json</code> file</p>
<p class="has-line-data" data-line-start="68" data-line-end="69">OCI version, operating system and architecture, and terminal settings:</p>
<pre><code class="html">[root@localhost nginx]# cat config.json 
{
    &quot;ociVersion&quot;: &quot;1.0.1-dev&quot;,
    &quot;process&quot;: {
        &quot;terminal&quot;: true,
        &quot;user&quot;: {
            &quot;uid&quot;: 0,
            &quot;gid&quot;: 0
        },
        &quot;args&quot;: [
            &quot;sh&quot;
        ],
        &quot;env&quot;: [
            &quot;PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin&quot;,
            &quot;TERM=xterm&quot;
        ],
        &quot;cwd&quot;: &quot;/&quot;,
</code></pre>
<p class="has-line-data" data-line-start="89" data-line-end="90">Next we have <a href="http://man7.org/linux/man-pages/man7/capabilities.7.html">capabilities</a>, which are permissions for executable files in given subsystems that lack root permissions</p>
<pre><code class="html">        &quot;capabilities&quot;: {
            &quot;bounding&quot;: [
                &quot;CAP_AUDIT_WRITE&quot;,
                &quot;CAP_KILL&quot;,
                &quot;CAP_NET_BIND_SERVICE&quot;
            ],
            &quot;effective&quot;: [
                &quot;CAP_AUDIT_WRITE&quot;,
                &quot;CAP_KILL&quot;,
                &quot;CAP_NET_BIND_SERVICE&quot;
            ],
            &quot;inheritable&quot;: [
                &quot;CAP_AUDIT_WRITE&quot;,
                &quot;CAP_KILL&quot;,
                &quot;CAP_NET_BIND_SERVICE&quot;
            ],
            &quot;permitted&quot;: [
                &quot;CAP_AUDIT_WRITE&quot;,
                &quot;CAP_KILL&quot;,
                &quot;CAP_NET_BIND_SERVICE&quot;
            ],
            &quot;ambient&quot;: [
                &quot;CAP_AUDIT_WRITE&quot;,
                &quot;CAP_KILL&quot;,
                &quot;CAP_NET_BIND_SERVICE&quot;
            ]
        },
</code></pre>
<p class="has-line-data" data-line-start="119" data-line-end="120">Next we have resource Limits with hard and soft limits configured.</p>
<pre><code class="html">        &quot;rlimits&quot;: [
            {
                &quot;type&quot;: &quot;RLIMIT_NOFILE&quot;,
                &quot;hard&quot;: 1024,
                &quot;soft&quot;: 1024
            }
        ],
        &quot;noNewPrivileges&quot;: true
    },
</code></pre>
<p class="has-line-data" data-line-start="132" data-line-end="133">RootFS</p>
<pre><code class="html">    &quot;root&quot;: {
        &quot;path&quot;: &quot;rootfs&quot;,
        &quot;readonly&quot;: true
    },
    &quot;hostname&quot;: &quot;runc&quot;,
    &quot;mounts&quot;: [
        {
            &quot;destination&quot;: &quot;/proc&quot;,
            &quot;type&quot;: &quot;proc&quot;,
            &quot;source&quot;: &quot;proc&quot;
        },
        {
            &quot;destination&quot;: &quot;/dev&quot;,
            &quot;type&quot;: &quot;tmpfs&quot;,
            &quot;source&quot;: &quot;tmpfs&quot;,
            &quot;options&quot;: [
                &quot;nosuid&quot;,
                &quot;strictatime&quot;,
                &quot;mode=755&quot;,
                &quot;size=65536k&quot;
            ]
        },
        {
            &quot;destination&quot;: &quot;/dev/pts&quot;,
            &quot;type&quot;: &quot;devpts&quot;,
            &quot;source&quot;: &quot;devpts&quot;,
            &quot;options&quot;: [
                &quot;nosuid&quot;,
                &quot;noexec&quot;,
                &quot;newinstance&quot;,
                &quot;ptmxmode=0666&quot;,
                &quot;mode=0620&quot;,
                &quot;gid=5&quot;
            ]
        },
        {
            &quot;destination&quot;: &quot;/dev/shm&quot;,
            &quot;type&quot;: &quot;tmpfs&quot;,
            &quot;source&quot;: &quot;shm&quot;,
            &quot;options&quot;: [
                &quot;nosuid&quot;,
                &quot;noexec&quot;,
                &quot;nodev&quot;,
                &quot;mode=1777&quot;,
                &quot;size=65536k&quot;
            ]
        },
        {
            &quot;destination&quot;: &quot;/dev/mqueue&quot;,
            &quot;type&quot;: &quot;mqueue&quot;,
            &quot;source&quot;: &quot;mqueue&quot;,
            &quot;options&quot;: [
                &quot;nosuid&quot;,
                &quot;noexec&quot;,
                &quot;nodev&quot;
            ]
        },
        {
            &quot;destination&quot;: &quot;/sys&quot;,
            &quot;type&quot;: &quot;sysfs&quot;,
            &quot;source&quot;: &quot;sysfs&quot;,
            &quot;options&quot;: [
                &quot;nosuid&quot;,
                &quot;noexec&quot;,
                &quot;nodev&quot;,
                &quot;ro&quot;
            ]
        },
        {
            &quot;destination&quot;: &quot;/sys/fs/cgroup&quot;,
            &quot;type&quot;: &quot;cgroup&quot;,
            &quot;source&quot;: &quot;cgroup&quot;,
            &quot;options&quot;: [
                &quot;nosuid&quot;,
                &quot;noexec&quot;,
                &quot;nodev&quot;,
                &quot;relatime&quot;,
                &quot;ro&quot;
            ]
        }
    ],
</code></pre>
<p class="has-line-data" data-line-start="217" data-line-end="218">Next We have Linux FS,resources, namespaces masked PATHS</p>
<pre><code class="html">    &quot;linux&quot;: {
        &quot;resources&quot;: {
            &quot;devices&quot;: [
                {
                    &quot;allow&quot;: false,
                    &quot;access&quot;: &quot;rwm&quot;
                }
            ]
        },
        &quot;namespaces&quot;: [
            {
                &quot;type&quot;: &quot;pid&quot;
            },
            {
                &quot;type&quot;: &quot;network&quot;
            },
            {
                &quot;type&quot;: &quot;ipc&quot;
            },
            {
                &quot;type&quot;: &quot;uts&quot;
            },
            {
                &quot;type&quot;: &quot;mount&quot;
            }
        ],
        &quot;maskedPaths&quot;: [
            &quot;/proc/kcore&quot;,
            &quot;/proc/latency_stats&quot;,
            &quot;/proc/timer_list&quot;,
            &quot;/proc/timer_stats&quot;,
            &quot;/proc/sched_debug&quot;,
            &quot;/sys/firmware&quot;,
            &quot;/proc/scsi&quot;
        ],
        &quot;readonlyPaths&quot;: [
            &quot;/proc/asound&quot;,
            &quot;/proc/bus&quot;,
            &quot;/proc/fs&quot;,
            &quot;/proc/irq&quot;,
            &quot;/proc/sys&quot;,
            &quot;/proc/sysrq-trigger&quot;
        ]
    }
}
</code></pre>
<p class="has-line-data" data-line-start="266" data-line-end="267"><strong>Running Containers</strong></p>
<p class="has-line-data" data-line-start="268" data-line-end="269">To run the container use <code>runc run mycontainerid</code></p>
<p class="has-line-data" data-line-start="270" data-line-end="271">For example</p>
<pre><code class="html">[root@localhost nginx]# runc run nginx
# pwd
/
</code></pre>
<p class="has-line-data" data-line-start="277" data-line-end="278"><strong>Managing Lifecycle</strong></p>
<p class="has-line-data" data-line-start="279" data-line-end="280">This can be achieved by modifying config.json file and setting process <code>&quot;terminal&quot;: true</code></p>
<ul>
<li class="has-line-data" data-line-start="282" data-line-end="283">Create Container</li>
</ul>
<pre><code class="html">cd nginx
runc create nginx
</code></pre>
<ul>
<li class="has-line-data" data-line-start="288" data-line-end="289">View Container</li>
</ul>
<pre><code class="html"># view the container is created and in the &quot;created&quot; state
runc list
</code></pre>
<ul>
<li class="has-line-data" data-line-start="294" data-line-end="295">List Container</li>
</ul>
<pre><code class="html">[root@localhost nginx]# runc list
ID          PID         STATUS      BUNDLE        CREATED                          OWNER
nginx       5677        created     /root/nginx   2019-10-31T11:28:12.529241754Z   root
</code></pre>
<ul>
<li class="has-line-data" data-line-start="301" data-line-end="302">Start Container</li>
</ul>
<pre><code class="html"># start the process inside the container
runc start nginx
</code></pre>
<pre><code class="html">[root@localhost nginx]# runc list
ID          PID         STATUS      BUNDLE        CREATED                          OWNER
nginx       5677        running     /root/nginx   2019-10-31T11:28:12.529241754Z   root
</code></pre>
<ul>
<li class="has-line-data" data-line-start="314" data-line-end="316">Pause the container</li>
</ul>
<pre><code class="html"> runc pause nginx
</code></pre>
<pre><code class="html">[root@localhost nginx]# runc list
ID          PID         STATUS      BUNDLE        CREATED                          OWNER
nginx       5677        paused      /root/nginx   2019-10-31T11:28:12.529241754Z   root
</code></pre>
<ul>
<li class="has-line-data" data-line-start="325" data-line-end="327">Resume the container</li>
</ul>
<pre><code class="html">[root@localhost nginx]# runc resume nginx
[root@localhost nginx]# runc list
ID          PID         STATUS      BUNDLE        CREATED                          OWNER
nginx       5677        running     /root/nginx   2019-10-31T11:28:12.529241754Z   root
</code></pre>
<ul>
<li class="has-line-data" data-line-start="334" data-line-end="336">state of the Container</li>
</ul>
<pre><code class="html">[root@localhost nginx]# runc state nginx
{
&quot;ociVersion&quot;: &quot;1.0.1-dev&quot;,
&quot;id&quot;: &quot;nginx&quot;,
&quot;pid&quot;: 5677,
&quot;status&quot;: &quot;running&quot;,
&quot;bundle&quot;: &quot;/root/nginx&quot;,
&quot;rootfs&quot;: &quot;/root/nginx/rootfs&quot;,
&quot;created&quot;: &quot;2019-10-31T11:28:12.529241754Z&quot;,
&quot;owner&quot;: &quot;&quot;
}
</code></pre>
<ul>
<li class="has-line-data" data-line-start="350" data-line-end="352">delete the container</li>
</ul>
<pre><code class="html">runc stop nginx
runc delete nginx
</code></pre>
<p class="has-line-data" data-line-start="357" data-line-end="358"><strong>Rootless containers</strong></p>
<p class="has-line-data" data-line-start="359" data-line-end="360"><code>runc</code> has the ability to run containers without root privileges. This is called <code>rootless</code>. The <code>--rootless</code> parameter instructs runc spec to generate a configuration for a rootless container, which will allow you to run the container as a <strong>non-root</strong> user.</p>
<p class="has-line-data" data-line-start="361" data-line-end="362"><img class="img-fluid rounded" src="img/rootless.png" alt="Difference root vs rootless "></p>
<hr>
<%@ include file="footer_adsense.jsp"%>
<h2 class="code-line" data-line-start=366 data-line-end=367 ><a id="CRI_containerd_366"></a>CRI containerd</h2>
<p class="has-line-data" data-line-start="368" data-line-end="369"><a href="https://containerd.tools/">containerd</a> is a daemon to control <a href="https://github.com/opencontainers/runc">runC</a>. It has a command-line tool called <code>ctr</code> which is used to interact with the containerd daemon. This makes the containerd process model similar to that of the Docker process model</p>
<p class="has-line-data" data-line-start="370" data-line-end="371"><strong>CRI</strong> is Containerd Plugin for Kubernetes Container Runtime Interface</p>
<p class="has-line-data" data-line-start="372" data-line-end="373">To Install CRI containerd in Centos7/Fedora Like system</p>
<pre><code class="html">yum -y install libseccomp
wget https://storage.googleapis.com/cri-containerd-release/cri-containerd-1.2.4.linux-amd64.tar.gz
tar --no-overwrite-dir -C / -xzf cri-containerd-1.2.4.linux-amd64.tar.gz
systemctl start containerd
</code></pre>
<p class="has-line-data" data-line-start="380" data-line-end="381">Check the status</p>
<pre><code class="html">[root@localhost ~]# systemctl status containerd
● containerd.service - containerd container runtime
   Loaded: loaded (/etc/systemd/system/containerd.service; disabled; vendor preset: disabled)
   Active: active (running) since Sun 2019-11-03 11:09:59 EST; 5s ago
     Docs: https://containerd.io
  Process: 1696 ExecStartPre=/sbin/modprobe overlay (code=exited, status=0/SUCCESS)
 Main PID: 1701 (containerd)
    Tasks: 9
   Memory: 17.4M
   CGroup: /system.slice/containerd.service
           └─1701 /usr/local/bin/containerd

Nov 03 11:10:00 localhost.localdomain containerd[1701]: time=&quot;2019-11-03T11:10:00.273591789-05:00&quot; level=info msg=&quot;Connect contain...rvice&quot;
</code></pre>
<p class="has-line-data" data-line-start="397" data-line-end="398">Follow <a href="https://kubernetes.io/docs/setup/independent/install-kubeadm/">the instructions</a> to install kubeadm, kubelet and kubectl.</p>
<p class="has-line-data" data-line-start="399" data-line-end="400">Create the systemd drop-in file  <code>/etc/systemd/system/kubelet.service.d/0-containerd.conf</code>:</p>
<pre><code class="html">[Service]                                                 
Environment=&quot;KUBELET_EXTRA_ARGS=--container-runtime=remote --runtime-request-timeout=15m --container-runtime-endpoint=unix:///run/containerd/containerd.sock&quot;
</code></pre>
<p class="has-line-data" data-line-start="406" data-line-end="407">And reload systemd configuration:</p>
<pre><code class="html">systemctl daemon-reload
</code></pre>
<p class="has-line-data" data-line-start="412" data-line-end="413">Bring Up the Cluster</p>
<p class="has-line-data" data-line-start="414" data-line-end="415">Now you should have properly installed all required binaries and dependencies on each of your node.</p>
<hr>
<h2 class="code-line" data-line-start=417 data-line-end=418 ><a id="RKT_417"></a>RKT</h2>
<p class="has-line-data" data-line-start="419" data-line-end="420"><a href="https://coreos.com/rkt/">RKT</a>: A security-minded, standards-based container engine, by default, <code>rkt</code> expects our images to be signed. rkt can download, cryptographically verify, and run application container images. It is not designed to run “full system containers” but instead individual applications such as web apps, databases, or caches. As rkt does not have a centralized daemon it can be integrated with init systems such as upstart and systemd.</p>
<p class="has-line-data" data-line-start="421" data-line-end="422">How to install RKT ?</p>
<p class="has-line-data" data-line-start="423" data-line-end="424">Caution: This RPM is not signed yet used this for testing only.</p>
<pre><code class="html">cat &lt;&lt;EOF &gt; /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=<span class="hljs-number">1</span>
gpgcheck=<span class="hljs-number">0</span>
repo_gpgcheck=<span class="hljs-number">0</span>
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

yum -y install rkt
</code></pre>
<p class="has-line-data" data-line-start="438" data-line-end="439">Install acbuild for building the Image.</p>
<pre><code class="html">wget https://github.com/containers/build/releases/download/v0.<span class="hljs-number">4.0</span>/acbuild-v0.<span class="hljs-number">4.0</span>.tar.gz
tar xvf acbuild-v0.<span class="hljs-number">4.0</span>.tar.gz
<span class="hljs-built_in">export</span> PATH=<span class="hljs-variable">$PATH</span>:./acbuild-v0.<span class="hljs-number">4.0</span>/
</code></pre>
<p class="has-line-data" data-line-start="445" data-line-end="446">Create A Hello World Go Application</p>
<pre><code class="html"><span class="hljs-keyword">package</span> main

<span class="hljs-keyword">import</span> (
    <span class="hljs-string">"log"</span>
    <span class="hljs-string">"net/http"</span>
)
<span class="hljs-keyword">func</span> main() {
    http.HandleFunc(<span class="hljs-string">"/"</span>, <span class="hljs-keyword">func</span>(w http.ResponseWriter, r *http.Request) {
        log.Printf(<span class="hljs-string">"request from %v\n"</span>, r.RemoteAddr)
        w.Write([]<span class="hljs-typename">byte</span>(<span class="hljs-string">"hello\n"</span>))
    })
    log.Fatal(http.ListenAndServe(<span class="hljs-string">":5000"</span>, <span class="hljs-constant">nil</span>))
}
</code></pre>
<p class="has-line-data" data-line-start="463" data-line-end="464">Build the Hello Application with statically compiled.</p>
<pre><code class="html">[root@localhost hello]<span class="hljs-comment"># go build</span>
[root@localhost hello]<span class="hljs-comment"># ls -ltr </span>
total <span class="hljs-number">7280</span>
-rw-r--r--. <span class="hljs-number">1</span> root root     <span class="hljs-number">257</span> Nov  <span class="hljs-number">3</span> <span class="hljs-number">11</span>:<span class="hljs-number">58</span> hello.go
-rwxr-xr-x. <span class="hljs-number">1</span> root root <span class="hljs-number">7450510</span> Nov  <span class="hljs-number">3</span> <span class="hljs-number">12</span>:<span class="hljs-number">03</span> hello
[root@localhost hello]<span class="hljs-comment"># CGO_ENABLED=0 go build -ldflags '-extldflags "-static"'</span>
[root@localhost hello]<span class="hljs-comment"># file hello</span>
hello: ELF <span class="hljs-number">64</span>-bit LSB executable, x86-<span class="hljs-number">64</span>, version <span class="hljs-number">1</span> (SYSV), statically linked, not stripped
</code></pre>
<p class="has-line-data" data-line-start="476" data-line-end="477">OCI Image spec build with  acbuild</p>
<pre><code class="html">[root@localhost hello]<span class="hljs-comment"># acbuild begin</span>
[root@localhost hello]<span class="hljs-comment"># acbuild set-name 8gwifi.org/hello</span>
[root@localhost hello]<span class="hljs-comment"># acbuild copy hello /bin/hello</span>
[root@localhost hello]<span class="hljs-comment"># acbuild set-exec /bin/hello</span>
[root@localhost hello]<span class="hljs-comment"># acbuild port add www tcp 5000</span>
[root@localhost hello]<span class="hljs-comment"># acbuild label add version 0.0.1</span>
[root@localhost hello]<span class="hljs-comment"># acbuild label add arch amd64</span>
[root@localhost hello]<span class="hljs-comment"># acbuild label add os linux</span>
[root@localhost hello]<span class="hljs-comment"># acbuild annotation add authors "Anish Nath @anish2good"</span>
[root@localhost hello]<span class="hljs-comment"># acbuild write hello-0.0.1-linux-amd64.aci</span>
[root@localhost hello]<span class="hljs-comment"># acbuild end</span>
</code></pre>
<p class="has-line-data" data-line-start="492" data-line-end="493">Launch a local application image</p>
<pre><code class="html">[root@localhost hello]<span class="hljs-comment"># rkt --insecure-options=image run hello-0.0.1-linux-amd64.aci</span>
</code></pre>
<pre><code class="html">[root@localhost ~]<span class="hljs-comment"># rkt list</span>
UUID        APP IMAGE NAME      STATE   CREATED     STARTED     NETWORKS
<span class="hljs-number">681</span>a80a5    hello   <span class="hljs-number">8</span>gwifi.org/hello:<span class="hljs-number">0.0</span>.<span class="hljs-number">1</span>  running <span class="hljs-number">1</span> minute ago    <span class="hljs-number">1</span> minute ago    default:ip4=<span class="hljs-number">172.16</span>.<span class="hljs-number">28.2</span>
</code></pre>
<p class="has-line-data" data-line-start="504" data-line-end="505">Test the Image.</p>
<pre><code class="html">[root@localhost ~]<span class="hljs-comment"># curl 172.16.28.2:5000</span>
hello
</code></pre>
<p class="has-line-data" data-line-start="511" data-line-end="512">To remove the container</p>
<pre><code class="html">[root@localhost ~]<span class="hljs-comment"># rkt stop 681a80a5</span>
<span class="hljs-string">"681a80a5-71a0-4e74-ac1c-4cb2acb6132f"</span>
[root@localhost ~]<span class="hljs-comment"># rkt list</span>
UUID        APP IMAGE NAME      STATE   CREATED     STARTED     NETWORKS
<span class="hljs-number">681</span>a80a5    hello   <span class="hljs-number">8</span>gwifi.org/hello:<span class="hljs-number">0.0</span>.<span class="hljs-number">1</span>  exited  <span class="hljs-number">10</span> minutes ago  <span class="hljs-number">10</span> minutes ago  
[root@localhost ~]<span class="hljs-comment"># rkt rm 681a80a5</span>
<span class="hljs-string">"681a80a5-71a0-4e74-ac1c-4cb2acb6132f
</span></code></pre>


<p class="has-line-data" data-line-start="107" data-line-end="108"><strong>That's ALL  (Nope )</strong></p>

				<p>
					Next Reading : <a href="docker-baseimage.jsp">Creating Docker Base Images </a>
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