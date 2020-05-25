.. index::
   triple: How-to; Deploy; Application
   :name: howto-deploy

==================
Deploy Application
==================

Follow this guide to deploy your application to our servers.

.. tip::
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

