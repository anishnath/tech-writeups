<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="How to secure nginx in production environment">
    <meta name="keywords" content="nginx secure configuration,Run nginx as non root, letsencrypt nginx directory,nginx Header Security,nginx TLS Config,nginx http2 Support,OCSP Stapling,Handling Buffer Overflow,nginx Redirect http to Https,Subdomain Redirect,nginx Rate Limiting,nginx SELinux,nginx Basic Auth, nginx Syslog Configuration,nginx IPv6 Listen,Configure nginx for PHP,Configure nginx for wordpress,Configure nginx for Drupal,Organize your nginx configuration file in most optimal way">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>How to secure nginx in production environment</title>

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
    "@id": "https://8gwifi.org/docs/nginx-secure.jsp"
  },
  "name" : "How to secure nginx in production environment",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "How to secure nginx in production environment",
  "image":"https://8gwifi.org/docs/img/nginx.png",
  "datePublished" : "2018-07-12",
  "dateModified": "2018-07-12",
  "articleSection" : "Did you Missed Nginx Secure Configuration",
  "articleBody" : [ "Nginx Least Priviledge","OCSP stapling","Nginx HTTP Header Security Parameter","Nginx Set max POST and GET Size","Nginx Rate Limiting","Nginx Adding http2 support on SSL","Nginx TLS Security Parameter with http2 support","LetsEncrypt configuration","Nginx Redirect http to https","Subdomain Redirect","Disable Unwanted HTTP Methods","Basic Auth","Logging to Syslog","Enable Compression","Block unwanted user-agents/robots","Listen to Ipv6","Enable SELinux","PHP Nginx Setting","Wordpress Setting","Drupal Setting","Nginx Modularized File Structure","Reload /Restart Nginx"]
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
          <h1 class="mt-4">Did you Missed Nginx Secure Configuration</h1>

          <!-- Author -->
          <p class="lead">
            by
            <a href="https://www.linkedin.com/in/anishnath">Anish</a>
            <p>Posted on Monday July 30, 2018</p>
          </p>
          
          <img class="img-fluid rounded" src="img/nginx.png" height="400" width="600" alt="Referefce ">
          
          <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>
           
          <hr>

<h2 class="mt-4">Introduction </h3>

<p><mark>This sample chapter </mark> extracted from the book, <a href="https://leanpub.com/crypto">The Modern Cryptograhy CookBook </a>. The Book theme is<mark>Cryptography is for EveryOne. Learn from Crypto Principle to Applied Cryptography With Practical Example</mark> </p>
<p><mark>Get this book on Just  <a href="http://leanpub.com/crypto/c/NPsT3TZmqrNS" target="_blank" rel="noopener">  $9 </a> by availing coupon discount </mark>   </p>
<p><iframe class="embed-responsive-item" width='160' height='400' src='https://leanpub.com/crypto/embed' frameborder='0' allowtransparency='true'></iframe></p>

<hr>
<p>In this article we will go through all the <a href="https://www.nginx.com/resources/wiki/">nginx</a> <strong>Advanced</strong> secure configuration, The example shown in this document is for <strong>nginx.conf</strong> file and can be downloaded from <a href="https://goo.gl/btEbR9">here</a></p>

<h3 class="mt-4">What we will cover </h3>


