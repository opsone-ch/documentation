.. index::
   triple: How-to; Deployment; Go-Live
.. _howto-deploy:

===================
Deploy Applications
===================

To deploy your application to your DEV, STAGE, PROD environment, follow
the following docs.

.. hint:: we're happy to support you with an automatic deployment process. Feel free to contact us!

Deploy to your server
---------------------

First of all, make sure that you've configured and installed all desired :doc:`../services/index` (e.g. website, caching etc).
In the following documentation we're talking about website deployments.

.. warning:: please make sure, that you're using appropriate usernames.  Don't use confusing names like "examplestage" for PROD envs etc

Deploy your files
~~~~~~~~~~~~~~~~~

Git
^^^

We recommend to use Git to deploy your website to your server. Feel free
to clone your repository - your server is prepared:

-  Git is installed
-  access to github.com is allowed (add :doc:`../services/firewall` rules to access other repos)

.. hint:: we're also able to host a Git environment for you or even offer consulting to introduce Git in you company / agency. Please contact us for more informations

If you don't use Git, there is the possiblity to copy the files over the "oldschool" way with rsync:

Copy files
^^^^^^^^^^

Login into the old website / environment and issue this command:

::

    ### exclude the typo3temp (for TYPO3 websites)
    rsync -avz --exclude=typo3temp ~/ newuser@server:~/

This will copy the complete home directory to the remote users home.

Warning: don't copy old backup files to the new environment. Use
"--exclude=backup" to exclude your backup directory.

.. hint:: SSH agent forwarding is required

.. hint:: use appropriate exclude patterns to ignore all not required files

.. hint:: we use always SSH to copy files, even on the same server. This ensures that all files and directories belong to the appropriate user

Deploy your database
~~~~~~~~~~~~~~~~~~~~

Copy database
^^^^^^^^^^^^^

Login into the old environment and issue this command:

::

    mysqldump --single-transaction --ignore-table=exampledatabase.cache_pages --ignore-table=exampledatabase.cache_hash -uexampledatabaseuser -ppassword exampledatabase | ssh newuser@server mysql -unewdatabase -ppassword newdatabase

Hint: Skip big and not required tables with the "--ignore-table"
parameter

Identify big tables
'''''''''''''''''''

::

    SELECT table_name AS "tables", 
    round(((data_length + index_length) / 1024 / 1024), 2) "Size in MB" 
    FROM information_schema.TABLES 
    WHERE table_schema = "<dbname>"
    ORDER BY (data_length + index_length) DESC;

Warning: You have to create those ignored tables manually on the new
website afterwards.

Deploy between environments
---------------------------

If you've your site ready on the "DEV" or "STAGE" environment, there are
two options to switch / deploy between different environments:

-  switch environment on an existing website in your configuration
-  create a new website with the desired environment setting, copy files
   (and database)

Switch environment
~~~~~~~~~~~~~~~~~~

With this option, you just change the environment for a particular
website, for example from STAGE to PROD. If the former environment is
still required, you have to add a new website and copy all data back, we
recommend to use the second method by default.

-  rename "env" value from "DEV" or "STAGE" to "PROD"
-  remove "htpasswd" value which is not required anymore

Warning: dont use confusing names like "examplestage" and set the env to
"PROD"

New website, copy data (recommended)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

With this option, you just add another website with the desired
environment and copy all files (and database) into the new website.

Go Live
-------

Requirements
~~~~~~~~~~~~

For a go live without any troubles and outages, please fulfill the
following checklist.

-  Domains / Nameserver in your control
-  always use a low TTL like "300"
-  Mail hosting (checked, moved, created, installed etc)
-  Add DNS SPF Records (see :doc:`../server/e-mail`)
-  TLS certificate installed, ready and tested
-  Naxsi learning mode disabled on STAGE and PROD, whitelist rules are created
-  The server has a correct sizing
-  Disable application based logging

Testing
~~~~~~~

When you fulfill the requirements, make sure everything is in place as
desired and ready for testing. Always simulate productive calls to the
application, by adding all involved host names to your local hosts file.
If you expect heavy usage, carry out load tests beforehand.

.. hint:: We are happy to assist you with architecture, sizing and load tests

Modify server hosts file
^^^^^^^^^^^^^^^^^^^^^^^^

If you have to add entries to the servers hosts file for testing or
other purposes (e.g. TYPO3 page not found handling), see :doc:`../server/hosts` for details.

Go live!
~~~~~~~~

Save the date
^^^^^^^^^^^^^

If you need our assistance, we're happy to help you out! But we
recommend to contact us at least 3 days before the go live.

Cache warming
^^^^^^^^^^^^^

Warm your cache before going live to avoid possible performance issues.
There are a lot of possiblities. A simple cache warming could be done
with a hostfile entry, a valid sitemap and wget / curl:

::

    # HTTP
    wget --quiet http://www.example.com/sitemap.xml --no-cache --output-document - | egrep -o "http://$URL[^<]+" | while read line; do curl -A 'cache warming' -s -L $line > /dev/null 2>&1; done

    # HTTPS
    wget --quiet https://www.example.com/sitemap.xml --no-cache --output-document - | egrep -o "https://$URL[^<]+" | while read line; do curl -A 'cache warming' -s -L $line > /dev/null 2>&1; done

.. hint: replace the sitemap part with your sitemap url

Git
^^^

Use only the "live" branch on your PROD environment. Make sure that
there are no local changes:

::

    git branch -v
    git status

Lookup your IP addresses
^^^^^^^^^^^^^^^^^^^^^^^^

Connect to your server and note both IPv4 and IPv6 address:

::

    $ facter ipaddress ipaddress6
    ipaddress => 192.168.0.99
    ipaddress6 => 2001:db8::99

Add records
^^^^^^^^^^^

Add DNS records within the DNS server of your choice.

::

    example.net.     A       192.168.0.99
    example.net.     AAAA    2001:db8::99
    www.example.net. A       192.168.0.99
    www.example.net. AAAA    2001:db8::99

.. note:: always add both A/AAAA DNS Records. Even if you have no IPv6 connectivity yet, others will, and IPv6 usage will spread

.. hint:: for more information about our dualstack infrastructure, see the :doc:`../server/dualstack` site

Check records
^^^^^^^^^^^^^

Right after you changed the records, you should query your dns server
and compare the returned values against those from your lookup before:

::

    dig A www.example.net @nameserver
    dig AAAA www.example.net @nameserver

Reverse Proxy
~~~~~~~~~~~~~

If you want to make sure, that the old server/website wont deliver any
requests anymore at all, add a reverse proxy on the old server which
redirects all traffic to the new server. With this setup, you can switch
servers without the uncertainties of the global DNS System.

If your old site is using Apache, add this virtual host:

::

    <VirtualHost 192.168.0.22:80>
      ServerName        example.net
      ServerAlias       www.example.net
      ErrorLog          /path/to/error.log
      CustomLog         /path/to/access.log combined
      ProxyRequests     Off
      ProxyPreserveHost On
      ProxyPass         / http://new.host.name/
    </VirtualHost>

Check HTTP
^^^^^^^^^^

At last, check HTTP access for both IPv4 and IPv6 protocol to make sure
everything went fine:

::

    wget -4 www.example.net
    wget -6 www.example.net

Check logfiles
^^^^^^^^^^^^^^

Always check your logfiles after going live.

Remove local server name
^^^^^^^^^^^^^^^^^^^^^^^^

Please remember to remove the local server name (``websitename.fqdn``). Otherwise this URL will be indexed by
search engines and produce duplicate content.
