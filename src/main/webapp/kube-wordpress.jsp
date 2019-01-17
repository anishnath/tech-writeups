<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="How to install wordpress in kubernetes helm">
    <meta name="keywords" content="wordpress in kubernetes helm, wordpress kubernetes installaion, helm wordpress install, wordpress PersistentVolume, PersistentVolumeClaim, externel ip pending kubernetes, kubernetes tutorial, kubernetes by examples">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>How to install wordpress in kubernetes helm</title>

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
    "@id": "https://8gwifi.org/docs/kube-wordpress.jsp"
  },
  "name" : "How to install wordpress in kubernetes helm",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "Kubernetes wordpress Installation (helm)",
  "image":"https://8gwifi.org/docs/img/kube-wordpress.png",
  "datePublished" : "2019-01-17",
  "dateModified": "2019-01-17",
  "articleSection" : "Kubernetes wordpress Installation (helm)",
  "articleBody" : [ "Introduction" ,"kubernetes Installation starts here", "First define the PersistentVolume wordpress-pv where the wordpress data to be stored. The hostPath tells the wordpress directory is in /opt/wordpress location" ,"Create PersistentVolume in kube cluster" ,"Define PersistentVolumeClaim wordpress-pvc", "wordpress Installation starts here, this is done through helm the kubernetes package manager"],
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
          <h1 class="mt-4">Kubernetes wordpress Installation (helm)</h1>

          <!-- Author -->
          <p class="lead">
            by
            <a href="https://www.linkedin.com/in/anishnath">Anish</a>
            <p>Posted on Thursday Jnauary 17, 2019</p>
          </p>
          
          <img class="img-fluid rounded" src="img/wordpress.png" height="400" width="500" alt="Referefce ">
          
          <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>
           
          <hr>

<h3 class="mt-4">Introduction </h3>
<p>In this article we will learn how to to setup <strong>wordpress</strong> in kubernetes cluster using helm</p>
<p><a href="helm.sh">Helm</a>: Helm is a tool for managing Kubernetes charts. Charts are packages of pre-configured Kubernetes resources.</p>
<ul>
<li>Let's Begin deploying <strong>wordpress</strong> using helm in <strong>kubernetes</strong> , if you are new to helm then download and initialize helm as follows</li>
</ul>
<pre><code class="language-console">root@kube-master:#  helm init
root@kube-master:# kubectl create serviceaccount --namespace kube-system tiller
root@kube-master:# kubectl create clusterrolebinding tiller-cluster-rule \
   --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
root@kube-master:#  kubectl patch deploy --namespace kube-system tiller-deploy \
   -p '{&quot;spec&quot;:{&quot;template&quot;:{&quot;spec&quot;:{&quot;serviceAccount&quot;:&quot;tiller&quot;}}}}'
</code></pre>
<ul>
<li>Make sure the title-deploy pod is up and running</li>
</ul>
<pre><code class="language-console">root@kube-master:/home/ansible# kubectl get pods -n kube-system 
NAME                                  READY     STATUS    RESTARTS   AGE
coredns-78fcdf6894-jvmlb              1/1       Running   0          1h
coredns-78fcdf6894-xstbn              1/1       Running   0          1h
etcd-kube-master                      1/1       Running   0          1h
kube-apiserver-kube-master            1/1       Running   0          1h
kube-controller-manager-kube-master   1/1       Running   0          1h
kube-flannel-ds-5gzn9                 1/1       Running   0          1h
kube-flannel-ds-tlc8j                 1/1       Running   0          1h
kube-proxy-kl4fg                      1/1       Running   0          1h
kube-proxy-krt6n                      1/1       Running   0          1h
kube-scheduler-kube-master            1/1       Running   0          1h
<mark>tiller-deploy-85744d9bfb-wh98g        1/1       Running   0          1h </mark>
</code></pre>
<ul>
<li>
<p>Once titler pod is up and running, deploying <strong>wordpress</strong>  uses bitnami docker images, for this we need to go and create <strong>PersistentVolume</strong> and <strong>PersistentVolumeClaim</strong></p>
</li>
<li>
<p>Define the PersistentVolume  for <strong>mariadb-pv</strong> where the mariadb data to be stored.  The <strong>hostPath</strong> tells the mysql directory is in <strong>/bitnami/mariadb</strong> location</p>
</li>
</ul>
<pre><code class="language-console">root@kube-master:# cat mariadb-hostpath.yaml 
apiVersion: v1
kind: PersistentVolume
metadata:
  name: mariadb-pv
