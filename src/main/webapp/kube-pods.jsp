<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="kubernetes pod,cluster,Deployment,Replica Set DeepDive , adding new node to cluster, token expire">
    <meta name="keywords" content="kubernetes Pod,cluster,Deployment,Replica Set DeepDive, kubernetes tutorial,kubectl get pods ,kubectl scale, kubectl get events, Scale Down the Pods, Adding New Node to Cluster, token expire, creating new token, discovering discovery-token-ca-cert-hash,kubernetes interview questions" >
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>kubernetes Pod,cluster,Deployment,Replica Set Light Dive</title>

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
    "@id": "https://8gwifi.org/docs/kube-pods.jsp"
  },
  "name" : "kubernetes Pod,cluster,Deployment,Replica Set",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "kubernetes Pod,cluster,Deployment,Replica Set Light Dive",
  "image":"https://8gwifi.org/docs/img/kube-arch.png",
  "datePublished" : "2018-07-17",
  "dateModified": "2018-07-17",
  "articleSection" : "kubernetes Pod,cluster,Deployment,Replica Set ",
  "articleBody" : [ "kubernetes Pod,cluster,Deployment,Replica Set","kubectl - Main CLI tool for running commands and managing Kubernetes clusters. so what is the cluster","Kubernetes Terminology","kubectl get all","Dig lighter to kubernetes flow","Scale Up the Pods","Scale Down the Pods","Adding New Node to Cluster"],
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
          <h1 class="mt-3">kubernetes Pod,Cluster,Deployment,Replica Set Light Dive </h1>

          <!-- Author -->
          <p class="lead">
            by
            <a href="https://www.linkedin.com/in/anishnath">Anish</a>
            <p>Posted on Tuesday July 17, 2018</p>
          </p>
          
          <img class="img-fluid rounded" src="img/kube-arch.png" height="400" width="600" alt="kubernetes Arctitcure ">
          
          
          <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>
           
          <hr>

<h3 class="mt-4">Introduction </h3>
<p>In this section we will learn the core concept of <strong>kubernetes</strong>  like <strong>Pod,cluster,Deployment,Replica Set</strong>. The idea is to keep it simple and making more intuitive learning</p>

<p></p>

<p>At the beginning we have setup one master node and minion node </p>

<ol>
<li>kube-master</li>

<li>kube-minion</li>
</ol>

<p><strong>kubectl</strong> - Main CLI tool for running commands and managing Kubernetes clusters. <strong>so what is the cluster</strong></p>

<pre><code class="html">root@kube-master:$ kubectl cluster-info
Kubernetes master is running at https://172.16.9.12:6443
KubeDNS is running at https://172.16.9.12:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
</code></pre>

<p><strong>cluster</strong> consists of at least one <strong>cluster</strong> master and multiple worker machines called <strong>nodes</strong></p>

<p>Verify the <strong>nodes</strong> which has join the cluster </p>

<pre><code class="html">root@kube-master:$ kubectl get nodes 
NAME          STATUS    ROLES     AGE       VERSION
kube-master   Ready     master    18h       v1.11.0
kube-minion   Ready     &lt;none&gt;    18h       v1.11.0
</code></pre>

<hr>

<h2 class="mt-4">Kubernetes API Resources</h2>

<ol>
<li><strong>po</strong>: Pod  :  <strong>Kubernetes pod</strong> is a group of containers that are deployed together on the same host</li>

<li><strong>svc</strong>: Service  : A <strong>Service</strong> in <strong>Kubernetes</strong> is a REST object, similar to a Pod</li>

<li><strong>deploy</strong>: Deployment  : A <strong><em>Deployment</em></strong> controller provides declarative updates for Pods and ReplicaSets</li>

<li><strong>rs</strong>: Replica Set : A <strong><em>ReplicaSet</em></strong> ensures that a specified number of pod replicas are running at any given time</li>
</ol>

