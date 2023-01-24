*******************
General Information
*******************

 .. note::
    Ops One Apps is currently in beta. Please contact us for more information.

With Ops One Apps you can deploy your Webservice to a Managed Kubernets Cluster.
You don't need any Kubernetes knowledge to use this service.
The process is simplified as follows:

1. Place a ``opsone.yaml`` file in your git repository root directory
2. Add a webhook to your git project *(tested but not limited to GitHub and GitLab)*
3. Push your code to your git repository
4. The webhook triggers the deployment

We then build and deploy your code to the Ops One App Platform.

At the moment we support the following languages:

* Node.js
* Hugo