spec:
  capacity: 
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
    - ReadOnlyMany
  persistentVolumeReclaimPolicy: Retain
  hostPath:
    path: /bitnami/mariadb

root@kube-master:# kubectl create -f  mariadb-hostpath.yaml 
persistentvolume/mariadb-pv created
</code></pre>
<ul>
<li>Define the PersistentVolume  for <strong>wordpress-pv</strong> where the <strong>wordpress</strong>  site data to be stored.  The <strong>hostPath</strong> tells the mysql directory is in <strong>/data</strong> location</li>
</ul>
<pre><code class="language-console">root@kube-master:# cat wordpress-hostpath.yaml 
apiVersion: v1
kind: PersistentVolume
metadata:
  name: wordpress-pv
spec:
  capacity: 
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
    - ReadOnlyMany
  persistentVolumeReclaimPolicy: Retain
  hostPath:
    path: /data

root@kube-master:# kubectl create -f  wordpress-hostpath.yaml
persistentvolume/wordpress-pv created
</code></pre>
<ul>
<li>Define PersistentVolumeClaim <strong>data-wordpress-mariadb-0</strong> and <strong>wordpress-wordpress</strong></li>
</ul>
<pre><code class="language-console">root@kube-master:# cat wordpress-mariadb-pvc.yaml
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: data-wordpress-mariadb-0
spec:
  storageClassName: &quot;&quot;
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi

root@kube-master:# cat wordpress-pvc.yaml 
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: wordpress-wordpress
spec:
  storageClassName: &quot;&quot;
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
</code></pre>
<ul>
<li>Create PersistentVolumeClaim  in kube cluster</li>
</ul>
<pre><code class="language-console">root@kube-master:# kubectl create -f wordpress-mariadb-pvc.yaml 
root@kube-master:# kubectl create -f wordpress-pvc.yaml
</code></pre>
<ul>
<li>Check the PersistentVolumeClaim  is bounded to <strong>mysql-pv</strong> and <strong>wordpress-pv</strong></li>
</ul>
<pre><code class="language-console">root@kube-master:# kubectl get pvc
NAME                       STATUS    VOLUME         CAPACITY   ACCESS MODES   STORAGECLASS   AGE
data-wordpress-mariadb-0   Bound     mariadb-pv     1Gi        RWO,ROX                       1d
wordpress-wordpress        Bound     wordpress-pv   1Gi        RWO,ROX                       1d

root@kube-master:/home/ansible# kubectl get pv 
NAME           CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS    CLAIM                              STORAGECLASS   REASON    AGE
mariadb-pv     1Gi        RWO,ROX        Retain           Bound     default/data-wordpress-mariadb-0                            1d
wordpress-pv   1Gi        RWO,ROX        Retain           Bound     default/wordpress-wordpress      
</code></pre>
<ul>
<li>Wordpress Installation starts here, this is done through helm the kubernetes package manager,</li>
</ul>
<p>while setting up wordpress cluster the  <code>persistence.existingClaim=wordpress-wordpressc</code> is set which we have created earlier for manual change use the below setting</p>

<pre><code class="language-console">root@kube-master:# helm install --name wordpress \
  --set wordpressUsername=admin,wordpressPassword=adminpassword,mariadb.mariadbRootPassword=secretpassword,persistence.existingClaim=wordpress-wordpress,allowEmptyPassword=false \
    stable/wordpress


NAME:   wordpress
LAST DEPLOYED: Thu Jan 17 11:03:43 2019
NAMESPACE: default
STATUS: DEPLOYED

RESOURCES:
==&gt; v1/Service
NAME                 TYPE          CLUSTER-IP      EXTERNAL-IP  PORT(S)                     AGE
wordpress-mariadb    ClusterIP     10.106.188.168  &lt;none&gt;       3306/TCP                    2s
wordpress-wordpress  LoadBalancer  10.98.185.111   &lt;pending&gt;    80:31086/TCP,443:31639/TCP  2s

==&gt; v1beta1/Deployment
NAME                 DESIRED  CURRENT  UP-TO-DATE  AVAILABLE  AGE
wordpress-wordpress  1        1        1           0          2s

