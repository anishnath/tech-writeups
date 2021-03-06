<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="How to install jenkins using podman, podman Jenkins conatiner run">
    <meta name="keywords" content="jenkins in podman , jenkins podman installaion,  jenkins install, jenkins PersistentVolume, podman volume create jenkins">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>How to install jenkins using podman</title>

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
    "@id": "https://8gwifi.org/docs/podman-jenkins.jsp"
  },
  "name" : "Jenkins Installation Using Podman",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "Jenkins Installation Using Podman",
  "image":"https://8gwifi.org/docs/img/podman-jenkins.png",
  "datePublished" : "2020-01-31",
  "dateModified": "2020-01-31",
  "articleSection" : "podman jenkins Installation (helm)",
  "articleBody" : [ "Introduction" ,"podman Installation starts here", "First define the jenkins podman volume " , "podman installation" , "Jenkins Installation"],
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
          <h1 class="mt-4">Jenkins Installation Using Podman</h1>

          <!-- Author -->
          <p class="lead">
            by
            <a href="https://www.linkedin.com/in/anishnath">Anish</a>
            <p>Posted on Friday January 31, 2020</p>
          </p>
          
          <img class="img-fluid rounded" src="img/podman-jenkins.png" height="400" width="500" alt="Referefce ">
          
          <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>
           
          <hr>

<h3 class="mt-4">Introduction </h3>

<p class="has-line-data" data-line-start="2" data-line-end="3">With the Red Hat Enterprise Linux (RHEL) 7.6 Beta released <strong>Podman</strong> was one of the first new features I have found. By offering a similar interface to the Docker command line.</p>
<blockquote>
<p class="has-line-data" data-line-start="4" data-line-end="5"><strong>podman</strong> - Client tool for managing containers. Can replace most features of the <code>docker</code> command for working with individual containers and images</p>
</blockquote>
<p class="has-line-data" data-line-start="8" data-line-end="9">In this example, we are going to install <strong>Jenkins</strong> using podman</p>
<h2 class="code-line" data-line-start=11 data-line-end=12 ><a id="Prerequisite_11"></a>Prerequisite</h2>
<p class="has-line-data" data-line-start="13" data-line-end="14">Installation of Podman on RHEL7/Centos7</p>
<pre><code class="language-console" class="has-line-data" data-line-start="15" data-line-end="18">sudo subscription-manager repos --enable=rhel-7-server-extras-rpms
sudo yum -y install podman
</code></pre>
<p class="has-line-data" data-line-start="19" data-line-end="20">Installation of Podman on RHEL8</p>
<pre><code class="language-console" class="has-line-data" data-line-start="21" data-line-end="24">sudo yum module enable -y container-tools:1.0
sudo yum module install -y container-tools:1.0
</code></pre>
<h2 class="code-line" data-line-start=25 data-line-end=26 ><a id="Jenkins_Installation_25"></a>Jenkins Installation</h2>
<ul>
<li class="has-line-data" data-line-start="27" data-line-end="33">
<p class="has-line-data" data-line-start="27" data-line-end="28">Create the following <a href="https://docs.docker.com/storage/volumes/">volumes</a> to persist the Jenkins data using the following <a href="https://docs.docker.com/engine/reference/commandline/volume_create/"><code>docker volume create</code></a> commands:</p>
<pre><code class="language-console" class="has-line-data" data-line-start="30" data-line-end="32">podman volume create jenkins-data
</code></pre>
</li>
<li class="has-line-data" data-line-start="33" data-line-end="48">
<p class="has-line-data" data-line-start="33" data-line-end="34">Download the <code>jenkinsci/blueocean</code> image and run it as a container in podman using the following <code>podman container run</code>command</p>
<pre><code class="language-console" class="has-line-data" data-line-start="36" data-line-end="47">podman container run \
  --name jenkins-blueocean \
  --rm \
  --detach \
  --privileged \
  --publish 8080:8080 \
  --publish 50000:50000 \
  --volume jenkins-data:/var/jenkins_home \
  --volume jenkins-docker-certs:/certs/client:ro \
  jenkinsci/blueocean
</code></pre>
</li>
<li class="has-line-data" data-line-start="48" data-line-end="56">
<p class="has-line-data" data-line-start="48" data-line-end="49">Check the Jenkins process is up and running</p>
<pre><code class="language-console" class="has-line-data" data-line-start="51" data-line-end="55">[root@localhost ~]# podman ps
CONTAINER ID  IMAGE COMMAND CREATED STATUS PORTS NAMES
41be560345af  docker.io/jenkinsci/blueocean:latest  /sbin/tini -- /us...  4 seconds ago Up 4 seconds ago 0.0.0.0:8080-&gt;8080/tcp  jenkins-blueocean
</code></pre>
</li>
<li class="has-line-data" data-line-start="56" data-line-end="67">
<p class="has-line-data" data-line-start="56" data-line-end="57">Copy the automatically-generated alphanumeric password from the Jenkins container location <code>/var/jenkins_home/secrets/initialAdminPassword</code></p>
<pre><code class="language-console" class="has-line-data" data-line-start="59" data-line-end="63">[root@localhost ~]# podman exec -it 68d350997923 sh
/ # cat /var/jenkins_home/secrets/initialAdminPassword
c5b091551702478eb88bf887a154a64b
</code></pre>
<p class="has-line-data" data-line-start="63" data-line-end="64">or</p>
<pre><code class="language-console" class="has-line-data" data-line-start="65" data-line-end="67">podman logs 68d350997923
</code></pre>
</li>
</ul>
<p class="has-line-data" data-line-start="69" data-line-end="70">Browse to <code>http://localhost:8080</code>  and wait until the <strong>Unlock Jenkins</strong> page appears.</p>
<p class="has-line-data" data-line-start="71" data-line-end="72"><img class="img-fluid rounded" src="img/jenkins_1.png" alt="Unlock Jenkin I"></p>
<ul>
<li class="has-line-data" data-line-start="73" data-line-end="75">Custimze Plugins<br>
<img class="img-fluid rounded" src="img/jenkins_2.png" alt="Customize Jenkins"></li>
<li class="has-line-data" data-line-start="75" data-line-end="76">Once all the Plugins are Installed</li>
<li class="has-line-data" data-line-start="76" data-line-end="79">Create the required admin user<br>
<img class="img-fluid rounded" src="img/jenkins_3.png" alt="Admin User creation for Jenkins"></li>
</ul>
<li>Open the webbrowser and go to address <a href="http://localhost:9000">http://localhost:8080</a></li>
</ul>
<p><img class="img-fluid rounded"  src="img/jenkins.png" alt="Jenkins UI "></p>
<p>All right you have successfully created Jenkins start scheduling the jobs</p>

<hr>
<p> Related Jenkins </p>

<ul>
    <li><a href="kube-jenkins.jsp">How to install jenkins in kubernetes helm </a></li>
</ul>

<hr>
<p><h2>Video Demo </h2> </p>
<iframe width="560" height="315" src="https://www.youtube.com/embed/qGLEuXK46gQ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

<iframe width="560" height="315" src="https://www.youtube.com/embed/42HAiUOJR3M" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


          



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