<p>Example : List all resources in the name space </p>

<pre><code class="html">kubectl get all
</code></pre>

<p><img class="img-fluid rounded" src="img/kube-intro3.png" height="400" width="600" alt="List all resources in the name space" /></p>

<p>To List all supported resource types along with their <strong>shortnames</strong>, API group, whether they are namespaced, and Kind: run the <code>kubectl api-resources</code></p>

<pre><code class="html">root@kube-master:$ kubectl api-resources
NAME                              SHORTNAMES   APIGROUP                       NAMESPACED   KIND
bindings                                                                      true         Binding
pods                              po                                          true         Pod
services                          svc                                         true         Service
deployments                       deploy       apps                           true         Deployment
replicasets                       rs           extensions                     true         ReplicaSet
clusterroles                                   rbac.authorization.k8s.io      false        ClusterRole
rolebindings                                   rbac.authorization.k8s.io      true         RoleBinding
.......
.......
</code></pre>


<hr>
<h2 class="mt-4">Dig lighter to kubernetes flow</h2>

<p>Start a single instance of <strong>nginx</strong> with one <strong>replicaset</strong> </p>

<pre><code class="html">root@kube-master:$ kubectl run nginx --image=nginx --replicas=1
</code></pre>

<p>The output will be <code>deployment.apps/nginx created</code></p>

<p>Ok, so lets see if we actually have a <strong><em>Kubernetes pods up and running:</em></strong></p>

<pre><code class="html">root@kube-master:$ kubectl get pods
NAME                     READY     STATUS              RESTARTS   AGE
nginx-64f497f8fd-sqmjk   0/1       ContainerCreating   0          12s
</code></pre>

<p>The <strong>container is creating on nginx pod</strong> , again hitting the same command, this time shows pods are up and running</p>

<pre><code class="html">root@kube-master:$ kubectl get pods 
NAME                     READY     STATUS    RESTARTS   AGE
nginx-64f497f8fd-sqmjk   1/1       Running   0          46s
</code></pre>

<p>We can retrieve a lot more information about each of these pods using <code>kubectl describe pod</code>. For example:</p>

<pre><code class="html">root@kube-master:$ kubectl describe pod nginx-64f497f8fd-sqmjk
</code></pre>

<p>There will be big YAML output  </p>

<pre><code class="html">......
 ......
    Containers:
      nginx:
        Container ID:   docker://a7bc2921ca62187778c5f65da4e139516f2701caf32e325cbeef2a1ee082da0b
        Image:          nginx
        Image ID:       docker-pullable://nginx@sha256:a65beb8c90a08b22a9ff6a219c2f363e16c477b6d610da28fe9cba37c2c3a2ac
        Port:           &lt;none&gt;
        Host Port:      &lt;none&gt;
        State:          Running
          Started:      Mon, 16 Jul 2018 18:48:53 +0530
        Ready:          True
        Restart Count:  0
        Environment:    &lt;none&gt;
        Mounts:
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-8wxrj (ro)
</code></pre>

<p>Here you can see configuration information about the <strong>container(s) and Pod (labels, resource requirements, etc.),</strong> as well as <strong>status</strong> information about the container(s) and <strong>Pod (state, readiness, restart count, events, etc.).</strong></p>

<p>The container state is one of <strong>Waiting, Running, or Terminated</strong>. <em>here you can see that for a container in Running state</em>, the system tells you when the container started.</p>

<p><strong>Ready</strong> tells you whether the container passed its last readiness probe.</p>

<p><strong>Look for Events</strong> 
Look for the event generated to perform this action <code>kubectl run nginx --image=nginx --replicas=1</code> in the kubernetes master node </p>

