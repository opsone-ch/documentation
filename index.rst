========================
Managed Server Version 8
========================

You are looking at the documentation of our managed server version 8.
Switch to other versions by using the *Switch to* selector at the bottom of the navigation.

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

Here, we created a short and handy list for you to help getting started with our services.

Creating a Server  
=================

.. note:: If you don't have access to our Cockpit or need to reset your 2FA device, feel free to contact us.

- Creating a Server: Visit https://cockpit.opsone.ch and navigate to ``Managed Server``
- Add a new Server according to your needs. Choose your Server Name wisely, this will be the Servers unique identifier
- Custom Server Configuration :ref:`customjson_server`
- Monitoring your Server: :ref:`monitoring`


Creating a Website  
==================

- What is a Website: :ref:`website`
- Different Website types: :ref:`website-type`
- Website context Dev / Stage / Prod: :ref:`website-context`
- ssl / Let's Encrypt: :ref:`website-ssl`
- Monitoring your Website: :ref:`website-monitoring`
- Advanced Website configurations: :ref:`advanced-configuration`

.. tip:: To disable Monitoring for your Website completely, remove all entries from the ``Monitoring`` tab.

Connecting to your Server / Website
===================================

- Connect via SFTP: :ref:`access-sftp`
- Connect via SSH: :ref:`access-ssh`
- Create an SSH key: :ref:`howto-sshkey`

.. tip:: You can either deposit your ssh key on server level to ensure access to all websites on this server or deposit the key in a website to restrict access to only the selected website.

Different Users and their functionality
=======================================

- devop user: :ref:`access_devop`
- Website preview user: :ref:`website-advanced-previewuser`

How and where to find Logs 
==========================

.. tip:: Log files are used to help find problems and errors that might be occuring on your server. 

- Available log files: :ref:`logs_faq`
- How to analyse Log files: :ref:`howto-logfile`

Commom mistakes & errors
========================

- Let's Encrypt validation failed: :ref:`website-ssl_autossldebug`
- Diskspace doesn't change after deleting files: :ref:`diskspace`

Other useful links
==================
- How-to documentation: :ref:`howto`
- Frequently asked questions: :ref:`howto-faq`
- Environment variables: :ref:`website-envvar`
- Resouce monitoring: :ref:`monitoring_netdata` and :ref:`monitoring_collectd`

Search and Glossary
===================

Not found what you're looking for yet? Beside of the search bar (top left),
we also added a :doc:`genindex` with a comprehensive list of all topics.

.. note:: For marketing and contract related details and contact infos, visit our website https://opsone.ch.

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
