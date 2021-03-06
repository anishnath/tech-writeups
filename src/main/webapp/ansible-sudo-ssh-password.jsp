<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Ansible passing sudo and ssh password without prompting">
    <meta name="keywords" content="ansible passing sudo password, ansible passing ssh password, ansible playbook ansible_ssh_pass, ansible_become_pass">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>Ansible passing sudo and ssh password without prompting ansible_ssh_pass,ansible_become_pass </title>

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
    "@id": "https://8gwifi.org/docs/ansible-sudo-ssh-password.jsp"
  },
  "name" : "Ansible passing sudo and ssh password without prompting ansible_ssh_pass,ansible_become_pass",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "Ansible User Management, Managing system users using ansible",
  "image":"https://8gwifi.org/docs/img/ansible-sudo-ssh-password.png",
  "datePublished" : "2018-07-03",
  "dateModified": "2018-07-03",
  "articleSection" : "Ansible Privilege Escalation Options , Ansible Passing SSH Connection password, Use ansilbe-playbook to automate the both SSH and SUDO Password, ansible_ssh_pass and ansible_become_pass variables ",
  "articleBody" : [ "Ansible passing sudo and ssh password without prompting"],
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
          <h1 class="mt-4">Ansible passing sudo and ssh password without prompting</h1>

          <!-- Author -->
          <p class="lead">
            by
            <a href="https://www.linkedin.com/in/anishnath">Anish</a>
          </p>

          <hr>

          <!-- Date/Time -->
          <p>Posted on Tuesday July 3rd</p>

          <hr>

        
          <!-- Preview Image 
          <img class="img-fluid rounded" src="http://placehold.it/900x300" alt="">
          -->
           <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>

          <hr>

          <!-- Post Content -->
          

          <p>In this section we will learn how to pass ansible ssh and sudo password using the Ansible variable <strong>ansible_ssh_pass</strong> and <strong>ansible_become_pass</strong> </p>
		  <img class="img-fluid rounded" src="img/ansible-sudo-ssh-password.png" alt="">
		  <h3 class="mt-4">Ansible Privilege Escalation Options </h3>
		  <p><strong>In the Ansible Managed target Node, System Administrator has setup the ansible user password protected to perform SSH and become Sudo </strong></p>
		  <pre><code class="html">[sudo] password for ansible:</code></pre>
		  <p> Since Identity option is not setup when ansible ping fails   </p>
		  <pre><code class="html">[ansible@controller ~]$ 
172.16.9.4 | UNREACHABLE! => {
    "changed": false, 
    "msg": "Failed to connect to the host via ssh: Permission denied (publickey,gssapi-keyex,gssapi-with-mic,password).\r\n", 
    "unreachable": true
}</code></pre>	  

    	  <hr>
		  <h3 class="mt-4">Ansible Passing SSH Connection password</h3>
		  <p>Pass the Connection options <strong>-k, --ask-pass ask </strong> for connection password</p>

		  <pre><code class="html">[ansible@controller ~]$ ansible -m ping all -k 
SSH password: 
172.16.9.4 | SUCCESS => {
    "changed": false, 
    "ping": "pong"
}</code></pre>
		  <h3 class="mt-4">Privilege Escalation Options:</h3>
		  <p>Pass the Privilege options <strong>-K, --ask-become-pass</strong> for to become sudo user</p>
		  <pre><code class="html">[ansible@controller ~]$ ansible -m ping all -k -K
SSH password: 
SUDO password[defaults to SSH password]: 
172.16.9.4 | SUCCESS => {
    "changed": false, 
    "ping": "pong"
}</code></pre>
		  
		  <p> Once the sshagent is setup for on the next ansible run <strong>connection password and priviledge escalaltion option is not required</strong> </p>
		 <pre><code class="html"> [ansible@controller ~]$ ansible -m ping all 
172.16.9.4 | SUCCESS => {
    "changed": false, 
    "ping": "pong"
}</code></pre>
		  
		  

		  <h3 class="mt-4">Use ansilbe-playbook to automate the both SSH and SUDO Password</h3>
          <p>Define the Ansible variable <font color="red">(Unsafe mode use Vault Instead to Protect passwords) </font> in the <strong>group_vars/all.yml</strong>
          <ul>
   <li>	ansible_ssh_pass</li> 
   <li>	non sudoers users </li>
   <li>ansible_become_pass</li>
</ul>
</p>

<pre><code class="html">[ansible@controller ~ ]$ cat group_vars/all.yml 
ansible_ssh_pass: ansible
ansible_become_pass: ansible</code></pre>

<p>Define the <strong>ping</strong> tasks for the ansible playbook with <strong> become true</strong></p>

<pre><code class="html">[ansible@controller opt]$ cat ping.yml 
---
- hosts: all
  gather_facts: false
  become: true
  tasks:
    - ping:</code></pre>

<p>Run the Playbook</p>

<pre><code class="html">[ansible@controller ~ ]$ ansible-playbook ping.yml 
PLAY [all] *********************************************************************

TASK [ping] ********************************************************************
ok: [172.16.9.4]

PLAY RECAP *********************************************************************
172.16.9.4                 : ok=1    changed=0    unreachable=0    failed=0</code></pre>
	 

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