<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="How to install mysql in kubernetes helm">
    <meta name="keywords" content="mysql in kubernetes helm, mysql kubernetes installaion, helm mysql install, mysql PersistentVolume, PersistentVolumeClaim">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>How to install mysql in kubernetes helm</title>

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
    "@id": "https://8gwifi.org/docs/kube-mysql.jsp"
  },
  "name" : "How to install mysql in kubernetes helm",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "Kubernetes mysql Installation (helm)",
  "image":"https://8gwifi.org/docs/img/kube-install.png",
  "datePublished" : "2019-01-11",
  "dateModified": "2019-01-11",
  "articleSection" : "Kubernetes mysql Installation (helm)",
  "articleBody" : [ "Introduction" ,"kubernetes Installation starts here", "First define the PersistentVolume mysql-pv where the mysql data to be stored. The hostPath tells the mysql directory is in /opt/mysql location" ,"Create PersistentVolume in kube cluster" ,"Define PersistentVolumeClaim mysql-pvc", "MYSQL Installation starts here, this is done through helm the kubernetes package manager"],
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
          <h1 class="mt-4">Kubernetes mysql Installation (helm)</h1>

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
<p>In this section we will learn how to install and setup mysql in kubernetes cluster using <a href="https://youtu.be/3KUnm6y1vZI">helm</a></p>
          <!-- Date/Time -->
          

   <ul>
<li>First define the PersistentVolume <strong>mysql-pv</strong> where the mysql data to be stored.  The <strong>hostPath</strong> tells the mysql directory is in <strong>/opt/mysql</strong> location</li>
</ul>
<pre><code class="language-console">root@kube-master:# cat mysqldb-hostpath.yaml 
apiVersion: v1
kind: PersistentVolume
metadata:
  name: mysql-pv
spec:
  capacity: 
    storage: 2Gi
  accessModes:
    - ReadWriteOnce
    - ReadOnlyMany
  persistentVolumeReclaimPolicy: Retain
  hostPath:
    path: /opt/mysql
</code></pre>
<ul>
<li>Create PersistentVolume in kube cluster</li>
</ul>
<pre><code class="language-console">root@kube-master:/home/ansible# kubectl create -f  mysqldb-hostpath.yaml 
persistentvolume/mysql-pv created
</code></pre>
<ul>
<li>Check the PersistentVolume mysql-pv is available for use</li>
</ul>
<pre><code class="language-console">root@kube-master:/home/ansible# kubectl get pv 
NAME       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM     STORAGECLASS   REASON    AGE
mysql-pv   1Gi        RWO,ROX        Retain           Available                                      15s
</code></pre>
<ul>
<li>Define PersistentVolumeClaim <strong>mysql-pvc</strong></li>
</ul>
<pre><code class="language-console">root@kube-master:/home/ansible# cat mysqldb-pvc.yaml 
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: mysql-pvc
spec:
  storageClassName: &quot;&quot;
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
</code></pre>
<ul>
<li>create PersistentVolumeClaim <strong>mysql-pvc</strong> in kube cluster</li>
</ul>
<pre><code class="language-console">root@kube-master:/home/ansible# kubectl create -f  mysqldb-pvc.yaml 
persistentvolumeclaim/mysql-pvc created
</code></pre>
<ul>
<li>Check the PersistentVolumeClaim <strong>mysql-pvc</strong> is bounded to <strong>mysql-pv</strong></li>
</ul>
<pre><code class="language-console">root@kube-master:/home/ansible# kubectl get pvc
NAME        STATUS    VOLUME     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
mysql-pvc   Bound     mysql-pv   1Gi        RWO,ROX                       6s
</code></pre>
<ul>
<li>MYSQL Installation starts here, this is done through helm the kubernetes package manager,</li>
</ul>
<blockquote>
<p>helm install --name mysql --set<br>
mysqlRootPassword=rootpassword,mysqlUser=mysql,mysqlPassword=my-password,mysqlDatabase=mydatabase,persistence.existingClaim=mysql-pvc stable/mysql</p>
</blockquote>
<p>while setting up mysql cluster the  <code>persistence.existingClaim=mysql-pvc</code> is set which we have created earlier.</p>
<pre><code class="language-console">root@kube-master:# helm install --name mysql --set mysqlRootPassword=rootpassword,mysqlUser=mysql,mysqlPassword=my-password,mysqlDatabase=mydatabase,persistence.existingClaim=mysql-pvc stable/mysql

