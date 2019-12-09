<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="overview of linux namespace pid,network,mount,ipc,uts,user,cgroup">
    <meta name="keywords" content="overview of linux namespace pid,network,mount,ipc,uts,user,cgroup, cgroup vs namespace. linux interview questions">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>Linux namespaces pid,network,mount,ipc,uts,user,cgroup</title>

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
    "@id": "https://8gwifi.org/docs/linux-namespace.jsp"
  },
  "name" : "overview of linux namespaces pid,network,mount,ipc,uts,user,cgroup",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "overview of linux namespaces pid,network,mount,ipc,uts,user,cgroup",
  "image":"https://8gwifi.org/docs/img/linux-namespace1.png",
  "datePublished" : "2019-12-09",
  "dateModified": "2019-12-09",
  "articleSection" : "overview of linux namespaces ",
  "articleBody" : [ "overview of linux namespaces","pid namespace" , "namepspace type", "cgroup vs docker"],
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
          <h1 class="mt-4">Overview of Linux Namespace </h1>

          <!-- Author -->
          <p class="lead">
            by
            <a href="https://www.linkedin.com/in/anishnath">Anish</a>
          </p>

          <hr>

          <!-- Date/Time -->
          <p>Posted on Monday December 09/2019</p>

          <hr>

        
 
          <img class="img-fluid rounded" src="img/linux-namespace1.png" alt="Referefce 8gwifi.org">

           <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>

          <hr>

          <!-- Post Content -->
        <p class="has-line-data" data-line-start="4" data-line-end="5">Namespace is Linux Kernel feature</p>
<blockquote>
<p class="has-line-data" data-line-start="6" data-line-end="7">A namespace wraps a global system resource in an abstraction that makes it appear to the processes within the namespace that they have their own isolated instance of the global resource. Changes to the global resource are visible to other processes that are members of the namespace but are invisible to other processes.</p>
</blockquote>
<p class="has-line-data" data-line-start="8" data-line-end="9">For more information, see the <a href="http://man7.org/linux/man-pages/man7/namespaces.7.html">namespaces(7)</a>  man page.</p>
<p class="has-line-data" data-line-start="10" data-line-end="11">Namespaces are specified as an array of entries inside the  <code>namespaces</code>  root field. The following parameters can be specified to set up namespaces:</p>
<p class="has-line-data" data-line-start="12" data-line-end="13">Example</p>
<pre><code class="html">    "namespaces": [
        {
            "type": "pid",
            "path": "/proc/1234/ns/pid"
        },
        {
            "type": "network",
            "path": "/var/run/netns/neta"
        },
        {
            "type": "mount"
        },
        {
            "type": "ipc"
        },
        {
            "type": "uts"
        },
        {
            "type": "user"
        },
        {
            "type": "cgroup"
        }
    ]
