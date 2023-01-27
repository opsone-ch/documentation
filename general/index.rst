*******************
General Information
*******************

 .. note::
    Ops One Apps is currently in beta. Please contact us for more information.

With Ops One Apps you can deploy your webservice to a managed `Kubernets <https://kubernetes.io/>`__ cluster.
You don't need any Kubernetes knowledge to use this service.
The process is simplified as follows:

1. Place a `opsone.yaml <../opsone-file/index.html>`__ file in the root of your git repository
2. Add a webhook to your git project *(tested but not limited to GitHub and GitLab)*
3. Push your code to your git repository
4. The webhook triggers the deployment
5. We detect the language and build your webapp
6. Your webapp is deployed to the Ops One App Platform

At the moment we support the following languages:

.. toctree::
   :maxdepth: 1

   ../languages/nodejs
   ../languages/hugo