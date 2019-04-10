<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="How to install jenkins in kubernetes helm">
    <meta name="keywords" content="jenkins in kubernetes helm, jenkins kubernetes installaion, helm jenkins install, jenkins PersistentVolume, PersistentVolumeClaim">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>How to install jenkins in kubernetes helm</title>

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
    "@id": "https://8gwifi.org/docs/kube-jenkins.jsp"
  },
  "name" : "How to install jenkins in kubernetes helm",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "Kubernetes jenkins Installation (helm)",
  "image":"https://8gwifi.org/docs/img/kube-install.png",
  "datePublished" : "2019-01-11",
  "dateModified": "2019-01-11",
  "articleSection" : "Kubernetes jenkins Installation (helm)",
  "articleBody" : [ "Introduction" ,"kubernetes Installation starts here", "First define the PersistentVolume jenkins-pv where the jenkins data to be stored. The hostPath tells the jenkins directory is in /opt/jenkins location" ,"Create PersistentVolume in kube cluster" ,"Define PersistentVolumeClaim jenkins-pvc", "jenkins Installation starts here, this is done through helm the kubernetes package manager"],
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
          <h1 class="mt-4">Kubernetes jenkins Installation (helm)</h1>

          <!-- Author -->
          <p class="lead">
            by
            <a href="https://www.linkedin.com/in/anishnath">Anish</a>
            <p>Posted on Friday Jnauary 11, 2019</p>
          </p>
          
          <img class="img-fluid rounded" src="img/kube-install.png" height="400" width="500" alt="Referefce ">
          
          <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>
           
          <hr>

<h3 class="mt-4">Introduction </h3>

<p>This sample chapter extracted from the book,<mark> <a href="https://leanpub.com/crypto">Kubernetes for DevOps </a>. </mark> </p>
<p><mark>Get this book on Just  <a href="https://leanpub.com/kube/" target="_blank" rel="noopener">  $9 </a> or Ask Author for Discount </mark>   </p>
<p><iframe class="embed-responsive-item" width='160' height='400' src='https://leanpub.com/kube/embed' frameborder='0' allowtransparency='true'></iframe></p>

<hr>

<p>In this article we will learn how to to setup jenkins in kubernetes cluster using helm</p>
<p><a href="helm.sh">Helm</a>: Helm is a tool for managing Kubernetes charts. Charts are packages of pre-configured Kubernetes resources.</p>
<p>Let’s Begin deploying Jenkins using helm in kubernetes</p>
<ul>
<li>First define the PersistentVolume <strong>jenkins-pv</strong> where the jenkins data to be stored.  The <strong>hostPath</strong> tells the jenkins directory is in <strong>/opt/jenkins</strong> location</li>
</ul>
<pre><code class="language-console">root@kube-master:# cat jenkins-hostpath.yaml 
apiVersion: v1
kind: PersistentVolume
metadata:
  name: jenkins-pv
spec:
  capacity: 
    storage: 2Gi
  accessModes:
    - ReadWriteOnce
    - ReadOnlyMany
  persistentVolumeReclaimPolicy: Retain
  hostPath:
    path: /opt/jenkins
</code></pre>
<ul>
<li>Create PersistentVolume in kube cluster</li>
</ul>
<pre><code class="language-console">root@kube-master:# kubectl create -f  jenkins-hostpath.yaml 
persistentvolume/jenkins-pv created
</code></pre>
<ul>
<li>Check the PersistentVolume jenkins-pv is available for use</li>
</ul>
<pre><code class="language-console">root@kube-master:# kubectl get pv 
NAME       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM     STORAGECLASS   REASON    AGE
jenkins-pv   1Gi        RWO,ROX        Retain           Available                                      15s
</code></pre>
<ul>
<li>Define PersistentVolumeClaim <strong>jenkins-pvc</strong></li>
</ul>
<pre><code class="language-console">root@kube-master:/home/ansible# cat jenkins-pvc.yaml 
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: jenkins-pvc
spec:
  storageClassName: &quot;&quot;
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
</code></pre>
<ul>
<li>create PersistentVolumeClaim <strong>jenkins-pvc</strong> in kube cluster</li>
</ul>
<pre><code class="language-console">root@kube-master:# kubectl create -f  jenkins-pvc.yaml 
persistentvolumeclaim/jenkins-pvc created
</code></pre>
<ul>
<li>Check the PersistentVolumeClaim <strong>jenkins-pvc</strong> is bounded to <strong>jenkins-pv</strong></li>
</ul>
<pre><code class="language-console">root@kube-master:/home/ansible# kubectl get pvc
NAME        STATUS    VOLUME     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
jenkins-pvc   Bound     jenkins-pv   1Gi        RWO,ROX                       6s
</code></pre>
<ul>
<li>jenkins Installation starts here, this is done through helm the kubernetes package manager,</li>
</ul>
<blockquote>
<p>helm install --name jenkins --set<br>
Persistence.ExistingClaim=jenkins-pvc stable/jenkins</p>
</blockquote>
<p>while setting up jenkins cluster the  <code>persistence.existingClaim=jenkins-pvc</code> is set which we have created earlier.</p>
<pre><code class="language-console">root@kube-master:# helm install --name jenkins --set Persistence.ExistingClaim=jenkins-pvc stable/jenkins
NAME:   jenkins
LAST DEPLOYED: Fri Jan 11 10:07:03 2019
NAMESPACE: default
STATUS: DEPLOYED

