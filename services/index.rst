Services
========

After you receive a fresh server, your machine is more or less empty.
You can add so called services to the VM which will install and configure all necessary components.

.. note:: Keep resource usage in mind. For example, you wont be able to add a 2GB memcached instance on a server with 1GB RAM

.. warning:: While you can mix most of those services, some of them will work rather nicely together, but others wont due to different requirements.  **In many cases, it is more feasible to spread services over multiple servers.**

.. toctree::
  :maxdepth: 2

  website
  database
  caching
  ftp
  networking
  firewall
  globalrepo
  solr
  redis