<table class="table table-striped table-bordered">
<thead>
<tr>
<th>nginx Security</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Least Privilege</td>
<td>Run nginx as non root</td>
</tr>
<tr>
<td>Lets encrypt</td>
<td>ACME Directory Creation</td>
</tr>
<tr>
<td>nginx Header Security</td>
<td>List of HTTP header and Security Configuration</td>
</tr>
<tr>
<td>nginx TLS Config</td>
<td>Nginx <strong>Modern TLS</strong> Ciphersuites and Setting</td>
</tr>
<tr>
<td>HTTP2 Support</td>
<td>Adding <strong>HTTP2</strong> Support with <strong>TLS</strong></td>
</tr>
<tr>
<td>OCSP Stapling</td>
<td><strong><a href="https://en.wikipedia.org/wiki/OCSP_stapling">OCSP</a></strong> Stapling</td>
</tr>
<tr>
<td>Handling Buffer Overflow</td>
<td>nginx module  <strong>client_max_body_size</strong></td>
</tr>
<tr>
<td>Redirect http to Https</td>
<td>Redirect Configuration from <strong>http to Https</strong></td>
</tr>
<tr>
<td>Subdomain Redirect</td>
<td>Redirect all subdomain to secure location</td>
</tr>
<tr>
<td>Rate Limiting</td>
<td>Nginx Rate Limit Modules</td>
</tr>
<tr>
<td>SELinux</td>
<td><strong>selinux</strong> changing the folder location</td>
</tr>
<tr>
<td>Basic Auth</td>
<td><strong>htpasswd</strong> and nginx.conf file</td>
</tr>
<tr>
<td>Syslog Configuration</td>
<td>Redirects logs to <strong>syslog</strong></td>
</tr>
<tr>
<td>Block robots</td>
<td>Block robots/ user-agents</td>
</tr>
<tr>
<td>Enable Compression</td>
<td><strong>gzip</strong>  compression for faster HTML response</td>
</tr>
<tr>
<td>IPv6 Listen</td>
<td>Configure nginx to Listen Over <strong>Ipv6</strong></td>
</tr>
<tr>
<td>Nginx PHP</td>
<td>Configure nginx for <strong>PHP</strong></td>
</tr>
<tr>
<td>Nginx Wordpress Setting</td>
<td>Configure nginx for <strong>wordpress</strong></td>
</tr>
<tr>
<td>Nginx Drupal Setting</td>
<td>Configure nginx for <strong>Drupal</strong></td>
</tr>
<tr>
<td>Nginx Modularized File Structure</td>
<td>Organize your nginx configuration file in most optimal way</td>
</tr>
</tbody>
</table>




<h2 class="mt-4"id="nginxleastpriviledge">Nginx Least Priviledge</h2>

<p>Always start <strong>nginx</strong> process with lease privilege principle (non root user) for example <code>user www-data;</code>  and define <strong>worker_processes</strong> to fully use all the available core. </p>

<pre><code class="html">user www-data; 
pid /run/nginx.pid; 
worker_processes auto; 
worker_rlimit_nofile  65535;
</code></pre>

<h2 class="mt-4"id="ocspstapling">OCSP stapling</h2>

<p>Online Certificate Status Protocol (OCSP) was created as an alternative to the Certificate Revocation List (CRL) protocol. Both protocols are used to check whether an SSL Certificate has been revoked.</p>

<pre><code class="html">ssl_stapling on;
ssl_stapling_verify on;
</code></pre>

<h2 class="mt-4"id="nginxhttpheadersecurityparameter">Nginx HTTP Header  Security Parameter</h2>

<p>These security header will be part of every HTTP response </p>



<table class="table table-striped table-bordered">
<thead>
<tr>
<th>HTTP Header</th>
<th>Value</th>
</tr>
</thead>
<tbody>
<tr>
<td>X-Frame-Options</td>
<td>SAMEORIGIN</td>
</tr>
<tr>
<td>X-XSS-Protection</td>
<td>“1; mode=block”</td>
</tr>
<tr>
<td>X-Content-Type-Options</td>
<td>nosniff</td>
</tr>
<tr>
<td>Referrer-Policy</td>
<td>&quot;no-referrer-when-downgrade</td>
</tr>
<tr>
<td>Content-Security-Policy</td>
<td>default-src * data: 'unsafe-eval' 'unsafe-inline'</td>
</tr>
<tr>
<td>Strict-Transport-Security</td>
<td>max-age=31536000; includeSubDomains; preload</td>
</tr>
<tr>
<td>client_max_body_size</td>
<td>16M</td>
</tr>
<tr>
<td>server</em>tokens</td>
<td>off</td>
</tr>
</tbody>
</table>



<p>Sample Configuration in <strong>nginx</strong></p>

<pre><code class="html">http{
server_tokens off;
client_max_body_size  16M;
server {
.....
        # security headers
        add_header X-Frame-Options "SAMEORIGIN" always;
        add_header X-XSS-Protection "1; mode=block" always;
        add_header X-Content-Type-Options "nosniff" always;
        add_header Referrer-Policy "no-referrer-when-downgrade" always;
        add_header Content-Security-Policy "default-src * data: 'unsafe-eval' 'unsafe-inline'" always;
        add_header Strict-Transport-Security "max-age=31536000; includeSubDomains; preload" always;
......
}
}
</code></pre>

<h2 class="mt-4"id="nginxsetmaxpostandgetsize">Nginx Set max POST and GET Size</h2>

<p>Sets the maximum allowed size of the client <strong>request body, header and buffer size</strong>, to prevent any buffer overflow attack</p>

