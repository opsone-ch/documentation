Services
========

After you receive a ordered server, the machine is more or less empty and of no much use.
However, you can add so called services to the machine which will install and configure all necessary components.

Note: Keep the resource usage in mind. On a server with 1GB RAM for example, you wont be able to add a 1GB memcached instance.

Warning: While you can mix most of those services, some of them will play rather nicely together,
but others wont due to different requirements.
**In many cases, its more feasible to spread services over multiple servers.**

.. toctree::
  :maxdepth: 2

  website
  database
  caching
  ftp
  networking
  firewall
  tomcat
  javascript
  globalrepo
  solr
  redis

