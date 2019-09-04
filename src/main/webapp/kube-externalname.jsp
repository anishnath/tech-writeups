<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Kubernetes access Service located in another namespace">
    <meta name="keywords" content="Kubernetes Access Service located in another namespace, kubernetes tutorial, kubernetes by examples, kubernetes interview questions ">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>Kubernetes Access Service located in another namespace</title>

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
    "@id": "https://8gwifi.org/docs/kube-externalname.jsp"
  },
  "name" : "Kubernetes Access Service located in another namespace",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "Kubernetes Access Service located in another namespace",
  "image":"https://8gwifi.org/docs/img/accessservice.png",
  "datePublished" : "2019-09-04",
  "dateModified": "2019-09-04",
  "articleSection" : "Kubernetes namespaces",
  "articleBody" : [ "Introduction" ,"Kubernetes Access Service located in another namespace" , "ExternalName" , "mysql.default.svc.cluster.local" , "The ExternalName is configured properly" , "The externalName must point to the namespace which we are trying to access on that namespace" ],
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
          <h1 class="mt-4">Kubernetes Access Service located in another namespace</h1>

          <!-- Author -->
          <p class="lead">
            by
            <a href="https://www.linkedin.com/in/anishnath">Anish</a>
            <p>Posted on Wednesday September 4, 2019</p>
          </p>
          
          <img class="img-fluid rounded" src="img/accessservice.png" height="400" width="500" alt="Referefce ">
          
          <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>
           
          <hr>

<h3 class="mt-4">Introduction </h3>

In Kubernetes the namespace is used to isolate the resource, based on the use case services in different namespace may required to access the service located in another namespace and kubernetes allow this by using <strong>ExternalName</strong> concept.</p>
<p class="has-line-data" data-line-start="5" data-line-end="6">An <strong>ExternalName</strong> Service is a special case of Service that does not have selectors and uses DNS names instead.</p>
<p class="has-line-data" data-line-start="7" data-line-end="8">To demonstrate the <strong>ExternalName</strong>  lets assume we have a service of mysql which is running on defualt namespace</p>
<pre><code class="html">apiVersion: v1
kind: Service
metadata:
  name: mysql
  namespace: default
spec:
  clusterIP: None
  ports:
  - port: 3306
    protocol: TCP
    targetPort: 3306
  selector:
    app: mysql
  type: ClusterIP
</code></pre>
<p class="has-line-data" data-line-start="26" data-line-end="27">And a test busybox pod located in the default namespace is accessing this service using DNS name mysql</p>
<pre><code class="html">root@kube-master-2:# kubectl exec -it busybox sh
/ # ping -c1 mysql
PING mysql (192.168.242.145): 56 data bytes
64 bytes from 192.168.242.145: seq=0 ttl=63 time=0.068 ms

--- mysql ping statistics ---
1 packets transmitted, 1 packets received, 0% packet loss
round-trip min/avg/max = 0.068/0.068/0.068 ms
/ # exit
</code></pre>
<p class="has-line-data" data-line-start="40" data-line-end="41">If some other pod in another namespace is try to access the mysql service, it will not able to resolve the <strong>DNS</strong> mysql as shown below,</p>
<pre><code class="html">root@kube-master-2:# kubectl create ns playground
root@kube-master-2:# kubectl apply -f busybox.yml -n playground 
pod/busybox unchanged

root@kube-master-2:# kubectl exec -it busybox sh -n playground 
/ # 
/ # ping -c2 mysql
ping: bad address 'mysql'
/ # exit
</code></pre>
<p class="has-line-data" data-line-start="55" data-line-end="56">To Access the mysql service in the default namespace we need to build a service with type ExternalName as shown below. The externalName must point to the namespace which we are trying to access on that namespace.</p>
<pre><code class="html">mysql.default.svc.cluster.local
</code></pre>
<pre><code class="html">kind: Service
apiVersion: v1
metadata:
  name: mysql
  namespace: playground
spec:
  type: ExternalName
  externalName: mysql.default.svc.cluster.local
  ports:
  - port: 3306
</code></pre>
<p class="has-line-data" data-line-start="72" data-line-end="73">Apply the configuration and check for the svc</p>
<pre><code class="html">root@kube-master-2:# kubectl get svc -n playground 
NAME                   TYPE           CLUSTER-IP      EXTERNAL-IP                       PORT(S)    AGE
mysql                  ExternalName   &lt;none&gt;          mysql.default.svc.cluster.local   3306/TCP   8s
</code></pre>
<p class="has-line-data" data-line-start="80" data-line-end="81">The ExternalName is configured properly, now different pod should be access the service mysql which is located in another namespace.</p>
<pre><code class="html">root@kube-master-2:# kubectl exec -it busybox sh -n playground 
/ # ping -c2 mysql
PING mysql (192.168.242.145): 56 data bytes
64 bytes from 192.168.242.145: seq=0 ttl=63 time=0.069 ms
64 bytes from 192.168.242.145: seq=1 ttl=63 time=0.075 ms

--- mysql ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
round-trip min/avg/max = 0.069/0.072/0.075 ms
/ # exit
</code></pre>


<hr>
<p><h2>Video Demo </h2> </p>
 <iframe width="420" height="315"
src="https://youtube.com/embed/TikEgvwhdJ8">
</iframe> 


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