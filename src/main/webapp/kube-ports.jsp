<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="what is Kubernetes port, targetport and nodePort">
    <meta name="keywords" content="Kubernetes port,Kubernetes targetport , port,Kubernetes nodePort, port,Kubernetes iptables,Service kubernetes, kubernetes interview questions">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>Kubernetes  Port, Targetport and NodePort</title>

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
    "@id": "https://8gwifi.org/docs/kube-ports.jsp"
  },
  "name" : "Kubernetes  Port, Targetport and NodePort",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "Kubernetes  Port, Targetport and NodePort",
  "image":"https://8gwifi.org/docs/img/kube-nginx.png",
  "datePublished" : "2018-08-15",
  "dateModified": "2018-08-15",
  "articleSection" : "Kubernetes  Port, Targetport and NodePort",
  "articleBody" : [ "Definition of Modern TLS","Service kubernetes","Port","Target Port","Nodeport"]
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
          <h1 class="mt-4" class="mt-4">Kubernetes: Port,Targetport and NodePort</h1>

          <!-- Author -->
          <p class="lead">
            by
            <a href="https://www.linkedin.com/in/anishnath">Anish</a>
            <p>Posted on Tuesday August 15, 2018</p>
          </p>
          
          <img class="img-fluid rounded" src="img/kube-nginx.png" height="400" width="500" alt="Referefce ">
          
          <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>
           
          <hr>
          
<h2><a id="Multiple_Port_Services_2"></a>Multiple Port Services</h2>
<ol>
<li>
<p>Many <code class="html">Services</code> need to expose more than one port. Kubernetes supports multiple port definitions on a <code class="html">Service</code> object. When using multiple ports you must give all of your ports names, so that endpoints can be disambiguated. For example, this definition <strong><a href="kube-nginx.jsp">is used in nginx secure deployment in my previous article</a></strong></p>
<pre><code class="html">apiVersion: v1
kind: Service
metadata:
  name: nginxsvc
  labels:
    app: nginx
spec:
  type: NodePort
  ports:
  - port: 80
    protocol: TCP
    name: http
  - port: 443
    protocol: TCP
    name: https
  selector:
    app: nginx
</code></pre>
<hr>
<ul>
<li><strong>Port</strong>: Port is the port number which makes a  <a href="https://kubernetes.io/docs/concepts/services-networking/service/">service</a>  visible to other services running within the same K8s cluster.</li>
<li><strong>Target Port</strong>: Target port is the port on the POD where the service is running.Service can map an incoming port to any targetPort. By default the targetPort will be set to the same value as the port field</li>
<li><strong>Nodeport</strong>: Node port is the port on which the service can be accessed from external world using through  <a href="https://kubernetes.io/docs/admin/kube-proxy/">Kube-Proxy</a>.In NodePort, the Kubernetes master will allocate a port from a range specified by <code>--service-node-port-range flag (default: 30000-32767) </code>, and each Node will proxy that port (the same port number on every Node) into your Service
 </li>
</ul>
</li>
<li>
<p>These are IPtables rules in which will be setup by kubernetes in the master-node.</p>
</li>
</ol>
<pre><code class="html">    iptables -t nat --line-numbers -n -L | grep 30287
    1  KUBE-MARK-MASQ  tcp  --  0.0.0.0/0  0.0.0.0/0  /* default/nginxsvc:https */ tcp dpt:**30287**
    2  KUBE-SVC-ER5WGNLE726ZPUG2  tcp  --  0.0.0.0/0  0.0.0.0/0  /* default/nginxsvc:https */ tcp dpt:**30287**
    
    iptables -L | grep 30287
        REJECT tcp  --  anywhere anywhere /* default/nginxsvc:https has no endpoints */ ADDRTYPE match dst-type LOCAL tcp dpt:**30287** reject-with icmp-port-unreachable
</code></pre>
<ol start="3">
<li>once the deployment is created , new iptables rules will ge generated,  you can  find the node port that Kubernetes is using for http and https traffic using the command  <code class="html">kubectl get service nginxsvc -o json</code></li>
</ol>
<pre><code class="html">    &quot;spec&quot;: {
            &quot;clusterIP&quot;: &quot;10.103.250.179&quot;,
            &quot;externalTrafficPolicy&quot;: &quot;Cluster&quot;,
            &quot;ports&quot;: [
                {
                    &quot;name&quot;: &quot;http&quot;,
                    &quot;nodePort&quot;: 32210,
                    &quot;port&quot;: 80,
                    &quot;protocol&quot;: &quot;TCP&quot;,
                    &quot;targetPort&quot;: 80
                },
                {
                    &quot;name&quot;: &quot;https&quot;,
                    &quot;nodePort&quot;: 30287,
                    &quot;port&quot;: 443,
                    &quot;protocol&quot;: &quot;TCP&quot;,
                    &quot;targetPort&quot;: 443
                }
            ],
</code></pre>
<h3><a id="Further_Reading_62"></a>Further Reading</h3>
<ol>
<li>Checkout how to deploy <a href="kube-nginx.jsp">HTTPS Secure Nginx deploymet in kubernetes</a></li>
</ol>


<p><strong> Thanku for reading !!! Give a Share for Support</strong></p>


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