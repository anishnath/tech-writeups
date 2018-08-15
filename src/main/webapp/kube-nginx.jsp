<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Deploying Secure HTTPS NGINX in Kubernetes">
    <meta name="keywords" content="kubernetes nginx https, setting up ssl in kubernetes nginx, tls1.2 kubernetes, kubernetes configmap, kubernetes secret keys, kubertenes proxy,inotifywait,kubectl get service, edit kubectl service ">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>Deploying Secure HTTPS NGINX in Kubernetes</title>

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
    "@id": "https://8gwifi.org/docs/kube-nginx.jsp"
  },
  "name" : "Deploying Secure HTTPS NGINX in Kubernetes",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "Deploying Secure HTTPS NGINX in Kubernetes",
  "image":"https://8gwifi.org/docs/img/kube-nginx.png",
  "datePublished" : "2018-08-15",
  "dateModified": "2018-08-15",
  "articleSection" : "Deploying Secure HTTPS NGINX in Kubernetes",
  "articleBody" : [ "Definition of Modern TLS","nginx certs and Keys","kubernetes Create Secrets", "kubernetes View Secrets", "Modern TLS nginx configuration", "inotifywait" ,"ConfigMaps","nginx-app.yaml" , "kubectl get service nginxsvc"],
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
          <h1 class="mt-4">Deploying Secure HTTPS NGINX in Kubernetes</h1>

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

<h3 class="mt-4">Introduction </h3>
<p>In this article we will learn how to deploy nginix with modern TLS versions and Cipher suites in Kubernetes. This lab is tested on the this kubernetes versions</p>
<p>This example creates a  nginx https service useful in verifying proof of concept, keys, secrets, configmap, and end-to-end https service creation in kubernetes</p>
<ul>
<li>
<p>Definition of <strong>Modern TLS</strong> Nginx Deployment  :  A modern Nginx webservers should be free of these Vulnerability and only support <strong>TLS1.2</strong></p>
<ul>
<li>CCS injection vulnerability</li>
<li>renegotiation vulnerabilities</li>
<li>CRIME vulnerability</li>
<li>BREACH vulnerability</li>
<li>POODLE (SSL) vulnerability</li>
<li>FREAK vulnerability</li>
<li>BEAST vulnerability</li>
<li>LOGJAM vulnerability</li>
</ul>
</li>
     <hr>
     <li><strong>nginx certs and Keys:</strong> First Generate self signed certificate and private keys, if you have already certificate and keys, then Ignore this step
    <pre><code class="html"> openssl req -newkey rsa:2048 -nodes -keyout nginx.key -x509 -days 365 -out nginx.crt </code></pre>
     </li>
<li>
<p><strong>Create Secrets</strong><br>
In the next steps created secrets for the x.509 certificate and the private key</p>
<pre><code class="html">     kubectl create secret generic <mark>nginx-certs-keys</mark> --from-file=./nginx.crt --from-file=./nginx.key
    secret/nginx-certs-keys created
</code></pre>
</li>
</ul>

<ul>
<li>
<p><strong>View Secrets</strong></p>
<pre><code class="html">    kubectl describe secrets/nginx-certs-keys
  Name:         nginx-certs-keys
  Namespace:    default
  Labels:       &lt;none&gt;
  Annotations:  &lt;none&gt;
  Type:  Opaque
  Data
  ====
  <mark>nginx.crt:  1294 bytes
  nginx.key:  1675 bytes </mark>
</code></pre>
</li>
<li>
<p>Define the Modern TLS nginx configuration file in the</p>
<p><strong>default.conf</strong></p>
<pre><code class="html">   server {
          listen 80 default_server;
          listen [::]:80 default_server ipv6only=on;
          listen 443 ssl;

          root /usr/share/nginx/html;
          index index.html;

      server_name localhost;
      <mark>ssl_certificate /etc/nginx/ssl/nginx.crt;
      ssl_certificate_key /etc/nginx/ssl/nginx.key; </mark>
      ssl_session_timeout 1d;
      ssl_session_cache shared:SSL:50m;
      ssl_session_tickets off;
      # modern configuration. tweak to your needs.
      <mark>ssl_protocols TLSv1.2;
      ssl_ciphers 'ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256';
      ssl_prefer_server_ciphers on; </mark>
      # HSTS (ngx_http_headers_module is required) (15768000 seconds = 6 months)
      add_header Strict-Transport-Security max-age=15768000;
      # OCSP Stapling ---
      # fetch OCSP records from URL in ssl_certificate and cache them
      ssl_stapling on;
      ssl_stapling_verify on;
      location / {
              try_files $uri $uri/ =404;
      }
  }