<pre><code class="html">http{
    client_max_body_size  16M;
    client_header_buffer_size 1k;
    client_body_buffer_size 2k;
    }
</code></pre>

<h2 class="mt-4"id="nginxratelimiting">Nginx Rate Limiting</h2>

<p>Protect the <strong>webserver</strong> by rate-limiting in case of DoS or DDoS Attack , Rate limiting is configured with two main directives, <code>limit_req_zone</code> and <code>limit_req</code>, as in this</p>

<pre><code class="html"># limits 
limit_req_log_level warn; 
limit_req_zone $binary_remote_addr zone=login:10m rate=10r/m;
</code></pre>

<p>There could be several <code>limit_req</code> <a href="https://www.nginx.com/blog/rate-limiting-nginx/">directives</a>. For example, the following configuration will limit the processing rate of requests coming from a single IP address and, at the same time, the request processing rate by the virtual server:</p>

<p>10 MB (<code>10m</code>) will give us enough space to store a history of 160k requests. It will only allow 1 request per second (<code>1r/s</code>).</p>

<pre><code class="html">limit_req_zone $binary_remote_addr zone=perip:10m rate=1r/s;
limit_req_zone $server_name zone=perserver:10m rate=10r/s;

server {
    ...
    limit_req zone=perip burst=5 nodelay;
    limit_req zone=perserver burst=10;
}
</code></pre>



<h2 class="mt-4"id="nginxaddinghttp2supportonssl">Nginx Adding  http2 support on SSL</h2>

<p><a href="http://nginx.org/en/download.html">NGINX 1.13.9</a>, released on February 20, 2018, includes support for HTTP/2 server push. change the Listening Port and Enabling HTTP/2</p>

<pre><code class="html"> http{ 
.......
.......
server {
    listen 443 ssl http2; 
    listen [::]:443 
    ssl http2;  
    }
}
</code></pre>

<h2 class="mt-4"id="nginxtlssecurityparameterwithhttp2support">Nginx TLS  Security Parameter with http2 support</h2>

<p>Nginx <strong>Modern</strong> TLS Security configuration</p>

<pre><code class="html"> http{ 
 .......
 # SSL 
 ssl_session_timeout 1d; 
 ssl_session_cache shared:SSL:50m; 
 ssl_session_tickets off; 
 # Diffie-Hellman parameter for DHE ciphersuites 
 ssl_dhparam /etc/nginx/dhparam.pem; 
 # Secure Configuration
 ssl_protocols TLSv1.2; 
 ssl_ciphers ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256; 
 ssl_prefer_server_ciphers on;
.......
server {
    listen 443 ssl http2; 
    listen [::]:443 
    ssl http2;  
    server_name example.com; 
    root /var/www/example.com/public; 
    ssl_certificate /etc/letsencrypt/live/example.com/fullchain.pem; 
    ssl_certificate_key /etc/letsencrypt/live/example.com/privkey.pem; 
    ssl_trusted_certificate /etc/letsencrypt/live/example.com/fullchain.pem;
}
}
</code></pre>

<h2 class="mt-4"id="tlscertificateprovider">TLS certificate Provider</h2>

<p>In case Certificate Type in your environment is  <strong><a href="https://letsencrypt.org/">Letsencrypt</a></strong> then  <strong>create ACME-challenge common directory</strong> in nginx </p>

<h2 class="mt-4"id="letsencryptconfiguration">LetsEncrypt configuration</h2>

<pre><code class="html"># HTTPS: create Diffie-Hellman keys
openssl dhparam -dsaparam -out /etc/nginx/dhparam.pem 2048

# HTTPS: create ACME-challenge common directory
sudo -u www-data sh -c "mkdir -p /var/www/_letsencrypt"

# HTTPS: certbot (obtain certificates)
# disable before first run: ssl_certificate, ssl_certificate_key, ssl_trusted_certificate
certbot certonly --webroot -d www.example.com --email hello@example.com -w /var/www/_letsencrypt -n --agree-tos --force-renewal
</code></pre>

<p>Add the ACME-challenge in the <strong>nginx.conf</strong> </p>

<pre><code class="html">            # ACME-challenge
            location ^~ /.well-known/acme-challenge/ {
                root /var/www/_letsencrypt;
            }
</code></pre>

<h2 class="mt-4"id="forcustomcertificates">For Custom Certificates</h2>

