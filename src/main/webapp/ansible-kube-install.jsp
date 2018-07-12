<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="How to install kubernetes using ansible">
    <meta name="keywords" content="kubernetes installation, ansible kubernetes instalaltion, kubernetes dashbaords, kubernetes UI ">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>How to install kubernetes using ansible</title>

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
    "@id": "https://8gwifi.org/docs/ansible-kube-install.jsp"
  },
  "name" : "How to install kubernetes using ansible",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "How to install kubernetes using ansible",
  "image":"https://8gwifi.org/docs/img/ansible-roles.png",
  "datePublished" : "2018-07-08",
  "dateModified": "2018-07-08",
  "articleSection" : "kubernetes installation using ansible",
  "articleBody" : [ "kubernetes installation using ansible, Kubernetes Cluster Configuration" ,"Configure Cluster options", "Deploy the Cluster" ,"Discovering builtin services" ,"Ansible Playbook Target Run"],
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
          <h1 class="mt-4">kubernetes installation using ansible</h1>

          <!-- Author -->
          <p class="lead">
            by
            <a href="https://www.linkedin.com/in/anishnath">Anish</a>
            <p>Posted on Sunday July 8, 2018</p>
          </p>
          
          <img class="img-fluid rounded" src="img/ansible-kube-install.png" alt="8gwifi.org ">
          
           <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>
          <hr>

          <!-- Date/Time -->
          

<p>In this example we will learn how to install <strong>kubernetes</strong> using <strong>ansible</strong> </p>

<p>This demo utilizes the <strong>kubernetes</strong> official <strong>ansible playbook</strong>  </p>

<p>Clone the official Ansible kubernetes repository in the ansible <strong>controller</strong> node </p>

<p><code>git clone https://github.com/kubernetes/contrib.git</code></p>

<h2 class="mt-4">Kubernetes Cluster Configuration</h2>

<ol>
<li>masters</li>

<li>etc</li>

<li>minion</li>
</ol>

<p><strong>Hostname definitions</strong></p>

<p>
<pre><code class="html">
| masters               | etc                   | minion                        |
|-------------------    |-------------------    |-----------------------------  |
| kube-master-node1     | kube-master-node1     | <strong>kube-minion-1</strong> &amp; <strong>kube-minion-2</strong>     |
</code></pre>

</p>

<p>Kubernetes Addon provided by the playbook by <strong>default</strong></p>

<p>
<pre><code class="html">
| Name                     | Descriptions                  |
|----------------------    |-----------------------------  |
| DNS                      | kubedns                       |
| cluster monitoring       | Grafana, Heapster, InfluxDB   |
| cluster logging          | Kibana, ElasticSearch         |
| Kubernetes dashboard     | UI                            |
| Kubernetes dash          | dash UI                       |
</code></pre>
</p>

<p><strong>Lab Setup</strong></p>

<pre><code class="html">[ansible@kube-master ~]# cat /etc/hosts
192.168.1.126 kube-master kube-master-node1
192.168.1.127 node1 kube-minion-1
192.168.1.128 node2 kube-minion-2
</code></pre>

<h2 id="kubernetesinstallationstarted">kubernetes installation started</h2>

<p><strong>Step-1</strong> Install the required dependency 
<code>yum -y install python-netaddr</code></p>

<p><strong>Step-2</strong> Install Ansible &amp; setup required Ansible Keys in<em>* all targeted nodes *</em> make sure it has <strong>sudo</strong> access to the targeted node</p>

<p><code>ansible      ALL=(ALL)       NOPASSWD: ALL</code></p>

<pre><code class="html">[ansible@kube-master ~]ssh-keygen
[ansible@kube-master ~]ssh-copy-id kube-master-node1
[ansible@kube-master ~]ssh-copy-id kube-minion-1
[ansible@kube-master ~]ssh-copy-id kube-minion-1
</code></pre>

<p><strong>Step-3</strong> Go to ansible directory </p>

<pre><code class="html">[ansible@kube-master ~]# cd contrib/ansible
</code></pre>

<p><strong>Step-4</strong> Create the Inventory file and add  <strong>masters,nodes &amp; etcd</strong> hostgroup definitions</p>

<pre><code class="html">[ansible@kube-master ansible]# cat inventory/inventory
[masters]
kube-master-node1
[nodes]
kube-minion-1
kube-minion-2
[etcd:children]
masters
</code></pre>

<h3 id="configureclusteroptions">Configure Cluster options</h3>

<p><strong>Step-5</strong> Check all the configured options <strong>inventory/group_vars/all.yml</strong> and adjust the records of your running enviroment, if you are unclear leave the default ones</p>

<pre><code class="html">cluster_name: cluster.mydns
master_cluster_hostname: kube-master
ansible_ssh_user: ansible
networking: flannel
ansible_ssh_user: DO CONFIGURE YOUR SSH Identity Logins 
etcd_url_scheme: "https"
etcd_client_cert_auth: true
</code></pre>

<h3 id="deploythecluster">Deploy the Cluster</h3>

<p><strong>Step-6</strong> To deploy the cluster run the script, this will install all the <strong>addons</strong> by default </p>

<p><code>[ansible@kube-master contrib]cd scripts/ &amp;&amp; ./deploy-cluster.sh</code></p>

<p>Wait for ansible-playbook Installation to complete </p>

