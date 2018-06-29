<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Ansible User Management, Managing system users using ansible, Ansible Controller,Target Node setup">
    <meta name="keywords" content="Ansible User Management, Managing system users using ansible, ansible authorized_keys, ansible user module, ansible creating sudoers users, ansible /etc/sudoers files">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>Ansible User Management, Managing system users using ansible, Ansible Controller,Target Node setup</title>

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
    "@id": "https://8gwifi.org/docs/ansible-manage-system-users.jsp"
  },
  "name" : "Ansible User Management, Managing system users using ansible",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "Ansible User Management, Managing system users using ansible",
  "image":"https://8gwifi.org/docs/img/ansible-manage-system-users.jpg",
  "datePublished" : "2018-06-28",
  "dateModified": "2018-06-28",
  "articleSection" : "Ansible User Management, Managing system users using ansible, Ansible User Setup in Controller Node, Ansible User Setup in Target Node, Ansible User Module",
  "articleBody" : [ "Managing System Users Operations Perspective", "Managing System User Using Ansible", "Adding System Users using Ansible user module" ,"Removing System Users using Ansible"],
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
          <h1 class="mt-4">Ansible User Management, Managing system users using ansible </h1>

          <!-- Author -->
          <p class="lead">
            by
            <a href="https://www.linkedin.com/in/anishnath">Anish</a>
          </p>

          <hr>

          <!-- Date/Time -->
          <p>Posted on Friday June 29</p>

          <hr>

        
          <!-- Preview Image 
          <img class="img-fluid rounded" src="http://placehold.it/900x300" alt="">
          -->
           <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>

          <hr>

          <!-- Post Content -->
          <h3 class="mt-4">Introduction </h3>

          <p>In this section we will learn how to manage users using Ansible in Alicloud environment , we will start by defining the architecture, as shown in this diagram, Ansible controller node is managing various nodes using SSH protocol, extending this diagram we are going to create playbooks which will manage different users with their sudoers privilege in the target node</p>
		  <img class="img-fluid rounded" src="img/ansible-manage-system-users.png" alt="">
		  
		 <p> <b> A quick recap of creating and setting up ansible user in controller and target node</b></p>
		 
		 <h3 class="mt-4">Ansible User Setup in Controller Node</h3>
		 
		  <p>Create <strong>ansible</strong> remote user to manage the installation from Ansible Controller node. This user should have appropriate <strong>sudo</strong> privileges. An example sudoers entry is given below <p>
		  
		  <p>Add user ansible</p>
		  <pre><code class="html">[root@controller-node] adduser ansible</code></pre>
		  <p>Switch to ansible User</p>
		  <pre><code class="html">[root@controller-node] su - ansible</code></pre>
		  <p>Generate a strong SSH-keyPair for ansible user</p>
		  <pre><code class="html">[ansible@controller-node]ssh-keygen -t rsa -b 4096 -C "ansible"</code></pre>
		  <p>copy the id_rsa.pub file, to the target node Ansible /home/ansible.ssh/home directory</p>
		  <pre><code class="html">[ansible@controller-node]cd /home/ansible/.ssh/</code></pre>
		  <pre><code class="html">[ansible@controller-node .ssh]$ ls
id_rsa  id_rsa.pub</code></pre>
		  <p><strong>Note down the public Key (id_rsa.pub) and copy it over in the Other machines</strong></p>
		  <pre><code class="html">[ansible@controller-node .ssh]$ cat id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAgEApeDUYGwaMfHd7/Zo0nzHA69uF/f99BYktwp82qA8+osph1LdJ/NpDIxcx3yMzWJHK0eg2yapHyeMpKuRlzxHHnmc99lO4tHrgpoSoyFF0ZGzDqgtj8IHS8/6bz4t5qcs0aphyBJK5qUYPhUqAL2Sojn+jLnLlLvLFwnv5CwSYeHYzLPHU7VWJgkoahyAlkdQm2XsFpa+ZpWEWTiSL5nrJh5aA3bgGHGJU2iVDxj2vfgPHQWQTiNrxbaSfZxdfYQx/VxIERZvc5vkfycBHVwanFD4vMn728ht8cE4VjVrGyTVznzrM7XC2iMsQkvmeYTIO2q2u/8x4dS/hBkBdVG/fjgqb78EpEUP11eKYM4JFCK7B0/zNaS56KFUPksZaSofokonFeGilr8wxLmpT2X1Ub9VwbZV/ppb2LoCkgG6RnDZCf7pUA+CjOYYV4RWXO6SaV12lSxrg7kvVYXHOMHQuAp8ZHjejh2/4Q4jNnweciuG3EkLOTiECBB0HgMSeKO4RMzFioMwavlyn5q7z4S82d/yRzsOS39qwkaEPRHTCg9F6pbZAAVCvGXP4nlyrqk26KG7S3Eoz3LZjcyt9xqGLzt2frvd+jLMpgvnlXTFgGA1ITExOHRb+FirmQZgnoiFbvpeIFj65d0vRIuY6VneIJ6EFcLGPpzeus0yLoDN1v8= ansible