</code></pre>
</li>
<li>
<p>The <strong>inotifywait</strong> linux command which efficiently waits for changes to files using Linux's inotify(7) interface. It is suitable for waiting for changes to files from shell scripts. It can either exit once an event occurs, or continually execute and output events as they occur</p>
<p>The <strong>auto-reload-nginx.sh</strong> file: This will relaod the nginx configuration whenever any change in <strong>default.conf</strong> detected. This is done by <strong>inotifywait</strong>  </p>
<pre><code class="html">nginx "$@"
		oldcksum=`cksum /etc/nginx/conf.d/default.conf`

		inotifywait -e modify,move,create,delete -mr --timefmt '%d/%m/%y %H:%M' --format '%T' \
		/etc/nginx/conf.d/ | while read date time; do

			newcksum=`cksum /etc/nginx/conf.d/default.conf`
			if [ "$newcksum" != "$oldcksum" ]; then
				echo "At ${time} on ${date}, config file update detected."
				oldcksum=$newcksum
				<mark>nginx -s reload</mark>
			fi

		done</code></pre>
</li>
<li>
<p><strong>ConfigMaps</strong> allow you to decouple configuration artifacts from image content to keep containerized applications portable. This article provides a examples that demonstrate how to create ConfigMaps and configure Pods using data stored in ConfigMaps for nginx</p>
<p> Create <strong>configmap</strong> for nginx <strong>default.conf</strong> file</p>
<pre><code class="html">   kubectl create configmap <mark>nginxconfigmap</mark> --from-file=default.conf
configmap/nginxconfigmap created
</code></pre>
</li>
<li>
<p>Verify the <strong>configmap</strong> file</p>
<pre><code class="html">   kubectl describe  configmap nginxconfigmap
</code></pre>
</li>

<li>
<p>Here is the configuration file for the <strong>nginx-app.yaml</strong> deployment.</p>
<p>When referencing a configMap object, you can simply provide its name in the volume to reference it</p>
<p>The <mark>nginxconfigmap</mark> ConfigMap is mounted as a volume, and all contents stored in its entry are mounted into the Pod at path <strong>"/etc/nginx/conf.d"</strong>. Note that this path is derived from the volume’s mountPath and the path keyed with <mark>configmap-volume</mark></p>
<p>The <mark>nginx-certs-keys</mark> secret is mounted as a volume, and all contents stored in its entry are mounted into the Pod at path <strong>"/etc/nginx/ssl"</strong>. Note that this path is derived from the volume’s mountPath and the path keyed with <mark>secret-volume</mark></p>
<pre><code class="html">  apiVersion: v1
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
---
apiVersion: v1
kind: ReplicationController
metadata:
  name: my-nginx
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: nginx
    spec:
      volumes:
      - name: secret-volume
        secret:
           <mark>secretName: nginx-certs-keys </mark>
      - name: configmap-volume
        configMap:
        <mark>  name: nginxconfigmap </mark>
      containers:
      - name: nginxhttps
        image: ymqytw/nginxhttps:1.5
        command: [&quot;/home/auto-reload-nginx.sh&quot;]
        ports:
        - containerPort: 443
        - containerPort: 80
        livenessProbe:
          httpGet:
            path: /index.html
            port: 80
          initialDelaySeconds: 30
          timeoutSeconds: 1
      <mark>  volumeMounts:
        - mountPath: /etc/nginx/ssl
          name: secret-volume
        - mountPath: /etc/nginx/conf.d
          name: configmap-volume </mark>
</code></pre>
</li>
<li>
<p>Create the service and a replication controller using the configuration in nginx-app.yaml.</p>
<pre><code class="html">   kubectl create -f nginx-app.yml
  service/nginxsvc created
  replicationcontroller/my-nginx created