RESOURCES:
==&gt; v1/Pod(related)
NAME                      READY  STATUS    RESTARTS  AGE
jenkins-5564885478-d9shr  0/1    Init:0/1  0         1s

==&gt; v1/Secret
NAME     TYPE    DATA  AGE
jenkins  Opaque  2     2s

==&gt; v1/ConfigMap
NAME           DATA  AGE
jenkins        5     2s
jenkins-tests  1     2s

==&gt; v1/Service
NAME           TYPE          CLUSTER-IP      EXTERNAL-IP  PORT(S)         AGE
jenkins-agent  ClusterIP     10.105.120.164  &lt;none&gt;       50000/TCP       2s
jenkins        LoadBalancer  10.106.23.98    &lt;pending&gt;    8080:30726/TCP  2s

==&gt; v1/Deployment
NAME     DESIRED  CURRENT  UP-TO-DATE  AVAILABLE  AGE
jenkins  1        1        1           0          2s


NOTES:
1. Get your 'admin' user password by running:
  printf $(kubectl get secret --namespace default jenkins -o jsonpath=&quot;{.data.jenkins-admin-password}&quot; | base64 --decode);echo
2. Get the Jenkins URL to visit by running these commands in the same shell:
  NOTE: It may take a few minutes for the LoadBalancer IP to be available.
        You can watch the status of by running 'kubectl get svc --namespace default -w jenkins'
  export SERVICE_IP=$(kubectl get svc --namespace default jenkins --template &quot;{{ range (index .status.loadBalancer.ingress 0) }}{{ . }}{{ end }}&quot;)
  echo http://$SERVICE_IP:8080/login

3. Login with the password from step 1 and the username: admin

For more information on running Jenkins on Kubernetes, visit:
https://cloud.google.com/solutions/jenkins-on-container-engine
</code></pre>
<ul>
<li>View the Jenkins conatiner pod is up and running</li>
</ul>
<pre><code class="language-console">root@kube-master:# kubectl get pods  --watch
NAME                       READY     STATUS      RESTARTS   AGE
jenkins-5564885478-d9shr   0/1       Init:0/1    0          1m
jenkins-5564885478-d9shr   0/1       PodInitializing   0         2m
jenkins-5564885478-d9shr   0/1       Running   0         2m
</code></pre>
<ul>
<li>
<p>Once the <strong>jenkins</strong> POD is up and running , your jenkins is ready to use</p>
</li>
<li>
<p>To get your admin password of jenkins run</p>
</li>
</ul>
<pre><code class="language-console">root@kube-master:# kubectl get secret --namespace default jenkins -o jsonpath=&quot;{.data.jenkins-admin-password}&quot; | base64 --decode; echo
EbbXwTgHrW
</code></pre>
<ul>
<li>To get your admin user of jenkins run</li>
</ul>
<pre><code class="language-console">root@kube-master:# kubectl get secret --namespace default jenkins -o jsonpath=&quot;{.data.jenkins-admin-user}&quot; | base64 --decode; echo
admin
</code></pre>
<ul>
<li>To connect to your jenkins server from outside the K8s cluster</li>
</ul>
<pre><code class="language-console">root@kube-master:# kubectl get pods
NAME                       READY     STATUS    RESTARTS   AGE
jenkins-5564885478-mqtdp   0/1       Running   0          2m
root@kube-master:# 
root@kube-master:# kubectl port-forward jenkins-5564885478-mqtdp 9000:8080
Forwarding from 127.0.0.1:9000 -&gt; 8080
Forwarding from [::1]:9000 -&gt; 8080
</code></pre>
<ul>
<li>Open the webbrowser and go to address <a href="http://localhost:9000">http://localhost:9000</a></li>
</ul>
<p><img class="img-fluid rounded"  src="img/jenkins.png" alt="Jenkins UI "></p>
<p>All right you have successfully created Jenkins start scheduling the jobs</p>

<hr>
<p><h2>Video Demo </h2> </p>
<iframe width="420" height="315"
src="https://youtube.com/embed/p_6T5NoTixQ">
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