<p>In case certificate is Managed by the <strong>admin</strong>, then using the <strong><a href="http://nginx.org/en/docs/http/ngx_http_ssl_module.html">ssl_certificate</a></strong> and <strong>ssl_certificate_key</strong> nginx module to pass the certificate and private key information</p>

<pre><code class="html">server {
......
ssl_certificate /etc/nginx/ssl/example.com.crt;
ssl_certificate_key /etc/nginx/ssl/example.com.key;
......
} 
</code></pre>

<h2 class="mt-4"id="nginxredirecthttptohttps">Nginx Redirect http to https</h2>

<p>For redirecting HTTP requests to HTTPS, to enforce the use of SSL certificates.  </p>

<p>Two Use cases:  </p>

<ol>
<li><p>All <strong>http</strong> request and redirect to <strong>https</strong>  </p>

<pre><code class="html">server {
        listen 80;
        listen [::]:80;
        server_name .example.com;
        # ACME-challenge
        location ^~ /.well-known/acme-challenge/ {
            root /var/www/_letsencrypt;
        }
        location / {
            return 301 https://example.com$request_uri;
        }
    }
</code></pre></li>
</ol>

<ul>
<li><p>Redirect only specific <strong>application</strong> for example <strong>/admin</strong></p>

<pre><code class="html">server {
        listen 80;
        listen [::]:80;
        server_name .example.com;
        # ACME-challenge
        location ^~ /.well-known/acme-challenge/ {
            root /var/www/_letsencrypt;
        }
        location /admin {
            return 301 https://example.com$request_uri;
        }
        location / {
            try_files $uri $uri/ /index.html;
        }<pre><code class="html">}
</code></pre></code></pre></li>
</ul>

<h2 class="mt-4"id="subdomainredirect">Subdomain Redirect</h2>

<p>In case subdomain redirect is required for example <code>*.example.com;</code> to be redirected to <strong>secure</strong> domain </p>

<pre><code class="html">server {
        listen 80;
        listen [::]:80;
        server_name *.example.com;
        return 301 https://example.com$request_uri;
    }
</code></pre>

<h2 class="mt-4"id="disableunwantedhttpmethods">Disable Unwanted HTTP Methods</h2>

<p>Allow only <strong>HTTP</strong> Method that are critical to system. </p>

<pre><code class="html">add_header Allow "GET, POST, HEAD" always;
if ( $request_method !~ ^(GET|POST|HEAD)$ ) {
return 405;
}
</code></pre>

<h2 class="mt-4"id="basicauth">Basic Auth</h2>

<p>The <strong>.htpasswd</strong>  (<strong>/etc/nginx/.htpasswd;</strong>) file contains username in plain text (unencrypted) and a hashed (encrypted) password. Here’s an example:</p>

<pre><code class="html">$ htpasswd .htpasswd anish
New password:
Re-type new password:
Adding password for user anish
$ cat .htpasswd
anish:$apr1$LYYduqJF$hfJCFCi1YTI0yDKeChe4e0
</code></pre>

<p>Always generating <strong>crypt</strong>  <strong>hash</strong> password considered secure.</p>

<pre><code class="html">htpasswd -nbB anish myPasswod
anish:$2y$05$SlyzABkvPEWrDQYIPX97oer49DXOX5gcD/j2TvfdxhLrw7I.QRV62
</code></pre>

<p>For Nginx Basic Auth configure these two <strong>AUTH</strong> modules</p>

<ul>
<li><strong>auth_basic</strong></li>

<li><strong>auth<em>basic</em>user_file</strong></li>
</ul>

<p>Example </p>

<pre><code class="html">location / {
        auth_basic "Restricted Content";
        auth_basic_user_file /etc/nginx/.htpasswd;
    }
</code></pre>

<h2 class="mt-4"id="loggingtosyslog">Logging to Syslog</h2>

<p><strong>nginx</strong> configuration for  <strong>syslog</strong>  the <code>unix:/dev/log</code> is the UNIX socket </p>

<pre><code class="html">server { 
    access_log syslog:server=unix:/dev/log; 
    error_log syslog:server=unix:/dev/log; 
}
</code></pre>

<p>based on the OS, the logging will be captured on <strong>either</strong> of these files </p>

<pre><code class="html">/var/log/syslog (Ubuntu)
/var/log/messages (EL-6.x/7.x)
/var/log/secure (EL 5.x)
</code></pre>