<pre><code class="html">PLAY RECAP ******************************************************************************************************************************
kube-master-node1          : ok=215  changed=30   unreachable=0    failed=0   
kube-minion-1              : ok=115  changed=40   unreachable=0    failed=0   
kube-minion-2              : ok=111  changed=40   unreachable=0    failed=0   
</code></pre>

<h3 id="discoveringbuiltinservices">Discovering builtin services</h3>

<pre><code class="html">[ansible@kube-master ~]# kubectl cluster-info
Kubernetes master is running at http://localhost:8080
Elasticsearch is running at http://localhost:8080/api/v1/proxy/namespaces/kube-system/services/elasticsearch-logging
Heapster is running at http://localhost:8080/api/v1/proxy/namespaces/kube-system/services/heapster
Kibana is running at http://localhost:8080/api/v1/proxy/namespaces/kube-system/services/kibana-logging
KubeDNS is running at http://localhost:8080/api/v1/proxy/namespaces/kube-system/services/kube-dns
Grafana is running at http://localhost:8080/api/v1/proxy/namespaces/kube-system/services/monitoring-grafana
InfluxDB is running at http://localhost:8080/api/v1/proxy/namespaces/kube-system/services/monitoring-influxdb
</code></pre>

<h3 id="ansibleplaybooktargetrun">Ansible Playbook Target Run</h3>

<p>View the available scripts </p>

<pre><code class="html">[ansible@kube-master scripts]# ls -ltr 
total 60
-rw-r--r--. 1 root root   54 Jul  8 03:14 ansible.cfg
-rwxr-xr-x. 1 root root  817 Jul  8 03:14 update-node.sh
-rwxr-xr-x. 1 root root  819 Jul  8 03:14 update-master.sh
-rwxr-xr-x. 1 root root  817 Jul  8 03:14 update-etcd.sh
-rwxr-xr-x. 1 root root  823 Jul  8 03:14 restart-node.sh
-rwxr-xr-x. 1 root root  886 Jul  8 03:14 restart-master.sh
-rwxr-xr-x. 1 root root  800 Jul  8 03:14 restart-etcd.sh
-rwxr-xr-x. 1 root root  733 Jul  8 03:14 deploy-node.sh
-rwxr-xr-x. 1 root root  735 Jul  8 03:14 deploy-master.sh
-rwxr-xr-x. 1 root root 1441 Jul  8 03:14 deploy-local-cluster.sh
-rwxr-xr-x. 1 root root  733 Jul  8 03:14 deploy-etcd.sh
-rwxr-xr-x. 1 root root  735 Jul  8 03:14 deploy-docker.sh
-rwxr-xr-x. 1 root root  735 Jul  8 03:14 deploy-addons.sh
-rwxr-xr-x. 1 root root  736 Jul  8 03:31 deploy-cluster.sh
-rwxr-xr-x. 1 root root 1036 Jul  8 03:39 init.sh
</code></pre>

<p>Targeted Runs can be used to deploy the specific service present in the <strong>inventory</strong> file <br />
<strong>Etcd Deployment</strong> </p>

<p><code>[ansible@kube-master scripts]./deploy-cluster.sh --tags=etcd</code></p>

<p>or</p>

<p><code>[ansible@kube-master scripts]./deploy-etcd.sh</code></p>

<p><strong>Masters Deployment</strong></p>

<p><code>[ansible@kube-master scripts]./deploy-cluster.sh --tags=masters</code></p>

<p>or</p>

<p><code>[ansible@kube-master scripts]./deploy-master</code></p>

<p><strong>Nodes Deployment</strong></p>

<p><code>[ansible@kube-master scripts]./deploy-cluster.sh --tags=nodes</code></p>

<p>or</p>

<p><code>[ansible@kube-master scripts]./deploy-node.sh</code></p>

<p><strong>Check if the cluster is in a Ready state:</strong></p>

<pre><code class="html">[ansible@kube-master ~]# kubectl get nodes
NAME            STATUS    AGE
kube-minion-1   Ready     1h
kube-minion-2   Ready     1h
[root@kube-master ~]# 
</code></pre>

<p><strong>Check if all the pods are running:</strong></p>

<pre><code class="html">[ansible@kube-master ~]# kubectl get pods --all-namespaces
NAMESPACE     NAME                                   READY     STATUS    RESTARTS   AGE
kube-system   elasticsearch-logging-v1-gzfnj         1/1       Running   0          1h
kube-system   elasticsearch-logging-v1-w9gjd         1/1       Running   0          1h
kube-system   fluentd-es-v1.20-4n77d                 1/1       Running   0          1h
kube-system   fluentd-es-v1.20-bvcln                 1/1       Running   0          1h
kube-system   heapster-v1.2.0-3740427991-m4nrr       4/4       Running   0          1h
kube-system   kibana-logging-3645747194-0kf5s        1/1       Running   0          1h
kube-system   kube-dns-v20-f27tg                     3/3       Running   0          1h
kube-system   monitoring-influxdb-grafana-v3-bv79x   2/2       Running   0          1h
</code></pre>

<p><strong>Check the service IP address and ports the sample apps are running:</strong></p>

<pre><code class="html">[ansible@kube-master ~]# kubectl get svc
NAME         CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   10.254.0.1   &lt;none&gt;        443/TCP   1h
</code></pre>

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

          <!-- Article Widget -->
         <%@ include file="related-ansible.jsp"%>
         
         <!-- Kubernnetes related Widget -->
         <%@ include file="related-kube.jsp"%>
         
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