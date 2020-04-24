<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="kubernetes cluster upgrade from v1.14 to v.1.18 latest version ">
    <meta name="keywords" content="kubernetes service external ip pending  kubernetes tutorial, kubernetes by examples">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>Upgrading kubeadm clusters from v1.14 to v1.18</title>

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
    "@id": "https://8gwifi.org/docs/kube-upgrade.jsp"
  },
  "name" : "Upgrading kubeadm clusters from v1.14 to v1.18",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "Upgrading kubeadm clusters from v1.14 to v1.18",
  "image":"https://8gwifi.org/docs/img/kube-upgrade.png",
  "datePublished" : "2020-04-22",
  "dateModified": "2020-04-22",
  "articleSection" : "Upgrading kubeadm clusters from v1.14 to v1.18",
  "articleBody" : [ "Upgrading kubeadm clusters from v1.14 to v1.18" ],
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
          <h1 class="mt-4">Upgrading kubeadm clusters from v1.14 to v1.18</h1>

          <!-- Author -->
          <p class="lead">
            by
            <a href="https://www.linkedin.com/in/anishnath">Anish</a>
            <p>Posted on Thursday April 23, 2020</p>
          </p>
          
          <img class="img-fluid rounded" src="img/kube-install.png" height="400" width="500" alt="Referefce ">
          
          <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>
           
          <hr>
<p class="html" data-line-start="3" data-line-end="4">This page explains how to upgrade a Kubernetes cluster created with kubeadm from version 1.14.x to version 1.15.x, and from version 1.15.x to 1.18.y</p>
<p class="html" data-line-start="5" data-line-end="6">The upgrade workflow at high level is the following:</p>
<ol>
<li class="html" data-line-start="7" data-line-end="8">Upgrade the primary control plane node.</li>
<li class="html" data-line-start="8" data-line-end="9">Upgrade additional control plane nodes.</li>
<li class="html" data-line-start="9" data-line-end="11">Upgrade worker nodes.</li>
</ol>
<p class="html" data-line-start="11" data-line-end="12"><strong>The Setup</strong></p>
<p class="html" data-line-start="13" data-line-end="14">The kubernetes cluster is running with 1- Master and 1 Worker node with the <code>v1.14.0</code> our traget is get this cluster to <code>v1.18.2</code> version. The enviroment is running on ubuntu platform, for centos family only the repository will chnage the concept will remain the same.</p>
<pre><code class="html">master $ kubectl get nodes
NAME     STATUS   ROLES    AGE   VERSION
master   Ready    master   73m   v1.14.0
node01   Ready    &lt;none&gt;   72m   v1.14.0
</code></pre>
<pre><code class="html">master $ kubectl version
Client Version: version.Info{Major:&quot;1&quot;, Minor:&quot;14&quot;, GitVersion:&quot;v1.14.0&quot;, GitCommit:&quot;641856db18352033a0d96dbc99153fa3b27298e5&quot;, GitTreeState:&quot;clean&quot;, BuildDate:&quot;2019-03-25T15:53:57Z&quot;, GoVersion:&quot;go1.12.1&quot;, Compiler:&quot;gc&quot;, Platform:&quot;linux/amd64&quot;}
Server Version: version.Info{Major:&quot;1&quot;, Minor:&quot;14&quot;, GitVersion:&quot;v1.14.0&quot;, GitCommit:&quot;641856db18352033a0d96dbc99153fa3b27298e5&quot;, GitTreeState:&quot;clean&quot;, BuildDate:&quot;2019-03-25T15:45:25Z&quot;, GoVersion:&quot;go1.12.1&quot;, Compiler:&quot;gc&quot;, Platform:&quot;linux/amd64&quot;}
master $ kubeadm version
kubeadm version: &amp;version.Info{Major:&quot;1&quot;, Minor:&quot;14&quot;, GitVersion:&quot;v1.14.0&quot;, GitCommit:&quot;641856db18352033a0d96dbc99153fa3b27298e5&quot;, GitTreeState:&quot;clean&quot;, BuildDate:&quot;2019-03-25T15:51:21Z&quot;, GoVersion:&quot;go1.12.1&quot;, Compiler:&quot;gc&quot;, Platform:&quot;linux/amd64&quot;}
master $
</code></pre>
<pre><code class="html">node01 $ kubectl version
Client Version: version.Info{Major:&quot;1&quot;, Minor:&quot;14&quot;, GitVersion:&quot;v1.14.0&quot;, GitCommit:&quot;641856db18352033a0d96dbc99153fa3b27298e5&quot;, GitTreeState:&quot;clean&quot;, BuildDate:&quot;2019-03-25T15:53:57Z&quot;, GoVersion:&quot;go1.12.1&quot;, Compiler:&quot;gc&quot;, Platform:&quot;linux/amd64&quot;}
The connection to the server localhost:8080 was refused - did you specify the right host or port?
node01 $ kubeadm version
kubeadm version: &amp;version.Info{Major:&quot;1&quot;, Minor:&quot;14&quot;, GitVersion:&quot;v1.14.0&quot;, GitCommit:&quot;641856db18352033a0d96dbc99153fa3b27298e5&quot;, GitTreeState:&quot;clean&quot;, BuildDate:&quot;2019-03-25T15:51:21Z&quot;, GoVersion:&quot;go1.12.1&quot;, Compiler:&quot;gc&quot;, Platform:&quot;linux/amd64&quot;}
node01 $
</code></pre>
<h1 class="code-line" data-line-start=43 data-line-end=44><a id="v114xv115x_43"></a>v1.14.x-v.1.15.x</h1>
<h3 class="code-line" data-line-start=46 data-line-end=47><a id="Master_Node__upgrade_kubeadm_46"></a>Master Node - upgrade kubeadm</h3>
<pre><code class="html" data-line-start="49" data-line-end="53" class="language-console">apt-mark unhold kubeadm &amp;&amp; \
apt-get update &amp;&amp; apt-get install -y kubeadm=1.15.11-00 &amp;&amp; \
apt-mark hold kubeadm
</code></pre>
<pre><code class="html">kubeadm upgrade plan
kubeadm upgrade apply v1.15.11
</code></pre>

