<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="How to setup kubernetes dashbaord and login with token">
    <meta name="keywords" content="kubernetes dashbaord installation, Verify kubernetes dashboard Service, accessing  kubernetes dashboard ,edit kubernetes dashboard Service,delete kubernetes dashboard Servcie, kubernetes dashbaord login with token,kubernetes interview questions">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>How to setup kubernetes dashbaord</title>

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
    "@id": "https://8gwifi.org/docs/kube-dash.jsp"
  },
  "name" : "How to setup kubernetes dashbaord",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "How to install kubernetes in centos7,fedora,rhel7,ubuntu",
  "image":"https://8gwifi.org/docs/img/kube-dash.png",
  "datePublished" : "2018-07-12",
  "dateModified": "2018-07-12",
  "articleSection" : "How to setup kubernetes dashbaord",
  "articleBody" : [ "Deploy Kubernetes Dashboard","Verify Dashboard Service is running","Describe the Kubernetes Dashboard","Verify the kubernetes-dashboard pods is up and running","The Dashboard UI View","Kubernetes Dashbaord Access","Delete Kubernetes dashboard Servcie","Edit Kubernetes dashboard Service"],
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
          <h1 class="mt-4">kubernetes  Dashboard</h1>

          <!-- Author -->
          <p class="lead">
            by
            <a href="https://www.linkedin.com/in/anishnath">Anish</a>
            <p>Posted on Thursday July 12, 2018</p>
          </p>
          
          <img class="img-fluid rounded" src="img/kube-dash.png" height="400" width="600" alt="Referefce ">
          
          <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>
           
          <hr>

<h3 class="mt-4">Introduction </h3>

<p>This sample chapter extracted from the book,<mark> <a href="https://leanpub.com/crypto">Kubernetes for DevOps </a>. </mark> </p>
<p><mark>Get this book on Just  <a href="https://leanpub.com/kube/" target="_blank" rel="noopener">  $9 </a> or Ask Author for Discount </mark>   </p>
<p><iframe class="embed-responsive-item" width='160' height='400' src='https://leanpub.com/kube/embed' frameborder='0' allowtransparency='true'></iframe></p>

<hr>

<p>Dashboard is a web-based Kubernetes user interface. You can use Dashboard to deploy containerized applications to a Kubernetes cluster, troubleshoot your containerized application, and manage the cluster itself along with its attendant resources. These are the required steps to to bring up the kubernetes  Dashboard</p>

<p>If you have a <strong>$HOME/.kube/config</strong> file, and it's not  listed in your <strong>KUBECONFIG</strong> environment variable, then do the following.</p>
<p><code>export KUBECONFIG=/etc/kubernetes/admin.conf</code></p>

<h3 id="verifydashboardserviceisrunning">Deploy Kubernetes Dashboard</h3>
<p>To deploy run the following command:</p>
<pre><code class="html">kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/aio/deploy/recommended/kubernetes-dashboard.yaml
</code></pre>

<p><strong>The output</strong></p>

<pre><code class="html">secret/kubernetes-dashboard-certs created
serviceaccount/kubernetes-dashboard created
role.rbac.authorization.k8s.io/kubernetes-dashboard-minimal created
rolebinding.rbac.authorization.k8s.io/kubernetes-dashboard-minimal created
deployment.apps/kubernetes-dashboard created
service/kubernetes-dashboard created
</code></pre>

<p>Once the Dashboard is created verify the <strong>svc/deployments</strong> are up and running </p>

<h3 id="verifydashboardserviceisrunning">Verify Dashboard Service is running</h3>

<pre><code class="html">kubectl get services -n kube-system
NAME                   TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)         AGE
kube-dns               ClusterIP   10.96.0.10     &lt;none&gt;        53/UDP,53/TCP   1m
kubernetes-dashboard   ClusterIP   10.101.22.21   &lt;none&gt;        443/TCP         8s
</code></pre>

<h3 id="describethekubernetesdashboard">Describe the Kubernetes Dashboard</h3>
<p>RUn the following command to view the <strong>svc</strong> info </p>

<pre><code class="html">kubectl describe svc/kubernetes-dashboard -n kube-system
</code></pre>

<h3 id="verifythekubernetesdashboardpodsisupandrunning">Verify the kubernetes-dashboard pods is up and running</h3>