<h2 class="mt-4"id="enablecompression">Enable Compression</h2>

<p>Compressing your HTML files is an easy way to reduce the amount of data transferred from NGINX to the browser</p>

<pre><code class="html">gzip gzip on; 
gzip_vary on; 
gzip_proxied any;
gzip_comp_level 6; 
gzip_types text/plain text/css text/xml application/json application/javascript application/xml+rss application/atom+xml image/svg+xml;
</code></pre>

<h2 class="mt-4"id="blockunwanteduseragentsrobots">Block unwanted user-agents/robots</h2>

<p>Deny Certain User-Agents or Bots. denying user-agents and bots in Nginx it is very easy and can be performed anytime, you can easily block any bots, spammers web-scanners that may attack your server:</p>

<pre><code class="html">if ($http_user_agent ~   
(msnbot|Purebot|Baiduspider|Lipperhey|Mail.Ru|scrapbotBaiduspider|Yandex|DirBuster|libwww|"")) {
        return 403;
     }
</code></pre>

<h2 class="mt-4"id="listentoipv6">Listen to Ipv6</h2>

<p>To Listen Secure Server in <strong>Ipv6</strong>  address </p>

<pre><code class="html">listen 443 ssl; 
listen [2001:420:c0e0:1008::33]:443 ssl;
</code></pre>

<p>The ipv6 localhost is <code>::1</code>. The unspecified address is :: </p>

<pre><code class="html">listen [::]:443 
</code></pre>

<h2 class="mt-4"id="enableselinux">Enable SELinux</h2>

<p>Ensure that SELinux is running in enforcing mode globally.</p>

<pre><code class="html">setenforce 1
</code></pre>

<p>Default SELinux policy labels nginx and its associated files and ports with domain (type) <code>httpd_t</code>. You can use <a href="http://linux.die.net/man/1/sesearch">sesearch</a> to investigate the policy and see what port types httpd<em>t can name</em>bind to</p>

<pre><code class="html">sesearch --allow -s httpd_t | grep name_bind
</code></pre>

<p>Observed the Output </p>

<pre><code class="html">allow httpd_t http_port_t : tcp_socket name_bind ;
allow httpd_t http_port_t : udp_socket name_bind ;
</code></pre>

<p>Check the SELinux Managed ports </p>

<pre><code class="html">semanage port -l | grep http_port_t
http_port_t                    tcp      80, 443
</code></pre>

<p>In case the app directly is moved to new location for example <code>/opt/myapp</code> then user needs to change the <strong>semanage</strong> <strong>fcontext</strong> to the new directory followed by <strong>restorecon</strong></p>

<pre><code class="html">semanage fcontext -at httpd_sys_rw_content_t "/opt/myapp(/.*)?"
restorecon -R -v '/var/local/myapp' 
</code></pre>

<h3 class="mt-4"id="fullworkingexample">Full Working Example</h3>

<p>Summary of Key Configuration (Least Privilege, server tokens, header security, client limits, server tokesn off , ssl, http2, rate limits )</p>