[ansible@controller-node $ exit
[root@controller-node $ exit</code></pre>
		  <p>Update the <strong>/etc/sudoers.d </strong> and add the <strong>ansible user</strong> to manage controller node itself<p>
		  <pre><code class="html">[root@controller-node $ visudo 
		#includedir /etc/sudoers.d
		ansible      ALL=(ALL)       NOPASSWD: ALL</code></pre>	  

    	  <hr>
		  <h3 class="mt-4">Ansible User Setup in Target Node</h3>
		  <p>Create user <strong>ansible</strong> and create a file named <strong>authorized_keys</strong> in the <strong>.ssh</strong> directory and change its <strong>file permissions to 600</strong> (only the owner can read or write to the file).</p>

		  <pre><code class="html">[root@nod1]sudo adduser ansible
[root@node1]sudo su - ansible
[ansible ~]$ cd /home/ansible
[ansible ~]$ mkdir .ssh
[ansible ~]$ touch authorized_keys
[ansible ~]$ chmod 600 authorized_keys
</code></pre>
		  <p>Copy the <strong>SSH public key (id_rsa.pub) </strong> from the ansible controller node and add it to all the VM which is managed by controller node</p>
		  <pre><code class="html">[ansible@localhost ~]$ ssh-copy-id ansible@node3
/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
</code></pre>
		  <pre><code class="html">bin/ssh-copy-id: WARNING: All keys were skipped because they already exist on the remote system.</code></pre>

		  <h3 class="mt-4">Managing System Users Operations Perspective</h3>
          <p>Managing user in the cloud environment like Alicloud is security as well as Infrastructure requirement, In general we deal with these set of users
          <ul>
   <li>	sudo users</li> 
   <li>	non sudoers users </li>
   <li>nologin users (System users)</li>
</ul>
</p>

	 
<p>For security hardening the servers running on Alicloud should only accept password less logins, through change management process like (git) all the users have submitted their public key and they are ready to deployed in respective nodes through Ansible controller</p>
     
     <h4 class="mt-4">Managing System User Using Ansible</h4>
     <p>In the first section we will add the users , in the next section we will learn how to delete the users </p>
     <h5 class="mt-4">Adding System Users using Ansible user module </h5>
     <p>1.	Create the directory structure in the controller which should looks like this </p>
     <pre><code class="html">[ansible@controller]$ tree
-- ssh
    + files
    + tasks
    +  -- main.yml
    + vars
</code></pre>
          
          <p> Common Definition </strong>   </p>
          <p>
          
          <ul>
          <li>ssh : is the Role for ansible-playbook </li>
          <li>files:  In this directory place all the user public key  </li>
          <li>tasks: The main.yaml file will get executed when this role is run   </li>
          <li>vars: In this directory the user definition will store    </li>
          </ul>
          </p>
          
          <p>2.	create the file users.yml and add the list of user which needs <strong>sudo aceess</strong> and <strong> which doesn't need sudo access</strong> </p>
          <pre><code class="html">[ansible@controller]$ tree
.
-- ssh
    -- files
    -- tasks
    +   -- main.yml
    -- vars
        -- users.yml 
</code></pre>
          <pre><code class="html">[ansible@controller]$ cat ssh/vars/users.yml 
---
users:

  - username: user2
    use_sudo: yes

  - username: user4
    use_sudo: no

  - username: user6
    use_sudo: no
          </code></pre>

 <p> 3.	Now submit public key of users example <strong>(user2/user4&user6) </strong> in the <strong>files</strong> directory ,  the files directory should looks like this   </p>
 <pre><code class="html">[ansible@controller]$ tree
.
-- ssh
    -- files
    +   --- user2.pub
    +   --- user4.pub
    +   --- user6.pub
    --  tasks
    +   --- main.yml
    --  vars
        --- users.yml

4 directories, 5 files
</code></pre>
 
  <p> 4.	Next task is define the playbook run under the tasks directory edit the file <strong>main.yml</strong> add the following definition   </p>
  <pre><code class="html">[ansible@ ~]$ cat  ssh/tasks/main.yml 
---
  - include_vars: users.yml

  
  - name: Create users with home directory
    user: name={{ item.username }} shell=/bin/bash createhome=yes comment='Created by Ansible'
    with_items: '{{users}}'

  - name: Setup | authorized key upload
    authorized_key: user={{ item.username }}
      key="{{ lookup('file', 'files/{{ item.username }}.pub') }}"
    when: '{{ item.use_sudo }} == True'
    with_items: '{{users}}'

  - name: Sudoers | update sudoers file and validate
    lineinfile: "dest=/etc/sudoers
      insertafter=EOF
      line='{{ item.username }} ALL=(ALL) NOPASSWD: ALL'
      regexp='^{{ item.username }} .*'
      state=present"
    when: '{{ item.use_sudo }} == True'
    with_items: '{{users}}'
</code></pre>
  
  <p> Let's break down the code 
  <ul>
  <l1>1)	First all the ansible variable is included </l1>
<l1>2)	Using the ansible user module creating users from the user lists (users.yml)</l1>
<l1>3)	Using the ansible authorized_key adding the ssh public key to the created user home directory</l1>
<l1>4)	Finally uploading the sudoers entry file which users should be granter sudoers access which doesn't </l1>
  </ul>
   </p>
   
   <p><strong>Run the playbook </strong> </p>
   <p>To run this playbook make sure we have the ansible inventory file is setup , Ansible inventory file is group of servers, for this example I have create a inventory file name <strong>hosts</strong> and added all the nodes to it, which I need to managed </p>
   
  <pre><code class="html">[ansible@ ~]$ tree