<pre><code class="html">kubectl get pods --all-namespaces
NAMESPACE     NAME                                   READY     STATUS    RESTARTS   AGE
kube-system   kubernetes-dashboard-6948bdb78-76686   1/1       Running   0          7m
</code></pre>

<p>You can grant full admin privileges to Dashboard's Service Account by creating below ClusterRoleBinding. Copy the YAML file based on chosen installation method and save as, i.e. dashboard-admin.yaml. Use <p><code>kubectl create -f dashboard-admin.yaml </code></p> to deploy it . Afterwards you can use Skip option on login page to access Dashboard.</p>

<pre><code class="html">cat dashboard-admin.yaml
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: kubernetes-dashboard
  labels:
    k8s-app: kubernetes-dashboard
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: kubernetes-dashboard
  namespace: kube-system
</code></pre>

<pre><code class="html">root@kube-master:/home/ansible# kubectl create -f dashboard-admin.yaml
clusterrolebinding.rbac.authorization.k8s.io/kubernetes-dashboard created
</code></pre>


<h2 id="editkubernetesdashboardservice">The Dashboard UI View</h2>
<p>Using Skip option will make Dashboard use privileges of Service Account used by Dashboard.</p>
<img class="img-fluid rounded" src="img/kube-dash1.png" height="400" width="500" alt="Referefce ">

<h2 id="kubernetesdashbaordaccess">Kubernetes Dashbaord Access</h2>

<p>Set the proxy </p>

<p><code>kubectl proxy --address 0.0.0.0 --accept-hosts '.*'</code></p>
<p><code>Starting to serve on [::]:8001</code></p>

<p>Access the Kubernetes dashboard </p>

<p><code>http://&lt;IP&gt;:&lt;PORT&gt;/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/login</code></p>


<h2 id="kubernetesdashbaordaccess">Kubernetes Dashbaord Authentication using Token</h2>

<p>Create a new ServiceAccount</p>
<pre><code class="html">kubectl create serviceaccount k8sadmin -n kube-system
serviceaccount/k8sadmin created
</code></pre>
<p>Create a ClusterRoleBinding with Cluster Admin Privileges</p>
<pre><code class="html">kubectl create clusterrolebinding k8sadmin --clusterrole=cluster-admin --serviceaccount=kube-system:k8sadmin
clusterrolebinding.rbac.authorization.k8s.io/k8sadmin created</code></pre>
<p>Get the token</p>
<pre><code class="html">kubectl get secret -n kube-system | grep k8sadmin | cut -d " " -f1 | xargs -n 1 | xargs kubectl get secret  -o 'jsonpath={.data.token}' -n kube-system | base64 --decode</code></pre>
<strong>The outout will be base64 decoded Token</strong>
<code>eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9</code>

<br>
<p> Use this <strong>token</strong>  to login to kubernetes dashbaord </p>

<img class="img-fluid rounded" src="img/kube-dash2.png" height="400" width="600" alt="Referefce ">
<img class="img-fluid rounded" src="img/kube-dash3.png" height="400" width="600" alt="Referefce ">

<hr>

<h2 id="deletekubernetesdashboardservcie">Delete Kubernetes dashboard Servcie</h2>

<p>check from where the service needs to be deleted <code>daemonsets,replicasets,services,deployments,pods,rc --all</code></p>

<pre><code class="html">kubectl delete replicasets/kubernetes-dashboard -n kube-system
kubectl delete svc/kubernetes-dashboard -n kube-system
kubectl delete deployments/kubernetes-dashboard -n kube-system
kubectl -n kube-system delete $(kubectl -n kube-system get pod -o name | grep dashboard)
</code></pre>

<hr>

<h2 id="editkubernetesdashboardservice">Edit Kubernetes dashboard Service</h2>

<pre><code class="html">kubectl edit svc/kubernetes-dashboard -n kube-system
</code></pre>

<p><h2>Video Demo </h2> </p>
<iframe width="420" height="315"
src="https://youtube.com/embed/M6mHy0Cx2jE">
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

          <!-- Article Widget -->
         <%@ include file="related-ansible.jsp"%>
         
         <%@ include file="related-kube.jsp"%>
         
         <%@ include file="related-cryptography.jsp"%>
         <%@ include file="related-window-crypto.jsp"%>
         
         <%@ include file="related-linux.jsp"%>
         <%@ include file="related-openstack.jsp"%>
         
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