<pre><code class="html">    user www-data;
    pid /run/nginx.pid;
    worker_processes auto;
    worker_rlimit_nofile 65535;

    events {
        multi_accept on;
        worker_connections 65535;
    }

     http {

     charset utf-8;
     sendfile on;
     tcp_nopush on;
     tcp_nodelay on;
     types_hash_max_size 2048;
     client_max_body_size 16M;

    # MIME
    include mime.types;
    default_type application/octet-stream;

    # logging
    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log warn;

    # limits
    limit_req_log_level warn;
    limit_req_zone $binary_remote_addr zone=login:10m rate=10r/m;

    # SSL
    ssl_session_timeout 1d;
    ssl_session_cache shared:SSL:50m;
    ssl_session_tickets off;

    # Diffie-Hellman parameter for DHE ciphersuites
    ssl_dhparam /etc/nginx/dhparam.pem;

    # Modern TLS configuration
    ssl_protocols TLSv1.2; 
    ssl_ciphers ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256; 
    ssl_prefer_server_ciphers on;

    # OCSP Stapling
    ssl_stapling on;
    ssl_stapling_verify on;
    resolver 8.8.8.8 8.8.4.4 208.67.222.222 208.67.220.220 valid=60s;
    resolver_timeout 2s;
    # load configs
    include /etc/nginx/conf.d/*.conf;
    # www.example.com
    server {
        listen 443 ssl http2;
        listen [::]:443 ssl http2;
        server_name www.example.com;
        root /var/www/example.com/public;
        # SSL
        ssl_certificate /etc/letsencrypt/live/example.com/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/example.com/privkey.pem;
        ssl_trusted_certificate /etc/letsencrypt/live/example.com/fullchain.pem;
        # index.html fallback
        location / {
            try_files $uri $uri/ /index.html;
        }
        # security headers
        add_header X-Frame-Options "SAMEORIGIN" always;
        add_header X-XSS-Protection "1; mode=block" always;
        add_header X-Content-Type-Options "nosniff" always;
        add_header Referrer-Policy "no-referrer-when-downgrade" always;
        add_header Content-Security-Policy "default-src * data: 'unsafe-eval' 'unsafe-inline'" always;
        add_header Strict-Transport-Security "max-age=31536000; includeSubDomains; preload" always;

        # . files
        location ~ /\. {
            deny all;
        }

        # assets, media
        location ~* \.(?:css(\.map)?|js(\.map)?|jpe?g|png|gif|ico|cur|heic|webp|tiff?|mp3|m4a|aac|ogg|midi?|wav|mp4|mov|webm|mpe?g|avi|ogv|flv|wmv)$ {
            expires 7d;
            access_log off;
        }

        # svg, fonts
        location ~* \.(?:svgz?|ttf|ttc|otf|eot|woff|woff2)$ {
            add_header Access-Control-Allow-Origin "*";
            expires 7d;
            access_log off;
        }

        # gzip
        gzip on;
        gzip_vary on;
        gzip_proxied any;
        gzip_comp_level 6;
        gzip_types text/plain text/css text/xml application/json application/javascript application/xml+rss application/atom+xml image/svg+xml;
    }

    # HTTP redirect
    server {
        listen 80;
        listen [::]:80;
        server_name .example.com;
        # ACME-challenge
        location ^~ /.well-known/acme-challenge/ {
            root /var/www/_letsencrypt;
        }
        location / {
            return 301 https://www.example.com$request_uri;
        }
    }
    }
</code></pre>
<h2 class="mt-4"id="phpnginxsetting">PHP Nginx Setting</h2>

<p>php <strong>fastcgi_pass</strong> setting for Plain TCP and Various PHP version sockets </p>

<table class="table table-striped table-bordered">
<thead>
<tr>
<th>PHP version</th>
<th>fastcgi_pass</th>
</tr>
</thead>
<tbody>
<tr>
<td>TCP</td>
<td>127.0.0.1:9000</td>
</tr>
<tr>
<td>PHP 5.x Socket</td>
<td><strong>fastcgi_pass</strong> unix:/var/run/php5-fpm.sock</td>
</tr>
<tr>
<td>PHP 7.0 Socket</td>
<td><strong>fastcgi_pass</strong> unix:/var/run/php/php7.0-fpm.sock</td>
</tr>
<tr>
<td>PHP 7.1 Socket</td>
<td><strong>fastcgi_pass</strong> unix:/var/run/php/php7.1-fpm.sock</td>
</tr>
<tr>
<td>PHP 7.2 Socket</td>
<td><strong>fastcgi_pass</strong> unix:/var/run/php/php7.2-fpm.sock</td>
</tr>
<tr>
<td>PHP 7.3 Socket</td>
<td><strong>fastcgi_pass</strong> unix:/var/run/php/php7.3-fpm.sock</td>
</tr>
</tbody>
</table>

<p>Add the <strong>location</strong>  directive for php <strong>extensions handlers</strong></p>

<pre><code class="html">server{
........
location ~ \.php$ {
            try_files $uri =404;

        # fastcgi
        fastcgi_pass                unix:/var/run/php/php7.2-fpm.sock;
        fastcgi_index               index.php;
        fastcgi_split_path_info     ^(.+\.php)(/.+)$;
        fastcgi_param               SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param               PHP_ADMIN_VALUE open_basedir=$base/:/usr/lib/php/:/tmp/;
        fastcgi_intercept_errors    off;
        fastcgi_buffer_size             128k;
        fastcgi_buffers                 256 16k;
        fastcgi_busy_buffers_size       256k;
        fastcgi_temp_file_write_size    256k;

        # default fastcgi_params
        include fastcgi_params;
    }
    # . files
    location ~ /\. {
        deny all;
    }

    # assets, media
    location ~* \.(?:css(\.map)?|js(\.map)?|jpe?g|png|gif|ico|cur|heic|webp|tiff?|mp3|m4a|aac|ogg|midi?|wav|mp4|mov|webm|mpe?g|avi|ogv|flv|wmv)$ {
        expires 7d;
        access_log off;
    }
    # svg, fonts
    location ~* \.(?:svgz?|ttf|ttc|otf|eot|woff|woff2)$ {
        add_header Access-Control-Allow-Origin "*";
        expires 7d;
        access_log off;
    }
......
}
</code></pre>

<h2 class="mt-4"id="wordpresssetting">Wordpress Setting</h2>

<p>Add additional <strong>location</strong> directive in <strong>addition to the PHP setting</strong>  , p.s <code>include _php_fastcgi.conf;</code></p>

<pre><code class="html">    # WordPress: allow TinyMCE
    location = /wp-includes/js/tinymce/wp-tinymce.php {
        include _php_fastcgi.conf;
    }

    # WordPress: deny wp-content, wp-includes php files
    location ~* ^/(?:wp-content|wp-includes)/.*\.php$ {
        deny all;
    }

    # WordPress: deny wp-content/uploads nasty stuff
    location ~* ^/wp-content/uploads/.*\.(?:s?html?|php|js|swf)$ {
        deny all;
    }

    # WordPress: deny wp-content/plugins nasty stuff
    location ~* ^/wp-content/plugins/.*\.(?!css(\.map)?|js(\.map)?|ttf|ttc|otf|eot|woff|woff2|svgz?|jpe?g|png|gif|ico|cur|heic|webp|tiff?|mp3|m4a|aac|ogg|midi?|wav|mp4|mov|webm|mpe?g|avi|ogv|flv|wmv|pdf|docx?|xlsx?|pptx?) {
        deny all;
    }

    # WordPress: deny scripts and styles concat
    location ~* \/wp-admin\/load-(?:scripts|styles)\.php {
        deny all;
    }

    # WordPress: deny general stuff
    location ~* ^/(?:xmlrpc\.php|wp-links-opml\.php|wp-config\.php|wp-config-sample\.php|wp-comments-post\.php|readme\.html|license\.txt)$ {
        deny all;
    }

    # WordPress: throttle wp-login.php
    location = /wp-login.php {
        limit_req zone=login burst=2 nodelay;
        include _php_fastcgi.conf;
    }
</code></pre>

<p>The <strong>/etc/nginx/<em>php</em>fastcgi.conf</strong> file</p>

<pre><code class="html">try_files $uri =404;
# fastcgi
fastcgi_pass                unix:/var/run/php/php7.2-fpm.sock;
fastcgi_index                index.php;
fastcgi_split_path_info        ^(.+\.php)(/.+)$;
fastcgi_param                SCRIPT_FILENAME $document_root$fastcgi_script_name;
fastcgi_param                PHP_ADMIN_VALUE open_basedir=$base/:/usr/lib/php/:/tmp/;
fastcgi_intercept_errors    off;

fastcgi_buffer_size                128k;
fastcgi_buffers                    256 16k;
fastcgi_busy_buffers_size        256k;
fastcgi_temp_file_write_size    256k;

# default fastcgi_params
include fastcgi_params;
</code></pre>

<h2 class="mt-4"id="drupalsetting">Drupal  Setting</h2>

<p>Add additional <strong>location</strong> directive in <strong>addition to the PHP setting</strong>  </p>

<pre><code class="html">    # Drupal: deny private files
    location ~ ^/sites/.*/private/ {
        deny all;
    }

    # Drupal: deny php in files
    location ~ ^/sites/[^/]+/files/.*\.php$ {
        deny all;
    }

    # Drupal: deny php in vendor
    location ~ /vendor/.*\.php$ {
        deny all;
    }

    # Drupal: throttle user functions
    location ~ ^/user/(?:login|register|password) {
        limit_req zone=login burst=2 nodelay;
        try_files $uri /index.php?$query_string;
    }
}
</code></pre>

