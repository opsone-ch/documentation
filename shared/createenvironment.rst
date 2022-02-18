Create Environment
------------------
First you have to create a website on your server.
Our website module provides everything you need to manage, deploy and run your website.
Every Website is type and environment based, which means you have to select a particular type (e.g. `wordpress <../website/type.html#wordpress>`__) and `environment <../website/context.html>`__ (e.g. PROD).

1. Log in to `cockpit.opsone.ch <https://cockpit.opsone.ch>`__
2. Choose your server or create a new one
3. Go to websites, and create a new one
4. `Select website type <../website/type.html#wordpress>`__ wordpress and fill in all settings

.. tip:: You don't need to remember your DB credentials. We always provide them as `environment variables <../website/envvar.html>`__.

According to those settings, our automation will setup the server/vhost as required.