<h3 class="code-line" data-line-start=59 data-line-end=60><a id="Master_Node__upgrade_kubelet_59"></a>Master Node - upgrade kubelet</h3>
<pre><code class="html">apt-mark unhold kubelet kubectl &amp;&amp; \
apt-get update &amp;&amp; apt-get install -y kubelet=1.15.11-00 kubectl=1.15.11-00 &amp;&amp; \
apt-mark hold kubelet kubectl
</code></pre>
<pre><code class="html">systemctl restart kubelet
</code></pre>
<h3 class="code-line" data-line-start=72 data-line-end=73><a id="Worker_Node_72"></a>Worker Node</h3>
<h4 class="code-line" data-line-start=75 data-line-end=76><a id="Master_Node__drain_the_Worker_Node_75"></a>Master Node - drain the Worker Node</h4>
<pre><code class="html" data-line-start="78" data-line-end="80">kubectl drain node01 --ignore-daemonsets --delete-local-data
</code></pre>
<h3 class="code-line" data-line-start=80 data-line-end=81><a id="Worker_Node__upgrade_kubelet_80"></a>Worker Node - upgrade kubelet</h3>
<pre><code class="html" data-line-start="83" data-line-end="87">apt-mark unhold kubelet kubectl &amp;&amp; \
apt-get update &amp;&amp; apt-get install -y kubelet=1.15.11-00 kubectl=1.15.11-00 &amp;&amp; \
apt-mark hold kubelet kubectl
</code></pre>
<pre><code class="html" data-line-start="88" data-line-end="90">systemctl restart kubelet
</code></pre>
<h4 class="code-line" data-line-start=91 data-line-end=92><a id="Master_Node__uncordon_the_Worker_Node_91"></a>Master Node - uncordon the Worker Node</h4>
<pre><code class="html" data-line-start="93" data-line-end="95">kubectl uncordon node01
</code></pre>
<hr>
 <%@ include file="footer_adsense.jsp"%> 
