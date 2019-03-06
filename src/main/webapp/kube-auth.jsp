<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Kubernetes Authentication, Authorization  Admission Control, kubernetes service accounts, kubernetes rbac, kubernetes role and rolebinding">
    <meta name="keywords" content="Kubernetes Authentication, Authorization  Admission Control, rbac in kubernetes, setting up users and rbac in kubernetes, kubernetes role and rolebinding,kubernetes tutorial, kubernetes by examples, kubernetes interview questions ">
    <meta name="author" content="Anish nath">
    <meta name="robots" content="index,follow" />
	<meta name="googlebot" content="index,follow" />
	<meta name="resource-type" content="document" />
	<meta name="classification" content="tools" />
	<meta name="language" content="en" />

    <title>Kubernetes Authentication, Authorization  Admission Control</title>

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
    "@id": "https://8gwifi.org/docs/kube-auth.jsp"
  },
  "name" : "Kubernetes Namespace",
  "author" : {
    "@type" : "Person",
    "name" : "Anish"
  },
  "headline": "Kubernetes Authentication, Authorization & Admission Control",
  "image":"https://8gwifi.org/docs/img/auth.png",
  "datePublished" : "2019-02-12",
  "dateModified": "2019-02-12",
  "articleSection" : "Kubernetes Authentication, Authorization Admission Control",
  "articleBody" : [ "Kubernetes Authentication, Authorization Admission Control", "Kubernetes TLS Security" , "Authentication", "ServiceAccounts", "User Accounts", "Authorization" , "Admission Control"]
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
          <h1 class="mt-4">Kubernetes Authentication, Authorization &amp; Admission Control</h1>

          <!-- Author -->
          <p class="lead">
            by
            <a href="https://www.linkedin.com/in/anishnath">Anish</a>
            <p>Posted on Tuesday February 12, 2019</p>
          </p>
          
          <img class="img-fluid rounded" height="800" src="img/auth.png"  alt="Referefce ">
          
          <%@ include file="footer_adsense.jsp"%>
           <%@ include file="analytics.jsp"%>
           
          <hr>

<h3 class="mt-4">Introduction </h3>

