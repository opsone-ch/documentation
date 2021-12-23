========================
Ops One Documentation
========================

You are looking at the documentation of our managed server version 8.
Switch to other versions by using the *Switch to* selector at the bottom of the navigation.

Here, we created a short and handy list for you to help getting started with our services.

Creating a Website  
===================
- What is a Website: :ref:`website`
- Different Website types: :ref:`website-type`
- Website context Dev / Stage / Prod: :ref:`website-context`
- Monitoring your Website: :ref:`website-monitoring`
- ssl / Let's Encrypt: :ref:`website-ssl`

.. list-table:: Managed Server Version 8: Main Software Versions and End of Life Date

   * - OS Release
     - Webserver
     - Database
     - PHP
     - EOL
   * - Debian 11
     - nginx 1.20
     - MariaDB 10.10
     - 8.1

       8.0

       7.4

       7.2 (EOL)

       7.0 (EOL)

       5.6 (EOL)
     - May 2026


.. tip:: You can either deposit your ssh key on server level to ensure access to all websites on this server or deposit the key in a website to restrict access to only the selected website.


Different Users and their functionality
=======================================
- devop user: :ref:`access_devop`
- Website preview user: :ref:`website-advanced-previewuser`


How and where to find Logs 
==========================
.. tip:: Log files are used to help find problems and errors that might be occuring on your server. 

- Available log files: :ref:`howto-faq`


Commom mistakes & errors
========================
- Let's Encrypt validation failed: :ref:`website-ssl_autossldebug`
- Diskspace doesn't change after deleting files: :ref:`diskspace`


Other useful links
==================
- Custom configuration: :ref:`customjson_server`
- Environment variables: :ref:`website-envvar`
- Resouce monitoring: :ref:`monitoring_netdata` and :ref:`monitoring_collectd`



Search and Glossary
===================

Not found what you're looking for yet? Beside of the search bar (top left),
we also added a :doc:`genindex` with a comprehensive list of all topics.

.. tip:: For marketing and contract related details and contact infos, visit our website https://opsone.ch.

Open source
-------------------------------------------

We strongly believe in open source software.
This work is licensed under the `Creative Commons Attribution-ShareAlike 4.0 International License <http://creativecommons.org/licenses/by-sa/4.0/>`_.
It is available on `GitLab <https://gitlab.com/opsone_ch/documentation>`_
and `GitHub <https://github.com/opsone-ch/documentation/>`_.


.. toctree::
  :hidden:

  general/index
  website/index
  varnish
  redis
  memcached
  solr
  advanced/index
  howto/index
  Glossary <genindex>

