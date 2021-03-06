<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="kubernetes api java client example list all pods">
<meta name="keywords"content="kubernetes api  java client example list all pods, kubernetes interview questions">
<meta name="author" content="Anish nath">
<meta name="robots" content="index,follow" />
<meta name="googlebot" content="index,follow" />
<meta name="resource-type" content="document" />
<meta name="classification" content="tools" />
<meta name="language" content="en" />

<title>kubernetes api java client example list all pods</title>

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
    "@id": "https://8gwifi.org/docs/kube-java.jsp"
  },
  "name" : "kubernetes api java client example list all pods",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "kubernetes api  java client example list all pods",
  "image":"https://8gwifi.org/docs/img/java_kubernetes.png",
  "datePublished" : "2019-07-30",
  "dateModified": "2019-07-30",
  "articleSection" : "kubernetes api java client example list all pods",
  "articleBody" : [ "kubernetes api java example","kubernetes java", "java kubernetes example", "kubernetes api example java"],
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
				<h1 class="mt-4">Kubernetes Java API client Example</h1>

				<!-- Author -->
				<p class="lead">
					by <a href="https://www.linkedin.com/in/anishnath">Anish</a>
				</p>

				<hr>

				<!-- Date/Time -->
				<p>Posted on Tuesday July 30th 2019</p>

				<hr>



				<img class="img-fluid rounded" src="img/java_kubernetes.png"alt="Referefce 8gwifi.org"> 

				<%@ include file="footer_adsense.jsp"%>
				<%@ include file="analytics.jsp"%>

				<hr>
					<p class="has-line-data" data-line-start="2" data-line-end="3">In this blog we will learn how to access your kubernetes cluster from your Java Client. For this you need the following Information</p>
<ul>
<li class="has-line-data" data-line-start="4" data-line-end="11">
<p class="has-line-data" data-line-start="4" data-line-end="5">Locate where your cluster-API is running</p>
<pre><code class="html">  root# kubectl cluster-info
  Kubernetes master is running at https://192.0.2.80:6443
  coredns is running at https://192.0.2.80:6443/api/v1/namespaces/kube-system/services/coredns:dns/proxy
  kubernetes-dashboard is running at https://192.0.2.80:6443/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy
</code></pre>
</li>
<li class="has-line-data" data-line-start="11" data-line-end="15">
<p class="has-line-data" data-line-start="11" data-line-end="12">Locate the kubeconfig file, This can be found at the below location</p>
<pre><code class="html">   root# cat $HOME/.kube/config
</code></pre>
</li>
<li class="has-line-data" data-line-start="15" data-line-end="43">
<p class="has-line-data" data-line-start="15" data-line-end="16">Save this file(<strong>config</strong>) on your Java project, we will lookup this file(<strong>config</strong>) using our sample java client program as shown below. This program uses <strong>Corev1</strong> API and list all the pod in all the namespace.</p>
<pre><code class="has-line-data" data-line-start="18" data-line-end="42" class="language-java"><span class="hljs-keyword">import</span> io.kubernetes.client.ApiClient;
<span class="hljs-keyword">import</span> io.kubernetes.client.ApiException;
<span class="hljs-keyword">import</span> io.kubernetes.client.Configuration;
<span class="hljs-keyword">import</span> io.kubernetes.client.apis.CoreV1Api;
<span class="hljs-keyword">import</span> io.kubernetes.client.models.V1Pod;
<span class="hljs-keyword">import</span> io.kubernetes.client.models.V1PodList;
<span class="hljs-keyword">import</span> io.kubernetes.client.util.Config;

<span class="hljs-keyword">import</span> java.io.IOException;

<span class="hljs-keyword">public</span> <span class="hljs-class"><span class="hljs-keyword">class</span> <span class="hljs-title">Example</span> </span>{
    <span class="hljs-function"><span class="hljs-keyword">public</span> <span class="hljs-keyword">static</span> <span class="hljs-keyword">void</span> <span class="hljs-title">main</span><span class="hljs-params">(String[] args)</span> <span class="hljs-keyword">throws</span> IOException, ApiException</span>{
        ApiClient client = Config.fromConfig(<span class="hljs-string">"config"</span>);
        client.setVerifyingSsl(<span class="hljs-keyword">false</span>);
        Configuration.setDefaultApiClient(client);

        CoreV1Api api = <span class="hljs-keyword">new</span> CoreV1Api();
        V1PodList list = api.listPodForAllNamespaces(<span class="hljs-keyword">null</span>, <span class="hljs-keyword">null</span>, <span class="hljs-keyword">null</span>, <span class="hljs-keyword">null</span>, <span class="hljs-keyword">null</span>, <span class="hljs-keyword">null</span>, <span class="hljs-keyword">null</span>, <span class="hljs-keyword">null</span>, <span class="hljs-keyword">null</span>);
        <span class="hljs-keyword">for</span> (V1Pod item : list.getItems()) {
            System.out.println(item.getMetadata().getName());
        }
    }
}
</code></pre>
</li>
<li class="has-line-data" data-line-start="43" data-line-end="54">
<p class="has-line-data" data-line-start="43" data-line-end="44">To compile this program add the required dependency for  kubernetes java api client in the Pom.xml</p>
<pre><code class="has-line-data" data-line-start="46" data-line-end="53">&lt;dependency&gt;
&lt;groupId&gt;io.kubernetes&lt;/groupId&gt;
&lt;artifactId&gt;client-java&lt;/artifactId&gt;
&lt;version&gt;5.0.0&lt;/version&gt;
&lt;scope&gt;compile&lt;/scope&gt;
&lt;/dependency&gt;
</code></pre>
</li>
<li class="has-line-data" data-line-start="54" data-line-end="56">
<p class="has-line-data" data-line-start="54" data-line-end="55">Now we have every thing ready to connect and run the program, I have used eclipse to compile and run this Application</p>
</li>
</ul>
<h2 class="code-line" data-line-start=56 data-line-end=58 ><a id="Kubernetes_API_java_example_imgkubejavapng_56"></a><img src="img/kube-java.png" alt="Kubernetes API java example "></h2>

<p><h2>Video Demo </h2> </p>
<iframe width="420" height="315"
src="https://youtube.com/embed/kCR7D5ywpOk">
</iframe>

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