<p>Multiple steps involved to by the Kubernetes API server, before granting/revoking access for the managed kubernetes resources. it's start with</p>
<h4><a id="TLS_Security_6"></a>TLS Security</h4>
<p>Kubernetes cluster, the API serves on port 443. The API server presents a certificate. This certificate is often self-signed, so <code>$USER/.kube/config</code> on the user's machine typically contains the root certificate for the API server's certificate, which when specified is used in place of the system default root certificate</p>
<p>As shown in the below example the API server is running on the port <code>6443</code></p>
<pre><code class="language-html">root@kube-master:# kubectl cluster-info
Kubernetes master is running at https://172.16.2.13:6443
KubeDNS is running at https://172.16.2.13:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
</code></pre>
<p>by default the kubernetes admin X.509 CA certificate, Private Key and Certificate revocation list is present in the in the <code>KUBE_HOME=/etc/kubernetes/</code> directory</p>
<pre><code class="language-html">root@kube-master:# ls -l /etc/kubernetes/pki/ca.*
-rw-r--r-- 1 root root 1025 Jan 23 11:14 /etc/kubernetes/pki/ca.crt
-rw------- 1 root root 1679 Jan 23 11:14 /etc/kubernetes/pki/ca.key
-rw-r--r-- 1 root root   17 Feb  7 13:15 /etc/kubernetes/pki/ca.srl
</code></pre>
<h4><a id="Authentication_27"></a>Authentication</h4>
<p>Once you have located the API server, next step is to perform the Authentication, there are two kind of resources which access the kubernetes API server</p>
<ul>
<li>Service Account</li>
<li>Normal User</li>
</ul>
<p><strong>User</strong> and <strong>serviceAccount</strong>  can belongs to one or more groups, groups are designed to grant permission to several users at once, there are <strong>reserved</strong> built-in group in the <strong>kube-system</strong> <a href="kube-namespaces.jsp">namespace</a></p>
<ul>
<li>
<p>The <code>system:unauthenticated</code> group is used for requests where none of the authentication plugins could authenticate the client.</p>
</li>
<li>
<p>The <code>system:authenticated</code> group is automatically assigned to a user who was authenticated successfully.</p>
</li>
<li>
<p>The <code>system:serviceaccounts</code> group encompasses all ServiceAccounts in the system.</p>
</li>
<li>
<p>The <code>system:serviceaccounts:&lt;<a href="kube-namespaces.jsp">namespace</a>&gt;</code> includes all ServiceAccounts in a specific <a href="kube-namespaces.jsp">namespace</a>.</p>
</li>
</ul>
<p><strong>ServiceAccounts</strong></p>
<p><strong>ServiceAccounts</strong>  are kubernetes managed resources and are scope to individual <a href="kube-namespaces.jsp">namespaces</a>. for example let's <code>GET</code> all the <code>sa</code>  available in the kube-system.</p>
<pre><code class="language-html">root@kube-master:# kubectl get sa -n kube-system
NAME                                 SECRETS   AGE
attachdetach-controller              1         20d
bootstrap-signer                     1         20d
certificate-controller               1         20d
clusterrole-aggregation-controller   1         20d
coredns                              1         20d
cronjob-controller                   1         20d
daemon-set-controller                1         20d
default                              1         20d
..............
..............
</code></pre>
<ol>
<li><strong>Creating ServiceAccounts</strong></li>
</ol>
<p>Let's create a <code>sa</code> under the <a href="kube-namespaces.jsp">namespace</a> <code>dev</code></p>
<pre><code class="language-html">root@kube-master:# kubectl create sa test -n dev
serviceaccount/test created
</code></pre>
<p>List out the <code>sa</code> under the <a href="kube-namespaces.jsp">namespace</a> <code>dev</code></p>
<pre><code class="language-html">root@kube-master:# kubectl get sa -n dev 
NAME      SECRETS   AGE
default   1         4d
test      1         17m
</code></pre>
<p>you might notice a <code>default</code>  ServiceAccounts is already exists. Each namespaces have a <strong>default</strong> servicesccount</p>
<ol start="2">
<li><strong>Inspect ServiceAccount</strong></li>
</ol>
<p>kubectl describe the <code>sa</code>  <code>test</code>  under the <a href="kube-namespaces.jsp">namespace</a> <strong>dev</strong></p>
<pre><code class="language-html">root@kube-master:# kubectl describe sa test -n dev 
Name:                test
Namespace:           dev
Labels:              &lt;none&gt;
Annotations:         &lt;none&gt;
Image pull secrets:  &lt;none&gt;
Mountable secrets:   test-token-hvbtq
Tokens:              test-token-hvbtq
Events:              &lt;none&gt;
</code></pre>
<ul>
<li><strong>Mountable secrets:</strong> Pods using this ServiceAccount can only mount these Secrets i.e <code>test-token-hvbtq</code></li>
<li><strong>Tokens:</strong>  : JWT Authentication token i.e <code>test-token-hvbtq</code></li>
<li><strong>Image pull secrets</strong> :  Credentials for pulling container images from a private image repository not set.</li>
</ul>
<p>3 . <strong>Debugging Secrets</strong></p>
<p>View the secrets of the <code>test-token-hvbtq</code></p>
<pre><code class="language-html">root@kube-master:# kubectl describe secrets test-token-hvbtq -n dev 
Name:         test-token-hvbtq
Namespace:    dev
Labels:       &lt;none&gt;
Annotations:  kubernetes.io/service-account.name=test
              kubernetes.io/service-account.uid=8d0fcb37-2e8a-11e9-8c68-fa163e589bc0

Type:  kubernetes.io/service-account-token

Data
====
token:      eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZXYiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlY3JldC5uYW1lIjoidGVzdC10b2tlbi1odmJ0cSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJ0ZXN0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQudWlkIjoiOGQwZmNiMzctMmU4YS0xMWU5LThjNjgtZmExNjNlNTg5YmMwIiwic3ViIjoic3lzdGVtOnNlcnZpY2VhY2NvdW50OmRldjp0ZXN0In0.caDSrXwkrIGXboIQ5Ag9G-2lp0Ltli5bb8V9O8a0rbVvDJChukQbAXko1pVqKA7eNlT-qOBRl1K6CKAZHiYvDEfhhCv68GF6YncDlY-1eaUdNNO-CT6d2DHXEWb6gSGK-3P1dxRqqJjVE4FBsMfLDfnky203DMuToz6BsnxgUJY8aQOl-3z8AFJJOV2-c4i5da2wKQfb2meGVQkTI_bDSdp-aq0PP9si5UXKKsCzeOBbpuEO1Xk66ggf9cIoREbJujy9zJN_QMcdYS3o1lOuIThAIRpkDid4y1VH_ulKMnt7JBrTyOxeFK1UobC2kZbP2LFCzoNIBSXvypEVlrR-hw
ca.crt:     1025 bytes
namespace:  3 bytes
</code></pre>
<p>The <strong>token</strong> value is JSON Web Token, the decoded format.</p>
<pre><code class="language-html">//Header
{
  &quot;alg&quot;: &quot;RS256&quot;,
  &quot;kid&quot;: &quot;&quot;
}
//Payload
{
  &quot;iss&quot;: &quot;kubernetes/serviceaccount&quot;,
  &quot;kubernetes.io/serviceaccount/namespace&quot;: &quot;dev&quot;,
  &quot;kubernetes.io/serviceaccount/secret.name&quot;: &quot;test-token-hvbtq&quot;,
  &quot;kubernetes.io/serviceaccount/service-account.name&quot;: &quot;test&quot;,
  &quot;kubernetes.io/serviceaccount/service-account.uid&quot;: &quot;8d0fcb37-2e8a-11e9-8c68-fa163e589bc0&quot;,
  &quot;sub&quot;: &quot;system:serviceaccount:dev:test&quot;
}
</code></pre>
<ol start="4">
<li><strong>Assigning ServiceAccount to Pod</strong></li>
</ol>
<p>The YAML file for assigning <code>serviceAccountName</code> to <code>test</code> and launching a alpine pod with curl installed</p>
<pre><code class="language-html">root@kube-master:# cat alpine-curl.yaml 
apiVersion: v1
kind: Pod
metadata:
  name: alpine