<h2 class="mt-4"id="ngninxmodularizedfilestructure">Nginx Modularized File Structure</h2>

<p>Maintaining <strong>nginx</strong> configuration in a single file become cumbersome, if more rules is added , Separate the config file in <strong>modularized way</strong> </p>

<ul>
<li><strong>/etc/nginx/nginx.conf</strong></li>

<li><strong>/etc/nginx/sites-enabled/example.com.conf</strong></li>

<li><strong>/etc/nginx/_general.conf</strong></li>
</ul>

<p>The <strong>/etc/nginx/nginx.conf</strong>  file included with <strong>sites-enabled</strong> directory</p>

<blockquote>
  <p>include /etc/nginx/sites-enabled/*;</p>
</blockquote>

<pre><code class="html">user www-data;
pid /run/nginx.pid;
worker_processes auto;
worker_rlimit_nofile 65535;

events {
    multi_accept on;
    worker_connections 65535;
}

http {
    charset utf-8;
    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    server_tokens off;
    log_not_found off;
    types_hash_max_size 2048;
    client_max_body_size 16M;

# MIME
include mime.types;
default_type application/octet-stream;

# logging
access_log /var/log/nginx/access.log;
error_log /var/log/nginx/error.log warn;

# SSL
ssl_session_timeout 1d;
ssl_session_cache shared:SSL:50m;
ssl_session_tickets off;

# modern configuration
ssl_protocols TLSv1.2;
ssl_ciphers ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256;
ssl_prefer_server_ciphers on;

# OCSP Stapling
ssl_stapling on;
ssl_stapling_verify on;
resolver 8.8.8.8 8.8.4.4 208.67.222.222 208.67.220.220 valid=60s;
resolver_timeout 2s;

# load configs
include /etc/nginx/conf.d/*.conf;
include /etc/nginx/sites-enabled/*;
</code></pre>

<p>}</p>

<p>The <strong>/etc/nginx/sites-enabled/example.com.conf</strong> which <strong>include _general.conf;</strong></p>

<pre><code class="html">server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name example.com;
    root /var/www/example.com;
    # SSL
    ssl_certificate /etc/nginx/ssl/example.com.crt;
    ssl_certificate_key /etc/nginx/ssl/example.com.key;
    include _general.conf;
}
# HTTP redirect
server {
    listen 80;
    listen [::]:80;
    server_name .example.com;
    return 301 https://example.com$request_uri;
}
</code></pre>

<p>The <strong>/etc/nginx/_general.conf</strong></p>

<pre><code class="html"># security headers
add_header X-Frame-Options "SAMEORIGIN" always;
add_header X-XSS-Protection "1; mode=block" always;
add_header X-Content-Type-Options "nosniff" always;
add_header Referrer-Policy "no-referrer-when-downgrade" always;
add_header Content-Security-Policy "default-src * data: 'unsafe-eval' 'unsafe-inline'" always;
add_header Strict-Transport-Security "max-age=31536000; includeSubDomains; preload" always;
# . files
location ~ /\. {
    deny all;
}
# assets, media
location ~* \.(?:css(\.map)?|js(\.map)?|jpe?g|png|gif|ico|cur|heic|webp|tiff?|mp3|m4a|aac|ogg|midi?|wav|mp4|mov|webm|mpe?g|avi|ogv|flv|wmv)$ {
    expires 7d;
    access_log off;
}
# svg, fonts
location ~* \.(?:svgz?|ttf|ttc|otf|eot|woff|woff2)$ {
    add_header Access-Control-Allow-Origin "*";
    expires 7d;
    access_log off;
}
# gzip
gzip on;
gzip_vary on;
gzip_proxied any;
gzip_comp_level 6;
gzip_types text/plain text/css text/xml application/json application/javascript application/xml+rss application/atom+xml image/svg+xml;
</code></pre>

<h2 class="mt-4"id="reloadrestartnginx">Reload /Restart Nginx</h2>

<p>After Configuration Verify the Nginx Conf files and then restart it</p>

<p>Check for syntax errors</p>

<pre><code class="html">sudo nginx -t
</code></pre>

<p>if no synax error then restart nginx 
For EL 7.x </p>

<pre><code class="html">sudo systemctl restart nginx
</code></pre>

<p>For EL 6.x </p>

<pre><code class="html">sudo service  nginx restart 
</code></pre>

<%@ include file="footer_adsense.jsp"%> 
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

		 <%@ include file="related-cryptography.jsp"%>
		 <%@ include file="related-window-crypto.jsp"%>
          <!-- Article Widget -->
         <%@ include file="related-ansible.jsp"%>
         
         <%@ include file="related-kube.jsp"%>
         
         
         
         <%@ include file="related-openstack.jsp"%>
         <%@ include file="related-linux.jsp"%>
         
         
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