<h1 class="code-line" data-line-start=96 data-line-end=97><a id="v115xv116x_96"></a>v1.15.x-v.1.16.x</h1>
<h3 class="code-line" data-line-start=98 data-line-end=99><a id="Master_Node__upgrade_kubeadm_98"></a>Master Node - upgrade kubeadm</h3>
<pre><code class="html" data-line-start="101" data-line-end="105">apt-mark unhold kubeadm &amp;&amp; \
apt-get update &amp;&amp; apt-get install -y kubeadm=1.16.9-00 &amp;&amp; \
apt-mark hold kubeadm
</code></pre>
<pre><code class="html" data-line-start="107" data-line-end="110">kubeadm upgrade plan
kubeadm upgrade apply v1.16.9
</code></pre>
<h3 class="code-line" data-line-start=111 data-line-end=112><a id="Master_Node__upgrade_kubectl_111"></a>Master Node - upgrade kubectl</h3>
<pre><code class="html" data-line-start="114" data-line-end="118">apt-mark unhold kubelet kubectl &amp;&amp; \
apt-get update &amp;&amp; apt-get install -y kubelet=1.16.9-00 kubectl=1.16.9-00 &amp;&amp; \
apt-mark hold kubelet kubectl
</code></pre>
<pre><code class="html" data-line-start="120" data-line-end="122">systemctl restart kubelet
</code></pre>
<h3 class="code-line" data-line-start=123 data-line-end=124><a id="Worker_Node_123"></a>Worker Node</h3>
<h4 class="code-line" data-line-start=125 data-line-end=126><a id="Master_Node__drain_the_Worker_Node_125"></a>Master Node - drain the Worker Node</h4>
<pre><code class="html" data-line-start="127" data-line-end="129">kubectl drain node01 --ignore-daemonsets --delete-local-data
</code></pre>
<h3 class="code-line" data-line-start=130 data-line-end=131><a id="Worker_Node__upgrade_kubeadm_130"></a>Worker Node - upgrade kubeadm</h3>
<pre><code class="html" data-line-start="133" data-line-end="137">apt-mark unhold kubelet kubectl &amp;&amp; \
apt-get update &amp;&amp; apt-get install -y kubeadm=1.16.9-00 kubeadm=1.16.9-00 &amp;&amp; \
apt-mark hold kubelet kubectl
</code></pre>
<pre><code class="html" data-line-start="139" data-line-end="141">kubeadm upgrade node
</code></pre>
<h3 class="code-line" data-line-start=142 data-line-end=143><a id="Worker_Node__upgrade_kubelet_142"></a>Worker Node - upgrade kubelet</h3>
<pre><code class="html" data-line-start="145" data-line-end="149">apt-mark unhold kubelet kubectl &amp;&amp; \
apt-get update &amp;&amp; apt-get install -y kubelet=1.16.9-00 kubectl=1.16.9-00 &amp;&amp; \
apt-mark hold kubelet kubectl
</code></pre>
<pre><code class="html" data-line-start="151" data-line-end="153">systemctl restart kubelet
</code></pre>
<h4 class="code-line" data-line-start=155 data-line-end=156><a id="Master_Node__uncordon_the_Worker_Node_155"></a>Master Node - uncordon the Worker Node</h4>
<pre><code class="html" data-line-start="158" data-line-end="160">kubectl uncordon node01
</code></pre>
<hr>
<h1 class="code-line" data-line-start=162 data-line-end=163><a id="v116xv117x_162"></a>v1.16.x-v.1.17.x</h1>
<h3 class="code-line" data-line-start=164 data-line-end=165><a id="Master_Node__upgrade_kubeadm_164"></a>Master Node - upgrade kubeadm</h3>
<pre><code class="html" data-line-start="167" data-line-end="171">apt-mark unhold kubeadm &amp;&amp; \
apt-get update &amp;&amp; apt-get install -y kubeadm=1.17.5-00 &amp;&amp; \
apt-mark hold kubeadm
</code></pre>
<pre><code class="html" data-line-start="173" data-line-end="177"># since apt-get version 1.1 you can also use the following method
apt-get update &amp;&amp; \
apt-get install -y --allow-change-held-packages kubeadm=1.17.5-00
</code></pre>
<pre><code class="html" data-line-start="179" data-line-end="182">kubeadm upgrade plan
kubeadm upgrade apply v1.17.5
</code></pre>
<h3 class="code-line" data-line-start=183 data-line-end=184><a id="Master_Node__upgrade_kubectl_183"></a>Master Node - upgrade kubectl</h3>
<pre><code class="html" data-line-start="186" data-line-end="190">apt-mark unhold kubelet kubectl &amp;&amp; \
apt-get update &amp;&amp; apt-get install -y kubelet=1.17.5-00 kubectl=1.17.5-00 &amp;&amp; \
apt-mark hold kubelet kubectl
</code></pre>
<pre><code class="html" data-line-start="192" data-line-end="194">systemctl restart kubelet
</code></pre>
<h3 class="code-line" data-line-start=195 data-line-end=196><a id="Worker_Node_195"></a>Worker Node</h3>
<h4 class="code-line" data-line-start=197 data-line-end=198><a id="Master_Node__drain_the_Worker_Node_197"></a>Master Node - drain the Worker Node</h4>
<pre><code class="html" data-line-start="200" data-line-end="202">kubectl drain node01 --ignore-daemonsets --delete-local-data
</code></pre>
<pre><code class="html" data-line-start="205" data-line-end="210"># replace x in 1.17.x-00 with the latest patch version
apt-mark unhold kubeadm &amp;&amp; \
apt-get update &amp;&amp; apt-get install -y kubeadm=1.17.5-00 &amp;&amp; \
apt-mark hold kubeadm 
</code></pre>
<pre><code class="html" data-line-start="212" data-line-end="217"># since apt-get version 1.1 you can also use the following method
apt-get update &amp;&amp; \
apt-get install -y --allow-change-held-packages kubeadm=1.17.5-00