</code></pre>
<p class="has-line-data" data-line-start="42" data-line-end="43">The <code>/proc</code> filesystem shows (in the <code>/proc/PID</code> directories) only processes visible in the PID namespace of the process that performed the mount, even if the <code>/proc</code> filesystem is viewed from processes in other namespaces.</p>
<p class="has-line-data" data-line-start="44" data-line-end="45">The Linux kernel <code>v4.4.0</code> provides 7 types of namespaces: <strong>cgroup</strong>, <strong>pid</strong>, <strong>net</strong>, <strong>mnt</strong>, <strong>uts</strong>, <strong>ipc</strong> and <strong>user</strong>.</p>
<pre><code class="html">$ ls <span class="hljs-operator">-l</span> /proc/$$/ns
total <span class="hljs-number">0</span>
lrwxrwxrwx <span class="hljs-number">1</span> root root <span class="hljs-number">0</span> Dec  <span class="hljs-number">9</span> <span class="hljs-number">13</span>:<span class="hljs-number">08</span> cgroup -&gt; cgroup:[<span class="hljs-number">4026531835</span>]
lrwxrwxrwx <span class="hljs-number">1</span> root root <span class="hljs-number">0</span> Dec  <span class="hljs-number">9</span> <span class="hljs-number">13</span>:<span class="hljs-number">08</span> ipc -&gt; ipc:[<span class="hljs-number">4026531839</span>]
lrwxrwxrwx <span class="hljs-number">1</span> root root <span class="hljs-number">0</span> Dec  <span class="hljs-number">9</span> <span class="hljs-number">13</span>:<span class="hljs-number">08</span> mnt -&gt; mnt:[<span class="hljs-number">4026531840</span>]
lrwxrwxrwx <span class="hljs-number">1</span> root root <span class="hljs-number">0</span> Dec  <span class="hljs-number">9</span> <span class="hljs-number">13</span>:<span class="hljs-number">08</span> net -&gt; net:[<span class="hljs-number">4026531957</span>]
lrwxrwxrwx <span class="hljs-number">1</span> root root <span class="hljs-number">0</span> Dec  <span class="hljs-number">9</span> <span class="hljs-number">13</span>:<span class="hljs-number">08</span> pid -&gt; pid:[<span class="hljs-number">4026531836</span>]
lrwxrwxrwx <span class="hljs-number">1</span> root root <span class="hljs-number">0</span> Dec  <span class="hljs-number">9</span> <span class="hljs-number">13</span>:<span class="hljs-number">08</span> user -&gt; user:[<span class="hljs-number">4026531837</span>]
lrwxrwxrwx <span class="hljs-number">1</span> root root <span class="hljs-number">0</span> Dec  <span class="hljs-number">9</span> <span class="hljs-number">13</span>:<span class="hljs-number">08</span> uts -&gt; uts:[<span class="hljs-number">4026531838</span>]
</code></pre>
<ul>
<li class="has-line-data" data-line-start="60" data-line-end="62"><strong><code>pid</code></strong> : The Process ID. This file is a handle for the PID namespace of the process.PID  namespaces isolate the process ID number space, meaning that processes in different PID namespaces can have the same PID.  PID namespaces allow containers to provide functionality such as suspending/resuming the set of processes in the container and migrating the container to a new host while the processes inside the container maintain the same PIDs</li>
</ul>
<p class="has-line-data" data-line-start="62" data-line-end="63">If two processes are in the same namespace, then the device IDs and inode numbers of their <strong>/proc/[pid]/ns/xxx</strong> symbolic links will be the same as shown below <strong>cgroup:[4026531835]</strong> and other process sharing the same inode.</p>
<p class="has-line-data" data-line-start="64" data-line-end="65"><img class="img-fluid rounded"  src="img/linux-namespace.png" alt="Same iNode number"></p>
<ul>
<li class="has-line-data" data-line-start="66" data-line-end="67"><strong><code>net</code></strong>  This file is a handle for the network namespace of the process. This provides the isolation of the system resources associated with networking and isolates Network devices. The  <code>ip netns</code> - is used to process network namespace management</li>
<li class="has-line-data" data-line-start="67" data-line-end="68"><strong><code>mount</code></strong>  This file is a handle for the mount namespace of the process and isolates Mount points</li>
<li class="has-line-data" data-line-start="68" data-line-end="69"><strong><code>ipc</code></strong>  This file is a handle for the IPC namespace of the process and isolates System Vs IPC and POSIX message queues</li>
<li class="has-line-data" data-line-start="69" data-line-end="70"><strong><code>uts</code></strong>  This file is a handle for the UTS namespace of the process and isolates Hostname and NIS domain name</li>
<li class="has-line-data" data-line-start="70" data-line-end="71"><strong><code>user</code></strong>  This file is a handle for the user namespace of the process</li>
<li class="has-line-data" data-line-start="71" data-line-end="73"><strong><code>cgroup</code></strong>  the container will have an isolated view of the cgroup hierarchy.</li>
</ul>
<pre><code class="html">$ cat /proc/cgroups 
<span class="hljs-comment">#subsys_name    hierarchy   num_cgroups enabled</span>
cpuset  <span class="hljs-number">5</span>   <span class="hljs-number">3</span>   <span class="hljs-number">1</span>
cpu <span class="hljs-number">9</span>   <span class="hljs-number">83</span>  <span class="hljs-number">1</span>
cpuacct <span class="hljs-number">9</span>   <span class="hljs-number">83</span>  <span class="hljs-number">1</span>
blkio   <span class="hljs-number">10</span>  <span class="hljs-number">83</span>  <span class="hljs-number">1</span>
memory  <span class="hljs-number">8</span>   <span class="hljs-number">92</span>  <span class="hljs-number">1</span>
devices <span class="hljs-number">2</span>   <span class="hljs-number">83</span>  <span class="hljs-number">1</span>
freezer <span class="hljs-number">3</span>   <span class="hljs-number">3</span>   <span class="hljs-number">1</span>
net_cls <span class="hljs-number">4</span>   <span class="hljs-number">3</span>   <span class="hljs-number">1</span>
perf_event  <span class="hljs-number">11</span>  <span class="hljs-number">3</span>   <span class="hljs-number">1</span>
net_prio    <span class="hljs-number">4</span>   <span class="hljs-number">3</span>   <span class="hljs-number">1</span>
hugetlb <span class="hljs-number">6</span>   <span class="hljs-number">3</span>   <span class="hljs-number">1</span>
pids
</code></pre>
<p class="has-line-data" data-line-start="90" data-line-end="91">Many container software use Linux namespaces in combination with <strong>cgroups</strong> to isolate their processes like Docker, LXC, runC.</p>
<h3 class="code-line" data-line-start=93 data-line-end=94 ><a id="cgroup_vs_namespace_93"></a>cgroup vs namespace</h3>
<ul>
<li class="has-line-data" data-line-start="95" data-line-end="97"><strong>cgroup</strong> is a way to control group based traffic control filter, example</li>
</ul>
<pre><code class="html">&quot;cgroupsPath&quot;: &quot;/myRuntime/myContainer&quot;,
    &quot;resources&quot;: {
        &quot;memory&quot;: {
        &quot;limit&quot;: 100000,
        &quot;reservation&quot;: 200000
        },
        &quot;devices&quot;: [
            {
                &quot;allow&quot;: false,
                &quot;access&quot;: &quot;rwm&quot;
            }
        ]
   }
</code></pre>
<ul>
<li class="has-line-data" data-line-start="114" data-line-end="116"><strong>namespace</strong>: Limit/abstraction what you can see in linux proc</li>
</ul>
<p>Next Reading :  <a href="linux-monitor-commands.jsp">How to Monitoring All Executed Commands in Linux </a> </p>

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
        <p class="m-0 text-center text-white">Copyright &copy; 8gwifi.org 2018</p>
      </div>
      <!-- /.container -->
    </footer>

    <!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  </body>

</html>