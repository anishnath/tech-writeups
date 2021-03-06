<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="How to run ansible windows module win_ping,win_shell">
    <meta name="keywords" content="How to run ansible windows module, ansible windows ping pong, ansible windows shell, ping windows using ansible ">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>How to run ansible windows module win_ping,win_shell</title>

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
    "@id": "https://8gwifi.org/docs/ansible-windows.jsp"
  },
  "name" : "How to run ansible windows module",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "How to install kubernetes using ansible",
  "image":"https://8gwifi.org/docs/img/ansible-roles.png",
  "datePublished" : "2019-07-25",
  "dateModified": "2019-07-25",
  "articleSection" : "How to run ansible windows module",
  "articleBody" : [ "How to run ansible windows module", "ansible windows ping pong" ,"ansible windows shell command" ,"Ansible Playbook Target Run"],
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
          <h1 class="mt-4">How to run Ansible Windows Module</h1>

          <!-- Author -->
          <p class="lead">
            by
            <a href="https://www.linkedin.com/in/anishnath">Anish</a>
            <p>Posted on Tuesday June 25, 2019</p>
          </p>
          
          <!-- <img class="img-fluid rounded" src="img/ansible-kube-install.png" alt="8gwifi.org "> -->
          
           <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>
          <hr>

          <!-- Date/Time -->
          

<p>Ansible Windows module uses winrm connection, in order to execute commands in the Windows machine. There are many module supported by the <a href="https://docs.ansible.com/ansible/latest/modules/list_of_windows_modules.html">ansible</a></p>
<p>Let's setup a BASIC ping-pong using <strong>win_ping</strong> module</p>
<p>This is the directory struture we are going to build</p>
<pre><code class="html">
|--group_vars
|------all.yml
|--hosts
|--test.yml
</code></pre>
<p>The <strong>all.yml</strong> file in the group_vars directory will hold necessary credentials for Windows Authentication. When setting up the inventory, the following variables are required:</p>
<pre><code class="language-console">---
ansible_ssh_user: &quot;Administrator&quot;
ansible_ssh_pass: &quot;Administrator&quot;
ansible_ssh_port: &quot;5985&quot;
ansible_connection: &quot;winrm&quot;
ansible_winrm_server_cert_validation: ignore
</code></pre>
<ul>
<li>By default <strong>WinRM :</strong> The default HTTP port is 5985.</li>
<li>By default,  <strong>basic</strong> Authentication or if kerberos module is installed it will use kerberos.</li>
</ul>
<p>The <strong>test.yml</strong> is the ansible-playbook which is using <strong>win_ping</strong> module to. A windows version of the classic ping module</p>
<pre><code class="language-console">---
- hosts: win
  tasks:
   - name: Ping Windows Hosts
     win_ping:
</code></pre>
<p>Run the Playbook</p>
<pre><code class="language-console">$ ansible-playbook  test.yml  -i hosts
PLAY [win] **********************************************************************************************************************************************************
TASK [Gathering Facts] **********************************************************************************************************************************************
ok: [10.65.148.49]
TASK [Ping Windows Hosts] *******************************************************************************************************************************************
ok: [10.65.148.49]
PLAY RECAP **********************************************************************************************************************************************************
10.65.148.49 : ok=2 changed=0  unreachable=0  failed=0  skipped=0  rescued=0  ignored=0
</code></pre>
<p>We tested sucessfully ping command, now jump to another ansible windows module <strong>win_shell</strong> which will help to execute any  command in windows from the controller node.</p>
<p>Here is the sample ansible-playbook for <strong>win_shell.yml</strong></p>
<pre><code class="language-console">---
- hosts: win
  tasks:
  - name: Execute command in Windows
    win_shell: dir
    args:
        executable: cmd
    register: out

  - debug: var=out.stdout_lines
</code></pre>
<p>Run the playbook.</p>
<pre><code class="language-console">$ ansible-playbook  win_shell.yml  -i hosts 

PLAY [win] **********************************************************************************************************************************************************

TASK [Gathering Facts] **********************************************************************************************************************************************
ok: [10.65.148.49]

TASK [Execute command in Windows] ***********************************************************************************************************************************
changed: [10.65.148.49]

TASK [debug] ********************************************************************************************************************************************************
ok: [10.65.148.49] =&gt; {
    &quot;out.stdout_lines&quot;: [
        &quot; Volume in drive C has no label.&quot;, 
        &quot; Volume Serial Number is D0D0-E635&quot;, 
        &quot;&quot;, 
        &quot; Directory of C:\\Users\\Administrator&quot;, 
        &quot;&quot;, 
        &quot;06/24/2019  04:03 AM    &lt;DIR&gt;          .&quot;, 
        &quot;06/24/2019  04:03 AM    &lt;DIR&gt;          ..&quot;, 
        &quot;06/17/2019  08:45 PM    &lt;DIR&gt;          Contacts&quot;, 
        &quot;06/17/2019  08:45 PM    &lt;DIR&gt;          Desktop&quot;, 
        &quot;06/17/2019  08:45 PM    &lt;DIR&gt;          Documents&quot;, 
        &quot;06/17/2019  08:45 PM    &lt;DIR&gt;          Downloads&quot;, 
        &quot;06/17/2019  08:45 PM    &lt;DIR&gt;          Favorites&quot;, 
        &quot;06/17/2019  08:45 PM    &lt;DIR&gt;          Links&quot;, 
        &quot;06/17/2019  08:45 PM    &lt;DIR&gt;          Music&quot;, 
        &quot;06/17/2019  08:45 PM    &lt;DIR&gt;          Pictures&quot;, 
        &quot;06/17/2019  08:45 PM    &lt;DIR&gt;          Saved Games&quot;, 
        &quot;06/17/2019  08:45 PM    &lt;DIR&gt;          Searches&quot;, 
        &quot;06/17/2019  08:45 PM    &lt;DIR&gt;          Videos&quot;, 
        &quot;               0 File(s)              0 bytes&quot;, 
        &quot;              13 Dir(s)  64,714,444,800 bytes free&quot;
    ]
}
PLAY RECAP **********************************************************************************************************************************************************
10.65.148.49               : ok=3    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
</code></pre>

<p><h2>Video Demo </h2> </p>
<iframe width="420" height="315"
src="https://youtube.com/embed/1ulFFEz1Q8M">
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
         <%@ include file="related-ansible.jsp"%>
         
         <!-- Kubernnetes related Widget -->
         
         
         <%@ include file="related-linux.jsp"%>
         
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