spec:
  serviceAccountName: test
  containers:
  - image: byrnedo/alpine-curl
    command:
      - sleep
      - &quot;3600&quot;
    imagePullPolicy: IfNotPresent
    name: busybox
  restartPolicy: Always
</code></pre>
<ul>
<li>Creating POD from the given YAML definition</li>
</ul>
<pre><code class="html">root@kube-master:# kubectl create -f alpine-curl.yaml -n dev 
pod/alpine created
</code></pre>
<ul>
<li>Verifying pods are in the RUNNING state</li>
</ul>
<pre><code class="language-html">root@kube-master:# kubectl get pods -n dev
NAME      READY     STATUS    RESTARTS   AGE
alpine    1/1       Running   0          48s
</code></pre>
<ul>
<li>Exec to the alpine pod</li>
</ul>
<pre><code class="language-html">root@kube-master:/home/ansible# kubectl exec alpine  -it sh -n dev 
/ # 
</code></pre>
<ul>
<li>Locate the Mountable secretes which is present in the <code>/var/run/secrets/kubernetes.io/serviceaccount/token</code></li>
</ul>
<pre><code class="language-html"># cat /var/run/secrets/kubernetes.io/serviceaccount/token 
eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZXYiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlY3JldC5uYW1lIjoidGVzdC10b2tlbi1odmJ0cSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJ0ZXN0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQudWlkIjoiOGQwZmNiMzctMmU4YS0xMWU5LThjNjgtZmExNjNlNTg5YmMwIiwic3ViIjoic3lzdGVtOnNlcnZpY2VhY2NvdW50OmRldjp0ZXN0In0.caDSrXwkrIGXboIQ5Ag9G-2lp0Ltli5bb8V9O8a0rbVvDJChukQbAXko1pVqKA7eNlT-qOBRl1K6CKAZHiYvDEfhhCv68GF6YncDlY-1eaUdNNO-CT6d2DHXEWb6gSGK-3P1dxRqqJjVE4FBsMfLDfnky203DMuToz6BsnxgUJY8aQOl-3z8AFJJOV2-c4i5da2wKQfb2meGVQkTI_bDSdp-aq0PP9si5UXKKsCzeOBbpuEO1Xk66ggf9cIoREbJujy9zJN_QMcdYS3o1lOuIThAIRpkDid4y1VH_ulKMnt7JBrTyOxeFK1UobC2kZbP2LFCzoNIBSXvypEVlrR-hw/
</code></pre>
<ul>
<li>Query API server with the <code>--header &quot;Authorization: Bearer $TOKEN&quot;</code></li>
</ul>
<pre><code class="language-html"># export TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
# curl https://172.16.2.13:6443/api --header &quot;Authorization: Bearer $TOKEN&quot; --insecure
{
  &quot;kind&quot;: &quot;APIVersions&quot;,
  &quot;versions&quot;: [
    &quot;v1&quot;
  ],
  &quot;serverAddressByClientCIDRs&quot;: [
    {
      &quot;clientCIDR&quot;: &quot;0.0.0.0/0&quot;,
      &quot;serverAddress&quot;: &quot;172.16.2.13:6443&quot;
    }
  ]
}/ 
</code></pre>
<ul>
<li>Alternatively to locate <strong>Mountable</strong> secrete in the pods by <strong>describing</strong> the pods itself</li>
</ul>
<pre><code class="language-html">kubectl describe pods alpine -n dev 
.....