<pre><code class="html">Events:
  Type    Reason     Age   From                  Message
  ----    ------     ----  ----                  -------
  Normal  Scheduled  11m   default-scheduler     Successfully assigned default/nginx-64f497f8fd-7w5mn to kube-minion
  Normal  Pulling    10m   kubelet, kube-minion  pulling image "nginx"
  Normal  Pulled     10m   kubelet, kube-minion  Successfully pulled image "nginx"
  Normal  Created    10m   kubelet, kube-minion  Created container
  Normal  Started    10m   kubelet, kube-minion  Started container
</code></pre>

<p>In the <strong>Minion</strong> node docker images are pulled and container <strong>created and started</strong> , for docker background user can issue docker related command to see how <strong>docker</strong> &amp; <strong>kubernetes</strong> are orchestrating the deployment</p>

<pre><code class="html">root@kube-minion:$ docker images
REPOSITORY  TAG IMAGE ID  CREATED SIZE
nginx latest  8b89e48b5f15  2 hours ago 109 MB
nginx &lt;none&gt;  3c5a05123222  10 days ago 109 MB
</code></pre>

<p>To list all events you can use <code>kubectl get events</code></p>

<p>Get the <strong>deployment configuration</strong> of nginx by the command </p>

<pre><code class="html">root@kube-master:$ kubectl get deployment nginx
NAME      DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
nginx     1         1         1            1           6m
</code></pre>

<ul>
<li><strong>DESIRED</strong>  =1 </li>

<li><strong>CURRENT</strong> =1</li>
</ul>

<p>During the initializing state we have told the kubernetes to <strong>maintain one replica only</strong> by setting the flag <code>--replicas=1</code></p>

<p><strong>Delete the nginx pod</strong>
 to delete the pod <strong>specify the pod name</strong> <br>
 <code>
    root@kube-master:$  kubectl delete pod nginx-64f497f8fd-sqmjk</code></p>

<p>Query on pod still s<strong>hows one pod is running with diffrent id</strong>, this happen because <strong><em>initially we have tell the kuberntes to keep one running replica always</em></strong> <em> Great Kubernetes !!! you have save my production server from accidently destroyed</em></p>

<pre><code class="html">root@kube-master:$ kubectl get pods 
NAME                     READY     STATUS    RESTARTS   AGE
nginx-64f497f8fd-fg9q7   1/1       Running   0          1m
</code></pre>

<hr>

<h2 class="mt-4">Scale Up the Pods</h2>

<p>To scale up the pods tell to kubectl how many current replica is there (<strong>current-replicas</strong>) and how many needs to be scaled  (<strong>replicas</strong>)</p>

<ul>
<li><strong>DESIRED</strong>  =3 </li>

<li><strong>CURRENT</strong> =1</li>
</ul>

<pre><code class="html">root@kube-master:$ kubectl scale --current-replicas=1 --replicas=3 deployment/nginx 
</code></pre>

<p>In the background t<strong>wo new container will get created</strong> and will get deployed </p>

<pre><code class="html">root@kube-master:$ kubectl get pods
NAME                     READY     STATUS              RESTARTS   AGE
nginx-64f497f8fd-brn22   0/1       ContainerCreating   0          17s
nginx-64f497f8fd-fg9q7   1/1       Running             0          2h
nginx-64f497f8fd-z2vbb   0/1       ContainerCreating   0          17s
</code></pre>

<p>After creating the containers check the status of these pods </p>

<pre><code class="html">root@kube-master:$ kubectl get pods
NAME                     READY     STATUS    RESTARTS   AGE
nginx-64f497f8fd-brn22   1/1       Running   0          30s
nginx-64f497f8fd-fg9q7   1/1       Running   0          2h
nginx-64f497f8fd-z2vbb   1/1       Running   0          30s
</code></pre>

<p><strong>Look at the events</strong> </p>

<pre><code class="html">kubectl get events
</code></pre>

<p><img class="img-fluid rounded" src="img/kube-intro1.png"  height="300" width="700" alt="kubectl get events" /></p>

<hr>
<h2class="mt-4">Scale Down the Pods</h2>

