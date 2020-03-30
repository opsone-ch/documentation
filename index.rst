.. Ops One documentation master file, created by
   sphinx-quickstart on Sat Nov 19 12:26:29 2016.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

===========================================
Ops One Platform Documentation
===========================================

.. warning:: This documentation is work in process. Please contact us if you have any questions regarding a version 7 server.

This is the Ops One platform documentation.  It is aimed at a technical audience, mainly developers and sysadmins.
Marketing and contract related details are available on our `website <https://opsone.ch>`_.

Managed Server Version 7
-------------------------------------------

There are different managed server versions in use. Each version is based on a certain Debian release and tied to versions of additional software like PHP and MySQL.
This concept allows you to select the appropriate version depending on the application you use, and also to switch to a newer generation in a planned way according to your needs.

Main points of version 7 are as follows:

.. list-table::
   :stub-columns: 1

   * - OS Release
     - Debian 10 (Buster)
   * - Webserver
     - nginx 1.16
   * - Database
     - MariaDB 10.3
   * - PHP
     - 5.5 (EOL), 7.0 (EOL), 7.2, 7.4
   * - EOL
     - ~ May 2024

.. hint:: switch to the documentation of other generations by using the versions selector below

Open source
-------------------------------------------

We strongly believe in open source software. This work is licensed under the `Creative Commons Attribution-ShareAlike 4.0 International License <http://creativecommons.org/licenses/by-sa/4.0/>`_.

.. toctree::
  :hidden:

  Changelog <changelog>
  howto/index
  server/index

