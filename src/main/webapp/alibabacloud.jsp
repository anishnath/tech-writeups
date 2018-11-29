<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="How to Launch alibaba cloud free trial, aliaba cloud free trial, alibaba cloud laucnh ecs instance, aliababa cloud PayByTraffic">
    <meta name="keywords" content="How to Launch alibaba cloud free trial, aliaba cloud free trial, alibaba cloud laucnh ecs instance, aliababa cloud PayByTraffic, modify vnc password, ssh login to alibaba cloud, alibaba ecs console">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>Alibaba free cloud trial all things to know </title>

    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/blog-post.css" rel="stylesheet">
    
    <link rel="stylesheet"  href="css/highlight/default.min.css">
	<script src="css/highlight/highlight.min.js"></script>
	<script>hljs.initHighlightingOnLoad();</script>
	
	
		<!-- JSON-LD markup generated by Google Structured Data Markup Helper. -->
<script type="application/ld+json">
{
  "@context" : "http://schema.org",
  "@type" : "Article",
  "mainEntityOfPage": {
    "@type": "WebPage",
    "@id": "https://8gwifi.org/docs/alibabacloud.jsp"
  },
  "name" : "Exploring Alibaba ECS Cloud Free Trial",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "Exploring Alibaba ECS Cloud Free Trial",
  "image":"https://8gwifi.org/docs/img/alibabacloud.png",
  "datePublished" : "2018-11-29",
  "dateModified": "2018-11-29",
  "articleSection" : "Exploring Alibaba ECS Cloud Free Trial",
  "articleBody" : ["How to Launch Try now ECS instance","Verifying and Understanding the Configuration and Payment Information.", "Launching ECS Free Trial", "ECS Console" , "Configuration Information", "Payment Information"  , "Managing ECS Instance" , "Test the SSH connectivity Machine alibaba cloud" , "alibaba cloud Change the hostname", "Restart the Server alibaba cloud" , "alibaba Modify VNC Password"],
  "publisher" : {
    "@type" : "Organization",
    "name" : "8gwifi.org Tech Blog",
    "logo" :   {
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
          <h1 class="mt-4">Exploring Alibaba ECS Cloud Free Trial</h1>

          <!-- Author -->
          <p class="lead">
            by
            <a href="https://www.linkedin.com/in/anishnath">Anish</a>
          </p>

          <hr>

          <!-- Date/Time -->
          <p>Posted on Thursday November 29</p>

          <hr>

        
 
          <img class="img-fluid rounded" src="img/alibabacloud.png" alt="Referefce 8gwifi.org">

           <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>

          <hr>

<p>Alibaba cloud computing offers various services which can be tried under free trial aligning with  Alibaba Cloud Terms and services, for more details about the free trial readers can check out <a href="https://www.alibabacloud.com/campaign/free-trial">here</a> .</p>
<p>This article mostly deals with using and exploring Alibaba Cloud Elastic Computing Service under the free trial service. A good place to start and explore the ECS services and understand the core concept of subscription based under the Try now option and finally go with some administrative task of managing the ECS instance.</p>
<h1><a id="Before_you_begin_6"></a>Before you begin</h1>
<p>Make sure you have a valid ECS console login to try out this experiment, if you don't have you can use my ECS registration referral <a href="https://www.alibabacloud.com/referral?referralCode=unxe4p">link</a> .</p>
<h1><a id="What_You_will_learn_10"></a>What You will learn</h1>
<ul>
<li>How to Launch Try now ECS instance</li>
<li>Verifying and Understanding the Configuration and Payment Information.</li>
<li>Billing Type: Subscription</li>
<li>Managing ECS Instance</li>
<li>Changing the root password of the ECS Instance</li>
<li>Changing the VNC password of the ECS Instance</li>
<li>Changing the hostname Information of the ECS Instance</li>
<li>Connecting with ECS instance.</li>
</ul>
<h1><a id="Launching_ECS_Free_Trial_23"></a>Launching ECS Free Trial</h1>
<p>Go to the free trial <a href="https://www.alibabacloud.com/campaign/free-trial">link</a>, choose the desired available option and hit the try now button</p>
<img class="img-fluid rounded" src="img/alibaba/001.png" alt="Referefce 8gwifi.org">
<p>Once you hit the Try now button, you will be prompted with ECS configuration, pay attention to this window,</p>
<img class="img-fluid rounded" src="img/alibaba/002.png" alt="Referefce 8gwifi.org">
<p><strong>Data Center Region</strong>: Alibaba Cloud operates 49 availability zones in 18 regions around the world with more global regions. Choose what is best suited for your need.</p>
<p><strong>ECS Instance Type :</strong> This is read only pre-populated field under free trial for individual the following ECS instances are available:</p>
<ul>
<li>ecs.t5-lc2m1.nano</li>
<li>ecs.t5-lc1m1.small</li>
<li>ecs.t5-lc1m2.small</li>
<li>ecs.t5-lc1m2.large.</li>
</ul>
<p><strong>Operating System:</strong> Based  on the selected region different operating system (image-id) will available to select, choose the appropriate one, I have chosen the ubuntu14.04 to explore it.</p>
<p>Once you satisfy with the ECS configuration hit the <strong>TryNow</strong> button and wait for few minute to get it provision in the Alibaba Cloud Environment.</p>
<p>These following resources will get provision in the background.</p>
<ul>
<li>VPC</li>
<li>VSwitch</li>
<li>Security group</li>
<li>Image/ECS</li>
</ul>
<h1><a id="ECS_Console_55"></a>ECS Console</h1>
<p>Once instance is provisioned go back to the ECS console, in the Elastic Compute Service, overview page, one instance is shown as running, click on the running instance to view additional details.</p>
<img class="img-fluid rounded" src="img/alibaba/003.png" alt="Referefce 8gwifi.org">
<p>Verify the Region name and other configuration launch during the <strong>Try now</strong> step, note don't hesitate to use Alibaba Cloud Ticketing support, if you need any assistance.</p>
<img class="img-fluid rounded" src="img/alibaba/004.png" alt="Referefce 8gwifi.org">
<p>Click on InstanceId/Name to go to next screen, here we go with important attributes around the <strong>configuration Information</strong> and <strong>Payment Information</strong></p>
<hr>
<h2><a id="Configuration_Information_67"></a>Configuration Information</h2>
<img class="img-fluid rounded" src="img/alibaba/005.png" alt="Referefce 8gwifi.org">
<p>The configuration Information tab pane contains information  ECS host information which got provisioned like (vCPUs, Memory, Instance Type, Operating System, Internet IP Address, Private IP Address, <strong>Billing Method</strong>:, Current Bandwidth, VPC, VSwitch).</p>
<p>Take a look at <strong>Billing Method</strong> it shows as <strong>PayByTraffic,</strong> which  will be  default option when you launch with Try Now Option.</p>
<p>Alibaba Cloud only supports postpaid billing for ECS instance Internet bandwidth, which is called <strong>PayByTraffic</strong>. Alibaba Cloud collects the fees on an hourly basis according to actual traffic usage, regardless of ECS instance billing methods and network types. Network bandwidth prices vary among regions .  <a href="https://www.alibabacloud.com/help/doc-detail/25411.htm">Reference</a></p>
<h3><a id="Payment_Information_76"></a>Payment Information</h3>
<p>This tab will show you when your ECS instance is going to be expire from the created date and what is the current Billing Method for this instance.</p>
<img class="img-fluid rounded" src="img/alibaba/006.png" alt="Referefce 8gwifi.org">
<p>Take a look at <strong>Billing Method</strong> it shows as <strong>Subscription,</strong> which  will be  default option when you launch ECS with Try Now Option.</p>
<p>For the Subscription billing method, you can use resources <strong>only after you have paid for them</strong> since this is under free trial.</p>
<p>Alibaba Cloud is giving us these resources for one month (note the field created At and Expire At having one month gap) trial under the Alibaba Cloud Terms and condition.</p>
<ul>
<li>ECS instances, including CPU configuration and memory capacity</li>
<li>Images</li>
<li>System disks and/or data disks</li>
</ul>
<p>To continue using the ECS resource after the billing period has ended, you can renew your ECS instance at the end of a billing period.</p>
<p>You can manually renew your <strong>Subscription</strong> instances when they are in an <strong>Expired</strong> status or are shut down. You can manually renew your instance for a month or a year.</p>
<h2><a id="Managing_ECS_Instance_96"></a>Managing ECS Instance</h2>
<p>Once ECS instance is provisioned, the very first step user usually perform how to login to the instance what's the password. There are many ways to get into the system</p>
<p><strong>Logging with remote SSH</strong></p>
<p>When the ECS instance is provisioned through try now, it setup a security group which will allow you to get into the port 22 and having the internet IP address which can be used from your remote machine to connect, what you need to perform is <strong>reset</strong> the root password. To perform this</p>
<ul>
<li>Select the instance id</li>
<li>Click on Reset Password button</li>
</ul>
<img class="img-fluid rounded" src="img/alibaba/007.png" alt="Referefce 8gwifi.org">
<p>You will be prompted with reset password screen, provide your logon password and submit the Information.</p>
<img class="img-fluid rounded" src="img/alibaba/008.png" alt="Referefce 8gwifi.org">
<p>This requires ECS VM to restart, click on <strong>restart</strong> button and allow machine to be rebooted.</p>
<img class="img-fluid rounded" src="img/alibaba/009.png" alt="Referefce 8gwifi.org">
<h3><a id="Test_the_SSH_connectivity_Machine_119"></a>Test the SSH connectivity Machine</h3>
<p>Once the machine is up and running, try connecting with the remote ssh credential. Once the connection verified you will see this prompt.</p>
<p><code>ssh root@47.88.57.195</code></p>
<pre><code>root@47.88.57.195's password: 
</code></pre>
<pre><code>Welcome to Ubuntu 14.04.5 LTS (GNU/Linux 4.4.0-93-generic x86_64)
</code></pre>
<pre><code> * Documentation:  https://help.ubuntu.com/
</code></pre>
<pre><code>Welcome to Alibaba Cloud Elastic Compute Service !
</code></pre>
<pre><code>root@iZrj93e9d3l6dcp4p7faadZ:~# 
</code></pre>
<h3><a id="Change_the_hostname_145"></a>Change the hostname</h3>
<p>You must have noticed once connected to the ECS instance the hostname is not human readable or identifiable it as random name. Alibaba Cloud ECS service allows you set the hostname administratively to do this you need to perform the below step</p>
<img class="img-fluid rounded" src="img/alibaba/010.png" alt="Referefce 8gwifi.org">
<blockquote>
<p>Select Instance- &gt; Click on more-&gt;Instance Settings-&gt;Modify</p>
</blockquote>
<p>Information as shown in the diagram</p>
<p>It will popup one screen where the <strong>hostname</strong> and <strong>instance name</strong> can be set, note this activity also require restart to come in effect.</p>
<h3><a id="Restart_the_Server_to_change_in_the_effect_160"></a>Restart the Server to change in the effect</h3>
<img class="img-fluid rounded" src="img/alibaba/011.png" alt="Referefce 8gwifi.org">
<p>Once the ECS instance is up and running connect it to verify the hostname is in affect or not.</p>
<pre><code>ssh root@47.88.57.195
</code></pre>
<pre><code>root@47.88.57.195's password: 
</code></pre>
<pre><code>Welcome to Ubuntu 14.04.5 LTS (GNU/Linux 4.4.0-93-generic x86_64)
</code></pre>
<pre><code> * Documentation:  https://help.ubuntu.com/
</code></pre>
<pre><code>Welcome to Alibaba Cloud Elastic Compute Service !
</code></pre>
<pre><code>Last login: Fri Aug 31 12:52:50 2018
</code></pre>
<pre><code>root@webserver-01:~# 
</code></pre>
<h3><a id="Modify_VNC_Password_195"></a>Modify VNC Password</h3>
<p>Alibaba Cloud user can access ECS instance through the ECS instance <strong>connect</strong> option, in case you have forgotten the VNC password, this is step to reset it and then connect it.</p>
<blockquote>
<p>Select Instance-&gt;Click on More-&gt;Password/Keypair-&gt; Modify VNC password</p>
<img class="img-fluid rounded" src="img/alibaba/012.png" alt="Referefce 8gwifi.org">
</blockquote>
<p>This will prompt you choose and confirm new VNC password to connect.</p>
<img class="img-fluid rounded" src="img/alibaba/013.png" alt="Referefce 8gwifi.org">
<p>Once the VNC password is changed, user can hit the connect option to get into the VNC console</p>
<img class="img-fluid rounded" src="img/alibaba/014.png" alt="Referefce 8gwifi.org">
<p>Provide the VNC password for the ECS instance console login.</p>
<img class="img-fluid rounded" src="img/alibaba/014.png" alt="Referefce 8gwifi.org">
<p>Once the password is accepted a console view will be presented to user from where user can connect to the terminal through using the SSH password.</p>
<img class="img-fluid rounded" src="img/alibaba/014.png" alt="Referefce 8gwifi.org">
<h1><a id="Conclusion_219"></a>Conclusion</h1>
<ul>
<li>like any IaaS service provider, the Alibaba Cloud IaaS service provide you resources with the industry standard SLA level, the end user need to familiarize themselves on how the billing work to effectively optimize the cost.</li>
<li>It's important to understand the regions where the services needs to be hosted based on cost/latency and type of service needed.</li>
<li>Importance of raising Ticketing:  if you stuck somewhere to understand the component technically or billing perspective, don't hesitate raise a ticket.</li>
<li>There is no service depreciation under the free trial only the billing work differently.</li>
</ul>
<hr>
<%@ include file="thanks.jsp"%>
          <!-- Comments Form -->
    

          <!-- Single Comment -->
 

          <!-- Comment with nested comments -->
          

        </div>

        <!-- Sidebar Widgets Column -->
        <div class="col-md-4">

          <!-- Ad Widget -->
         <%@ include file="footer_adsense.jsp"%> 

          <!-- Article Widget -->
         <%@ include file="related-linux.jsp"%>
         
           <!-- Article Widget -->
         <%@ include file="related-ansible.jsp"%>
         
         <%@ include file="related-kube.jsp"%>
         
         <%@ include file="related-openstack.jsp"%>
         
         <%@ include file="related-cryptography.jsp"%>
         <%@ include file="related-window-crypto.jsp"%>
         
         
         
         
         <!-- Topic Widget -->
         <%@ include file="side.jsp"%>
         
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

    <!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  </body>

</html>