<ul>
<li><strong>DESIRED</strong>  =1 </li>

<li><strong>CURRENT</strong> =3</li>
</ul>

<pre><code class="html">root@kube-master:$ kubectl scale --current-replicas=3 --replicas=1 deployment/nginx 
deployment.extensions/nginx scaled
</code></pre>

<p>Pods are <strong>terminating</strong> </p>

<pre><code class="html">root@kube-master:$ kubectl get pods 
NAME                     READY     STATUS        RESTARTS   AGE
nginx-64f497f8fd-fg9q7   1/1       Running       0          2h
nginx-64f497f8fd-fpjk9   0/1       Terminating   0          35s
nginx-64f497f8fd-lk2pw   0/1       Terminating   0          35s
</code></pre>

<p>After scaling down <strong>only one nginx pod is running</strong> </p>

<pre><code class="html">root@kube-master:$ kubectl get pods
NAME                     READY     STATUS    RESTARTS   AGE
nginx-64f497f8fd-fg9q7   1/1       Running   0          2h
</code></pre>

<p><strong>Look at the events</strong> </p>

<p><img class="img-fluid rounded" src="img/kube-intro2.png" height="400" width="600" alt="Look at the events" /></p>

<hr>

<h2 class="mt-4">Adding New Node to Cluster</h2>

<p> To add new node to the <strong>kubernetes</strong> cluster  requires <strong>token</strong> and <strong>discovery-token-ca-cert-hash</strong> </p>

<p>Forget your token :),  first create a token using <strong>kubeadm</strong> command in the kube-master setup, </p>

<pre><code class="html">root@kube-master:$ kubeadm token create 
I0717 10:32:47.753179   22047 feature_gate.go:230] feature gates: &amp;{map[]}
yy8zho.n3w5inti3twy7v0y
</code></pre>

<p>Forget your <strong>discovery-token-ca-cert-hash </strong>,  </p>

<p>Get rooCA cert fingerprint</p>
<pre><code class="html">root@kube-master:$ openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //'
</code></pre>

<p>The outpted discovery-token-ca-cert-hash value<br><code>30e3baf5cb4474b23d5d2500836f6b4da19fa629b64339b1301d3e04892e08aa </code> </p>


<p>Once the Token is created join the new node name  <strong>kube-minion2</strong> using the <strong>token</strong> and <strong>tokencacert</strong> value </p>

<pre><code class="html">root@kube-minion2:$  kubeadm join 172.16.9.12:6443 --token yy8zho.n3w5inti3twy7v0y --discovery-token-ca-cert-hash sha256:30e3baf5cb4474b23d5d2500836f6b4da19fa629b64339b1301d3e04892e08aa
</code></pre>

<p><strong>Checkout for the events</strong>  <code>kubectl get events</code></p>

<p>A set of event shows when adding a new node to the cluster 
<img class="img-fluid rounded" src="img/kube-intro4.png" height="400" width="600" alt="Look at the events" /></p>

<p>Now in this cluster <strong>we have two minion nodes</strong> and one master node </p>

<pre><code class="html">root@kube-master:$ kubectl get nodes
NAME           STATUS    ROLES     AGE       VERSION
kube-master    Ready     master    18h       v1.11.0
kube-minion    Ready     &lt;none&gt;    18h       v1.11.0
kube-minion2   Ready     &lt;none&gt;    2m        v1.11.0
</code></pre>

<p><strong>Again Now scale up the nginx</strong> </p>

<pre><code class="html">kubectl scale --current-replicas=1 --replicas=5 deployment/nginx 
</code></pre>

<p>Look for the Events to verify on the new node pods are created and nginx are deployed</p>

<pre><code class="html">kubectl describe pods | grep kube-minion
</code></pre>

<p><img class="img-fluid rounded" src="img/kube-intro5.png"  height="400" width="600" /></p>

<p>Well thats its for Today hope you have Enjoyed Learnign Kubernetes </p>



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