Containers:
  busybox:
    Container ID:  docker://f330b20da3b95211774f53167e1f2e9149cbe144627f6f24608948cce3641767
    Image:         byrnedo/alpine-curl
    Image ID:      docker-pullable://byrnedo/alpine-curl@sha256:e8cf497b3005c2f66c8411f814f3818ecd683dfea45267ebfb4918088a26a18c
    Port:          &lt;none&gt;
    Host Port:     &lt;none&gt;
    Command:
      sleep
      3600
    State:          Running
      Started:      Tue, 12 Feb 2019 12:00:30 +0530
    Ready:          True
    Restart Count:  0
    Environment:    &lt;none&gt;
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from test-token-hvbtq (ro)
</code></pre>
<ol start="5">
<li><strong>Deleting ServiceAccount</strong></li>
</ol>
<p>Deleting the <code>sa</code> <code>test</code>  under namespace <strong>dev</strong></p>
<pre><code class="language-html">root@kube-master:# kubectl delete sa test -n dev 
serviceaccount &quot;test&quot; deleted
</code></pre>
<p>Any Authentication performed using the old token will be <strong>Unauthorized</strong></p>
<pre><code class="language-html"># export TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
# curl https://172.16.2.13:6443/api --header &quot;Authorization: Bearer $TOKEN&quot; --insecure
{
  &quot;kind&quot;: &quot;Status&quot;,
  &quot;apiVersion&quot;: &quot;v1&quot;,
  &quot;metadata&quot;: {
    
  },
  &quot;status&quot;: &quot;Failure&quot;,
  &quot;message&quot;: &quot;Unauthorized&quot;,
  &quot;reason&quot;: &quot;Unauthorized&quot;,
  &quot;code&quot;: 401
}
</code></pre>
<ol start="6">
<li><strong>ServiceAccount Practical Use-Case</strong></li>
</ol>
<p>Some of the practical use case of setting <code>sa</code></p>
<ul>
<li><strong>Jenkins</strong>:  for Managing CI/CD pipeline in kubernetes cluster</li>
</ul>
<pre><code class="language-html">kubectl -n kube-system create sa jenkins
kubectl create clusterrolebinding jenkins --clusterrole cluster-admin --serviceaccount=&lt;namespace&gt;:jenkins
</code></pre>
<ul>
<li><strong>Helm</strong>: Kubernetes Repository Manager</li>
</ul>
<pre><code class="language-html">kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl patch deploy --namespace kube-system tiller-deploy -p '{&quot;spec&quot;:{&quot;template&quot;:{&quot;spec&quot;:{&quot;serviceAccount&quot;:&quot;tiller&quot;}}}}'
</code></pre>
<p><strong>User Accounts</strong></p>
<p>The Next form of Authentication in kubernetes API is with normal user, this is usually done with TLS authentication and typical steps involved</p>
<ul>
<li>User generate a strong RSA or EC keys</li>
<li>User create CSR and bind their Common Name attribute for example <code>CN=user1@8gwifi.org</code></li>
<li>User submit this CSR to kubernetes admin.</li>
<li>Kuberntetes admin verify the content of CSR before Issuing the certificate.</li>
<li>Kubernetes admin will sign the CSR with rootCA and rootCA private key and generate the x.509 Certificate. the kubernetes PKI information is usually located in the <code>/etc/kubernetes/pki/</code></li>
</ul>
<p>We will bet into this Authentication using normal account in detail in the upcoming topic of  <strong><a href="kube-rbac.jsp">Setting up Role-Based Access Control</a></strong></p>
<hr>
<%@ include file="footer_adsense.jsp"%> 
<h3><a id="Authorization_294"></a>Authorization</h3>
<p>After the request is authenticated as coming from a <code>specific user</code> or <code>sa</code> , the request must be authorized.</p>
<p>For example exec to the alpine  <code>kubectl exec alpine -it sh -n dev</code> and list all pods in the dev name space the request will be forbidden</p>
<pre><code class="language-html"># export TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
# curl https://172.16.2.13:6443/api/v1/namespaces/dev/pods --header &quot;Authorization: Bearer $TOKEN&quot; --insecure
{
  &quot;kind&quot;: &quot;Status&quot;,
  &quot;apiVersion&quot;: &quot;v1&quot;,
  &quot;metadata&quot;: {
    
  },
  &quot;status&quot;: &quot;Failure&quot;,
  &quot;message&quot;: &quot;pods is forbidden: User \&quot;system:serviceaccount:dev:test\&quot; cannot list pods in the namespace \&quot;dev\&quot;&quot;,
  &quot;reason&quot;: &quot;Forbidden&quot;,
  &quot;details&quot;: {
    &quot;kind&quot;: &quot;pods&quot;
  },
  &quot;code&quot;: 403
}
</code></pre>
<p>In order to grant Authorization proper <strong>policy</strong> or <strong>RBAC</strong> control needs to be in placed, for an instance in order to give <strong>pod</strong> permission to query all pods in the given namespace, a <strong>role</strong> and corresponding <strong><a href="kube-rbac.jsp">rolebinding</a></strong>  needs to be defined.</p>
<p>The below YAML file has setup necessary authorization for <strong>role</strong> and <strong>rolebinding</strong> under the namespace dev</p>
<pre><code class="language-html">kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: test-manager
  namespace: dev