==&gt; v1beta1/StatefulSet
NAME               DESIRED  CURRENT  AGE
wordpress-mariadb  1        1        2s

==&gt; v1/Pod(related)
NAME                                  READY  STATUS             RESTARTS  AGE
wordpress-wordpress-7b74f59c78-l7qvz  0/1    ContainerCreating  0         2s
wordpress-mariadb-0                   0/1    ContainerCreating  0         2s

==&gt; v1/Secret
NAME                 TYPE    DATA  AGE
wordpress-mariadb    Opaque  2     2s
wordpress-wordpress  Opaque  1     2s

==&gt; v1/ConfigMap
NAME                     DATA  AGE
wordpress-mariadb        1     2s
wordpress-mariadb-tests  1     2s


NOTES:
1. Get the WordPress URL:

  NOTE: It may take a few minutes for the LoadBalancer IP to be available.
        Watch the status with: 'kubectl get svc --namespace default -w wordpress-wordpress'
  export SERVICE_IP=$(kubectl get svc --namespace default wordpress-wordpress --template &quot;{{ range (index .status.loadBalancer.ingress 0) }}{{.}}{{ end }}&quot;)
  echo &quot;WordPress URL: http://$SERVICE_IP/&quot;
  echo &quot;WordPress Admin URL: http://$SERVICE_IP/admin&quot;

2. Login with the following credentials to see your blog

  echo Username: admin
  echo Password: $(kubectl get secret --namespace default wordpress-wordpress -o jsonpath=&quot;{.data.wordpress-password}&quot; | base64 --decode)

</code></pre>

<ul>
<li>if you have already <mark>mariadb installed and want to connect externally then use</mark></li>
</ul>
<pre><code class="html">helm install stable/wordpress \
     --set mariadb.enabled=false,externalDatabase.host=myexternalhost,externalDatabase.user=myuser,externalDatabase.password=mypassword,externalDatabase.database=mydatabase,externalDatabase.port=3306
</code></pre>

<ul>
<li>View the wordpress container pod is up and running</li>
</ul>
<pre><code class="language-console">root@kube-master:# kubectl get pods --watch
NAME                                   READY     STATUS    RESTARTS   AGE
wordpress-mariadb-0                    1/1       Running   0          51s
wordpress-wordpress-7b74f59c78-l7qvz   0/1       Running   0          51s
</code></pre>


<ul>
<li>
<p>Once the <strong>wordpress</strong> POD is up and running , your wordpress is ready to use</p>
</li>
<li>
<p>To get your wordpress admin password run</p>
</li>
</ul>
<pre><code class="language-console">root@kube-master:# kubectl get secret --namespace default wordpress-wordpress -o jsonpath=&quot;{.data.wordpress-password}&quot; | base64 --decode
adminpassword
</code></pre>
<ul>
<li>Verify the wordpress serivce is up and running, the helm deployment use <strong>nodeType=Loadbalancer</strong>  which will be pending</li>
</ul>
<pre><code class="language-console">root@kube-master:# kubectl get svc 
NAME                  TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE
kubernetes            ClusterIP      10.96.0.1        &lt;none&gt;        443/TCP                      1d
wordpress-mariadb     ClusterIP      10.106.188.168   &lt;none&gt;        3306/TCP                     1m
wordpress-wordpress   LoadBalancer   10.98.185.111    &lt;pending&gt;     80:31086/TCP,443:31639/TCP   1m
</code></pre>
<ul>
<li>I did a Hack here, since the setup is on barematel, a VIP is added manually to k8 master nodes to excess the node port <code>31086</code></li>
<li>Open the web browser and browse through your VIP address with Node port http://&lt;&lt;VIP&gt;&gt;:31086/admin to access wordpress admin page<br>
<img class="img-fluid rounded"  src="img/wordpress.png" alt="enter image description here"></li>
<li>On successful login you will be seeing the dashbaord page<br>
<img class="img-fluid rounded"  src="img/wordpress1.png" alt=""></li>
<li>The wordpress installation is done in this example is not meant for production refer to helm wordpress chart to customize the value</li>
<li>Happy Helming and since it's kubernetes you may encounter some issues, feel free to poke me</li>
</ul>

<hr>
<p><h2>Video Demo </h2> </p>
 <iframe width="420" height="315"
src="https://youtube.com/embed/uNA2CT7fQ2A">
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