</code></pre>
<h3 class="code-line" data-line-start=218 data-line-end=219><a id="Worker_Node__upgrade_kubeadm_218"></a>Worker Node - upgrade kubeadm</h3>
<pre><code class="html" data-line-start="221" data-line-end="225"># since apt-get version 1.1 you can also use the following method
apt-get update &amp;&amp; \
apt-get install -y --allow-change-held-packages kubeadm=1.17.5-00
</code></pre>
<pre><code class="html" data-line-start="226" data-line-end="228">kubeadm upgrade node
</code></pre>
<h3 class="code-line" data-line-start=229 data-line-end=230><a id="Worker_Node__upgrade_kubectl_229"></a>Worker Node - upgrade kubectl</h3>
<pre><code class="html" data-line-start="232" data-line-end="237"># replace x in 1.17.x-00 with the latest patch version
apt-mark unhold kubelet kubectl &amp;&amp; \
apt-get update &amp;&amp; apt-get install -y kubelet=1.17.5-00 kubectl=1.17.5-00 &amp;&amp; \
apt-mark hold kubelet kubectl
</code></pre>
<pre><code class="html" data-line-start="239" data-line-end="243"># since apt-get version 1.1 you can also use the following method
apt-get update &amp;&amp; \
apt-get install -y --allow-change-held-packages kubelet=1.17.5-00 kubectl=1.17.5-00
</code></pre>
<pre><code class="html" data-line-start="245" data-line-end="247">systemctl restart kubelet
</code></pre>
<h4 class="code-line" data-line-start=248 data-line-end=249><a id="Master_Node__uncordon_the_Worker_Node_248"></a>Master Node - uncordon the Worker Node</h4>
<pre><code class="html" data-line-start="251" data-line-end="253">kubectl uncordon node01
</code></pre>
<hr>
<h1 class="code-line" data-line-start=254 data-line-end=255><a id="v117xv118x_254"></a>v1.17.x-v.1.18.x</h1>
<h3 class="code-line" data-line-start=257 data-line-end=258><a id="Master_Node__upgrade_kubeadm_257"></a>Master Node - upgrade kubeadm</h3>
<pre><code class="html" data-line-start="260" data-line-end="264">apt-mark unhold kubeadm &amp;&amp; \
apt-get update &amp;&amp; apt-get install -y kubeadm=1.18.2-00 &amp;&amp; \
apt-mark hold kubeadm
</code></pre>
<pre><code class="html" data-line-start="266" data-line-end="270"># since apt-get version 1.1 you can also use the following method
apt-get update &amp;&amp; \
apt-get install -y --allow-change-held-packages kubeadm=1.18.2-00
</code></pre>
<pre><code class="html" data-line-start="272" data-line-end="275">kubeadm upgrade plan
kubeadm upgrade apply v1.18.2
</code></pre>
<h3 class="code-line" data-line-start=276 data-line-end=277><a id="Master_Node__upgrade_kubectl_276"></a>Master Node - upgrade kubectl</h3>
<pre><code class="html" data-line-start="279" data-line-end="284"># replace x in 1.18.x-00 with the latest patch version
apt-mark unhold kubelet kubectl &amp;&amp; \
apt-get update &amp;&amp; apt-get install -y kubelet=1.18.2-00 kubectl=1.18.2-00 &amp;&amp; \
apt-mark hold kubelet kubectl
</code></pre>
<pre><code class="html" data-line-start="286" data-line-end="290"># since apt-get version 1.1 you can also use the following method
apt-get update &amp;&amp; \
apt-get install -y --allow-change-held-packages kubelet=1.18.2-00 kubectl=1.18.2-00
</code></pre>
<pre><code class="html" data-line-start="292" data-line-end="294">systemctl restart kubelet
</code></pre>
<h3 class="code-line" data-line-start=295 data-line-end=296><a id="Worker_Node_295"></a>Worker Node</h3>
<h4 class="code-line" data-line-start=297 data-line-end=298><a id="Master_Node__drain_the_Worker_Node_297"></a>Master Node - drain the Worker Node</h4>
<pre><code class="html" data-line-start="300" data-line-end="302">kubectl drain node01 --ignore-daemonsets --delete-local-data
</code></pre>
<h3 class="code-line" data-line-start=302 data-line-end=303><a id="Worker_Node__upgrade_kubeadm_302"></a>Worker Node - upgrade kubeadm</h3>
<pre><code class="html" data-line-start="305" data-line-end="309">apt-mark unhold kubeadm &amp;&amp; \
apt-get update &amp;&amp; apt-get install -y kubeadm=1.18.2-00 &amp;&amp; \
apt-mark hold kubeadm
</code></pre>
<h3 class="code-line" data-line-start=310 data-line-end=311><a id="Worker_Node__upgrade_kubectl_310"></a>Worker Node - upgrade kubectl</h3>
<pre><code class="html" data-line-start="313" data-line-end="317">apt-mark unhold kubelet kubectl &amp;&amp; \
apt-get update &amp;&amp; apt-get install -y kubelet=1.18.2-00 kubectl=1.18.2-00 &amp;&amp; \
apt-mark hold kubelet kubectl
</code></pre>
<pre><code class="html" data-line-start="320" data-line-end="322">systemctl restart kubelet
</code></pre>
<h4 class="code-line" data-line-start=323 data-line-end=324><a id="Master_Node__uncordon_the_Worker_Node_323"></a>Master Node - uncordon the Worker Node</h4>
<pre><code class="html" data-line-start="325" data-line-end="327">kubectl uncordon node01
</code></pre>

<p>since it's kubernetes you may encounter some issues, feel free to poke me</p>

<p>Video Demo for Ubuntu v1.14-v1.18 </p>
<div class="embed-responsive embed-responsive-16by9">
<iframe class="embed-responsive-item"
src="https://youtube.com/embed/zVVc3hPMqao" allowfullscreen>
</iframe>
</div>

<p>Video Demo for RHEL </p>
<div class="embed-responsive embed-responsive-16by9">
<iframe class="embed-responsive-item"
src="https://youtube.com/embed/GuWPqpjncyo">
</iframe>
</div>






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

          
          <%@ include file="related-kube.jsp"%>
          
          <!-- Article Widget -->
         <%@ include file="related-linux.jsp"%>
         
           <!-- Article Widget -->
         <%@ include file="related-ansible.jsp"%>
         
         
         <%@ include file="related-openstack.jsp"%>
         
         <%@ include file="related-cryptography.jsp"%>
         <%@ include file="related-window-crypto.jsp"%>
         
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