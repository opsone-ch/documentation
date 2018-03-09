Server Configuration
====================

Hiera Backend
-------------

By now, our servers are configured trough a YAML based
`Hiera <https://docs.puppetlabs.com/hiera/1/>`__ backend for Puppet.
Depending on your access rights you are able to modify the whole
configuration or only parts of the hierarchy such as domains or single
servers.

Hierarchy:

-  common.yaml
 -  common values used on all servers
 -  here, you add values like global SSH keys or firewall rules
-  domain/common.yaml
 -  common values used on all servers in this domain
 -  here, you add domain specific values like dns resolver for a particular subnet
-  domain/fqdn.yaml
 -  values used on this explicit server
 -  here, you add server specific values such as websites

Access
~~~~~~

We will provide you access to the appropriate GIT repository to alter
your configuration. Depending on your role you can add global or
domain/server specific configurations.

.. note:: This is a temporary solution only (see below)

Outlook
~~~~~~~

We are working hard on a new, HTTP/REST based backend for Hiera. You
will be able to alter server specific configurations such as websites
trough this new API. In a first step, the API will be backed by the
great `Swagger UI <http://petstore.swagger.io/>`__, later on we will
develop our own management interfaces which interacts with this API.

Memory Ratio
------------

To configure certain, memory-aware services, suche as memcached or
Varnish, we use the so called ``memory_ratio`` parameter to calculate
the amount of memory for a given service.

As basis, we take 80% of the servers total memory. This amount is then
distributed trough the ``memory_ratio`` for a specific service.

Note: You can also use floating point numbers here. e.g.
``memory_ratio: 1.2`` results in 66% (0.8/1.2)

Examples
~~~~~~~~

single Tomcat instance
^^^^^^^^^^^^^^^^^^^^^^

-  Server with 4GB Memory
-  Tomcat Service, no others
-  Tomcat ``memory_ratio`` is ``1`` by default
-  Result: 4GB Memory \* 80% = 3.2GB / 1 (ratio) = 3.2GB Memory for
   Tomcat

Tomcat instance among others
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

-  Server with 4GB Memory
-  Website Service, Tomcat Service
-  Tomcat ``memory_ratio`` manually set to ``3``
-  Result: 4GB Memory \* 80% = 3.2GB / 3 (ratio) = 1.07GB Memory for
   Tomcat

Diskspace
---------

If you want to know which files (or folders) use the most space, you can use the command ``diskusage``. The command can only be executed with the `devop user <access.html#generic-devop-user>`__.

Server sizing
-------------

Scale
^^^^^

Every new server comes with 1GB RAM, 1CPU Core and 20GB Space (regarding
to `our
offers <https://www.snowflake.ch/hosting-betrieb/managed-server/>`__ )
This is a very basic setup and it's recommended to plan and check the
sizing of your server carefully before going live. You can simply scale
every option of your server - regarding to your actual needs (without
paying for unused resources).

Hint: use load tests to plan your sizing. We're also happy to help you
out.

Architecture
^^^^^^^^^^^^

Please plan your architecture / server setup carefully. Normaly we
recommend to split services across different servers.

Example:

-  large TYPO3 website
-  Solr search server
-  Memcache caching backend

Setup at least 3 server and go live:

-  Server 1: Websites with TYPO3 (running Nginx, PHP, MySQL)
-  Server 2: Apache Solr
-  Server 3: Memcached

Notional: the website went live and now the users love your search
function and drop tausends of search querys every second. So now you can
easly scale your Solr server without outages of the main website.
(because just the search function is overloaded) If you had all services
on one server, probably your website is down now, because Solr catched
all the available resources.
