.. index::
   triple: How-to; Deploy; Application
   :name: howto-deploy

==================
Deploy Application
==================

Follow this guide to deploy your application to our servers.

.. tip::
  For automatic deployment try our :ref:`howto-deploy_cd` example.
  We'd love to support you with automatic deployment processes.
  Feel free to contact us!

.. index::
   triple: How-to; Deployment; Git
   :name: howto-deploy_git

Copy Files by Git
=================

We recommend you to use Git to deploy your application.
Git and the required dependencies are already installed and configured by default.

.. tip::

   Contact us if you don't use Git yet, or don't have access to a trustworthy Git server.
   Among others, we run GitLab as a service and also offer corresponding trainings.

Depending on your needs, you can directly ``git clone`` your application into the webroot,
or build something more elaborate.

.. index::
   triple: How-to; Deployment; Copy Files
   :name: howto-deploy_files

Copy Files Manually
===================

It is also possible to deploy your application manually. You can use this approach
either fully manual from your workstation, or from within a CI job.

A example rsync command to copy your application does look as follows:

.. code-block:: bash

   rsync -avz --exclude=backupAndCache ~/project/ website@server.example.net:~/project/

As the different website users are encapsulated from each other,
this approach is also used to copy files between different sites on the same server.

.. tip::

   Use SSH agent forwarding to loop your local SSH key into remote systems.

.. index::
   triple: How-to; Deployment; Copy Database
   :name: howto-deploy_database

Copy Database
=============

Again, we rely on SSH to copy a databases from one place to another.

A example mysql command does look as follows:

.. code-block:: bash

   mysqldump --single-transaction example | ssh website@server.example.net mysql

.. tip::

   To skip certain tables which are not required, add the ``--ignore-table`` parameter to the ``mysqldump`` command.

.. index::
   triple: How-to; Deployment; Continuous Deployment
   :name: howto-deploy_cd

Continuous Deployment
=====================

Continuous Deployment automatically runs the jobs defined in the ``.gitlab-ci.yml`` on each commit, in this example we build and deploy the Nuxt.js demo app. Keep in mind that this is only meant as an example, if you want to use it productively we recommend you to continue with this topic and extend it as needed, further links can be found at the end of this section.

Preparation
-----------

* Cockpit access to a managed server from us.
* The ability to create a new GitLab project.
* This project must have available runners

  * See ``Settings`` > ``CI/CD`` and expand ``Runners``.

We need to create a SSH key pair without passphrase to allow CI/CD to access our website

.. code-block:: bash

   ssh-keygen -t ed25519 -a 100 -f cd-access.key -N ""

This will create two files ``cd-access.key`` with the private key and ``cd-access.key.pub`` with the public key, which we will need later.

Website
-------

* log in to `cockpit.opsone.ch <https://cockpit.opsone.ch>`_
* choose your server or create a new server
* go to websites and create a new one
* choose the website type ``Node.js``
* go to the tab ``SSH Access`` and add a new ``SSH Key`` with the content of the file ``cd-access.key.pub`` from above as key

GitLab
------

* create a new and empty project
* add the following CI/CD variables under ``Settings`` > ``CI/CD`` and expand ``Variables``.

  * These variables will be used to access the website we created above.
  * Key: ``DEPLOY_SERVER``, Value: the hostname from the server above
  * Key: ``DEPLOY_USER``, Value: the website name from above
  * Key: ``SSH_DEPLOY_KEY``, Value: the content of the file ``cd-access.key`` from above

* download and unpack the `sample project <https://gitlab.com/opsone_ch/cd-example-nuxtjs/-/archive/master/cd-example-nuxtjs-master.zip>`_
* commit the contents of the extracted folder to the newly created GitLab project

Under ``CI/CD`` > ``Pipelines`` you will now see, if everything worked, a ``running`` pipeline, once this has the status ``passed`` you should be able to go to the website and see the NuxtJS demo page.

Related links
-------------
* `Example project <https://gitlab.com/opsone_ch/cd-example-nuxtjs>`_
* `GitLab CI/CD <https://docs.gitlab.com/ce/ci/>`_
* `GitLab CI/CD pipeline configuration reference <https://docs.gitlab.com/ce/ci/yaml/README.html>`_

.. index::
   triple: How-to; Deployment; Go-Live
   :name: howto-deploy_golive

Go Live
=======

Requirements
------------

For a go live without any troubles and outages, please make sure that:

- Domains and/or nameserver are within your control
- the desired DNS records TTL was lowered to 300
- your SPF records are in order (when your application must send mails only, see :ref:`postfix`)
- the correct application context was set
- the correct, final server names are in place
- possible intermediate server names are removed
- the appropriate TLS certificate is installed and fully tested
- the server has the correct size to handle the expected traffic

.. tip::

   If in doubt, contact us. We'd love to assist you with planning, testing and executing such migrations.
   If you plan the go live for a bigger project, we're glad if you let us know the desired date so we can plan accordingly.

DNS records
-----------

You can lookup your servers records in Cockpit, or by executing the following command through SSH:

.. code-block:: bash

   $ facter ipaddress ipaddress6
   ipaddress => 192.168.0.99
   ipaddress6 => 2001:db8::99

.. tip::

   Please make sure to note both IPv4 (A) and IPv6 (AAAA) adresses and add both records.

Add to appropriate DNS records to your zone:

.. code-block:: none

   example.net.     A       192.168.0.99
   example.net.     AAAA    2001:db8::99
   www.example.net. A       192.168.0.99
   www.example.net. AAAA    2001:db8::99

Right after you changed the records, you should query your dns server and compare the returned values against those from your lookup before:

.. code-block:: bash

   dig +short A www.example.net @nameserver
   dig +short AAAA www.example.net @nameserver

Check HTTP
----------

After the DNS ttl was expired, check HTTP access for both IPv4 and IPv6 protocol:

.. code-block:: bash

   wget -4 www.example.net
   wget -6 www.example.net

Check logfiles and usage
------------------------

Check all access and error logs and make sure your server can bear the new load of the additional visitors.
A handy tool to gain a good overview is :ref:`monitoring_netdata`.