+  hosts
+  ssh
    -- files
    +   --- user2.pub
    +   --- user4.pub
    +   --- user6.pub
    + tasks
    +   --- main.yml
    + vars
        --- users.yml
4 directories, 6 files
</code></pre>
  <pre><code class="html">[ansible@~]$ cat hosts
[all]
node1
node2
node3
[ansible@localhost ansible]$
</code></pre>
  
  <p>Next we will create ssh.yml to tell ansible-playbook use role ssh,  </p>
  <pre><code class="html">[ansible@~]$ cat ssh.yml 
# To Run this Playbook Issue the command
#Author Anish Nath
# ansible-playbook ssh.yml 
---
- hosts: all
  become: yes
  gather_facts: yes
  roles:
    - { role: ssh }
  </code></pre>

<p>Finally run the playbook using the inventory hosts   </p>
<pre><code class="html">[ansible@controller]$ ansible-playbook ssh.yml -i hosts </code></pre>
<p>Snippptes of the code output </p>
<pre><code class="html">ok: [node3] => (item={u'username': u'user2', u'use_sudo': True})
skipping: [node3] => (item={u'username': u'user4', u'use_sudo': False}) 
skipping: [node3] => (item={u'username': u'user6', u'use_sudo': False}) 
ok: [node1] => (item={u'username': u'user2', u'use_sudo': True})
skipping: [node1] => (item={u'username': u'user4', u'use_sudo': False}) 
skipping: [node1] => (item={u'username': u'user6', u'use_sudo': False}) 
ok: [node2] => (item={u'username': u'user2', u'use_sudo': True})
skipping: [node2] => (item={u'username': u'user4', u'use_sudo': False}) 
skipping: [node2] => (item={u'username': u'user6', u'use_sudo': False}) 

PLAY RECAP *************************************************************************************************************************************
node1                      : ok=5    changed=1    unreachable=0    failed=0   
node2                      : ok=5    changed=1    unreachable=0    failed=0   
node3                      : ok=5    changed=1    unreachable=0    failed=0
</code></pre>
<hr>
<h5 class="mt-4">Removing System Users using Ansible </h5>
<p>In the Alicloud cloud environment, user has a lifecycle, if the user is no longer required to be present in the system the user must be deleted, and this should happen proactivaley, for an example  "user2" user needs to deleted, then from the change management process, users.yml files needs to edited to remove the entry of user2</p>

<p> Before </p>
<pre><code class="html">[ansible@controller]$ cat ssh/vars/users.yml 
---
users:
  - username: user2
    use_sudo: yes
  - username: user4
    use_sudo: no
  - username: user6
    use_sudo: no
</code></pre>

<p> After Deleting  </p>

<pre><code class="html">[ansible@controller]$ cat ssh/vars/users.yml 
[ansible@controller]$ cat ssh/vars/users.yml 
---
users:
  - username: user4
    use_sudo: no

  - username: user6
    use_sudo: no
</code></pre>

<p> Now this user needs to be delete across the Alicloud environment which is managed by Ansible controller, to do this create a file deleteusers.yml in the vars directory and maintain a set of users which needs to be removed from the target node </p>
<pre><code class="html">[ansible@controller ~]$ cat ssh/vars/deleteusers.yml 
---
users:
  - username: user2
  - username: user3
  - username: user5
</code></pre>
<p> Next update the <strong>main.yml</strong> which is present in tasks and add the delete instructions using  </p>
<pre><code class="html">- include_vars: deleteusers.yml

  - name: Deleting The users
    user: name={{ item.username }} state=absent remove=yes
    with_items: '{{users}}'
</code></pre>

<p> Finally run the playbook using the inventory hosts  </p>
<pre><code class="html">[ansible@controller ~]$ ansible-playbook ssh.yml -i hosts</code></pre>
<p><strong>Notice : </strong> the delete tasks  executed by this playbook run and removed user2 from ansible managed nodes</p>
<pre><code class="html">TASK [ssh : Deleting The users] ****************************************************************************************************************
changed: [node2] => (item={u'username': u'user2'})
changed: [node1] => (item={u'username': u'user2'})
changed: [node3] => (item={u'username': u'user2'})</code></pre>

<p><strong> Thanku for reading !!!</strong></p>


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