</code></pre>
</li>
<li>
<p>find the <strong>node port</strong> that Kubernetes is using for <strong>http and https</strong> traffic using the command  <pre><code class="html">kubectl get service nginxsvc -o json</code></pre></p>
</li>

<pre><code class="html">     &quot;spec&quot;: {
            &quot;clusterIP&quot;: &quot;10.103.250.179&quot;,
            &quot;externalTrafficPolicy&quot;: &quot;Cluster&quot;,
            &quot;ports&quot;: [
                {
                    &quot;name&quot;: &quot;http&quot;,
                    <mark>&quot;nodePort&quot;: 32210,</mark>
                    &quot;port&quot;: 80,
                    &quot;protocol&quot;: &quot;TCP&quot;,
                    &quot;targetPort&quot;: 80
                },
                {
                    &quot;name&quot;: &quot;https&quot;,
                   <mark> &quot;nodePort&quot;: 30115,</mark>
                    &quot;port&quot;: 443,
                    &quot;protocol&quot;: &quot;TCP&quot;,
                    &quot;targetPort&quot;: 443 
                }
            ],
            ....
</code></pre>
</ul>
<ul>
<li>
<p>Optionally you can check  the nodeport in the Master node</p>
<pre><code class="html">   netstat -aonp | grep LISTEN  | grep kube-proxy
  tcp        0      0 127.0.0.1:10249         0.0.0.0:*               LISTEN      9087/kube-proxy  off (0.00/0/0)
  <mark>tcp6       0      0 :::30115                :::*                    LISTEN      9087/kube-proxy  off (0.00/0/0) </mark>
  tcp6       0      0 :::10256                :::*                    LISTEN      9087/kube-proxy  off (0.00/0/0)
 <mark> tcp6       0      0 :::32210                :::*                    LISTEN      9087/kube-proxy  off (0.00/0/0) </mark>
</code></pre>
</li>
<li>
<p>Now your service is up and running .  use your browser or type the following commands.</p>
<pre><code class="html">    curl  -k  https://&lt;node-ip&gt;:&lt;nodeport&gt;
</code></pre>
<p>Fetching the HTTP header Information to verify the server is up and serving the file as expected</p>
<pre><code class="html">   curl  -kI  https://0.0.0.0:30115
  HTTP/1.1 200 OK
  Server: nginx/1.11.3
  Date: Tue, 14 Aug 2018 10:12:02 GMT
  Content-Type: text/html
  Content-Length: 804
  Last-Modified: Fri, 26 Aug 2016 20:22:28 GMT
  Connection: keep-alive
  ETag: &quot;57c0a504-324&quot;
  Accept-Ranges: bytes
</code></pre>
</li>
<li>
<p>Changes to <strong>nginxsvc</strong> doesn't requires any restart of the pod, for example remove the port 80 from the deployment, then remove the http port 80  </p>
</li>



      
   
<pre><code class="html">
kubectl edit service/nginxsvc
<strike>port: 80
                protocol: TCP
                name: http</strike></code></pre>
  

<p>then find the node port that Kubernetes is using,  you will be seeing only https port </p> kubectl get service nginxsvc -o json

<pre><code class="html">
        &quot;ports&quot;: [
                {
                    &quot;name&quot;: &quot;https&quot;,
                    &quot;nodePort&quot;: 30286,
                    &quot;port&quot;: 443,
                    &quot;protocol&quot;: &quot;TCP&quot;,
                    &quot;targetPort&quot;: 443
                }
            ],
            </code></pre>
</ul>
<ul>
<li>
<p>Update in <strong>configMap</strong> : This will be needed when there is any change in nginx <strong>default.conf</strong> file. This can be done through</p>
<pre><code class="html">   kubectl create configmap nginxconfigmap --from-file=default.conf -o yaml --dry-run | kubectl apply -f -
  configmap/nginxconfigmap configured
</code></pre>
<p>In this case the  app requires  to be reloaded, or destroy the pod and recreate the pod</p>
<pre><code class="html">   kubectl replace --force -f  nginx-app.yml 
</code></pre>

<p>Thats the purpose of the file <strong>auto-reload-nginx.sh</strong> to reload the nginx configuration if any change detected </p>

</li>
</ul>



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