rules:
- apiGroups: [&quot;&quot;, &quot;batch&quot;, &quot;extensions&quot;, &quot;apps&quot;]
  resources: [&quot;pods&quot;]
  verbs: [&quot;*&quot;]
---
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: test-binding
  namespace: dev
subjects:
- kind: ServiceAccount
  name: test
  namespace: dev
roleRef:
  kind: Role
  name: test-manager
  apiGroup: rbac.authorization.k8s.io
</code></pre>
<pre><code class="language-html">root@kube-master:# kubectl delete  -f rbac.yaml
role.rbac.authorization.k8s.io &quot;test-manager&quot; deleted
rolebinding.rbac.authorization.k8s.io &quot;test-binding&quot; deleted
</code></pre>
<p>The role is set to query the resource pods with all known HTTP verbs</p>
<pre><code class="language-html"># curl https://172.16.2.13:6443/api/v1/namespaces/dev/pods --header &quot;Authorization: Bearer $TOKEN&quot; --insecure
&quot;kind&quot;: &quot;PodList&quot;,
  &quot;apiVersion&quot;: &quot;v1&quot;,
  &quot;metadata&quot;: {
    &quot;selfLink&quot;: &quot;/api/v1/namespaces/dev/pods&quot;,
    &quot;resourceVersion&quot;: &quot;2302485&quot;
  },
  &quot;items&quot;: [
    {
      &quot;metadata&quot;: {
        &quot;name&quot;: &quot;alpine&quot;,
        &quot;namespace&quot;: &quot;dev&quot;,
        &quot;selfLink&quot;: &quot;/api/v1/namespaces/dev/pods/alpine&quot;,
        &quot;uid&quot;: &quot;0abb388b-2e97-11e9-8c68-fa163e589bc0&quot;,
        &quot;resourceVersion&quot;: &quot;2300673&quot;,
        &quot;creationTimestamp&quot;: &quot;2019-02-12T07:23:06Z&quot;

....
</code></pre>
<p>We will cover <a href="kube-rbac.jsp">RBAC</a> in much detail in upcoming topic let's stick with next important concept <strong>Admission Control</strong></p>

<hr>
<%@ include file="footer_adsense.jsp"%> 
<h4><a id="Admission_Control_381"></a>Admission Control</h4>
<p>In Kubernetes, <a href="https://kubernetes.io/docs/admin/admission-controllers/">Admission Controllers</a> enforce semantic validation of objects during create, update, and delete operations.</p>
<p>First check if the admission registration API is enabled in your cluster by running:</p>
<pre><code class="language-html">root@kube-master:# kubectl api-versions | grep admission
admissionregistration.k8s.io/v1beta1
</code></pre>
<p>Some example of semantic validation can be done through the Admission Controllers</p>
<ul>
<li>Validate that image tags are are having certain pre-configured prefix or postfix.</li>
<li>Reject an image if it is being pulled from dockerhub directly.</li>
<li>Reject an image that has high or critical CVEs that have a fix available, but allow high-severity if no fix is available yet</li>
<li>Never reject images from a specific registry/repository</li>
<li>Others</li>
</ul>
<p>There are two types of Webhook Admission controllers in Kubernetes 1.9.</p>
<ul>
<li>ValidatingAdmissionWebhook</li>
<li>MutatingAdmissionWebhook</li>
</ul>
<p>These webhooks is that they can be dynamically configured after the start of the <code>api-server</code>, this enables anyone with the correct <a href="https://kubernetes.io/docs/reference/access-authn-authz/rbac/">Role-based access control (RBAC)</a> to extend the concept of Admission Control.</p>

<p> Next Reading <a href="kube-rbac.jsp">RBAC</a></p>

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
    
    

    <!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>


  </body>

</html>