NAME:   mysql
LAST DEPLOYED: Thu Jan 10 16:18:31 2019
NAMESPACE: default
STATUS: DEPLOYED

RESOURCES:
==&gt; v1beta1/Deployment
NAME   DESIRED  CURRENT  UP-TO-DATE  AVAILABLE  AGE
mysql  1        0        0           0          1s

==&gt; v1/Pod(related)
NAME                    READY  STATUS   RESTARTS  AGE
mysql-7b688448b9-pxml5  0/1    Pending  0         1s

==&gt; v1/Secret
NAME   TYPE    DATA  AGE
mysql  Opaque  2     1s

==&gt; v1/ConfigMap
NAME        DATA  AGE
mysql-test  1     1s

==&gt; v1/Service
NAME   TYPE       CLUSTER-IP     EXTERNAL-IP  PORT(S)   AGE
mysql  ClusterIP  10.100.139.57  &lt;none&gt;       3306/TCP  1s


NOTES:
MySQL can be accessed via port 3306 on the following DNS name from within your cluster:
mysql.default.svc.cluster.local

To get your root password run:

    MYSQL_ROOT_PASSWORD=$(kubectl get secret --namespace default mysql -o jsonpath=&quot;{.data.mysql-root-password}&quot; | base64 --decode; echo)

To connect to your database:

1. Run an Ubuntu pod that you can use as a client:

    kubectl run -i --tty ubuntu --image=ubuntu:16.04 --restart=Never -- bash -il

2. Install the mysql client:

    $ apt-get update &amp;&amp; apt-get install mysql-client -y

3. Connect using the mysql cli, then provide your password:
    $ mysql -h mysql -p

To connect to your database directly from outside the K8s cluster:
    MYSQL_HOST=127.0.0.1
    MYSQL_PORT=3306

    # Execute the following command to route the connection:
    kubectl port-forward svc/mysql 3306

    mysql -h ${MYSQL_HOST} -P${MYSQL_PORT} -u root -p${MYSQL_ROOT_PASSWORD}
</code></pre>
<pre><code class="language-console">root@kube-master:# kubectl get pods  --watch
NAME                           READY     STATUS      RESTARTS   AGE
my-sql-mysql-95b597d5b-zd5pm   0/1       Init:0/1    0          5s
ubuntu                         0/1       Completed   0          7m
my-sql-mysql-95b597d5b-zd5pm   0/1       PodInitializing   0         12s
my-sql-mysql-95b597d5b-zd5pm   0/1       Running   0         13s
</code></pre>
<ul>
<li>Once the <strong>my-sql</strong> POD is up and running , your mysql is ready to use</li>
</ul>

<li>
<p>To get your root password run</p>
</li>
</ul>
<pre><code class="language-console">root@kube-master:/home/ansible# MYSQL_ROOT_PASSWORD=$(kubectl get secret --namespace default mysql -o jsonpath=&quot;{.data.mysql-root-password}&quot; | base64 --decode; echo)
root@kube-master:/home/ansible# echo $MYSQL_ROOT_PASSWORD
rootpassword
</code></pre>
<ul>
<li>To connect to your database directly from outside the K8s cluster</li>
</ul>
<pre><code class="language-console">kubectl port-forward svc/mysql 3306
MYSQL_HOST=127.0.0.1
MYSQL_PORT=3306
mysql -h ${MYSQL_HOST} -P${MYSQL_PORT} -u root -p${MYSQL_ROOT_PASSWORD}
</code></pre>

<hr>
<p><h2>Video Demo </h2> </p>
<iframe width="420" height="315"
src="https://youtube.com/embed/ixdQCktXxXA">
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