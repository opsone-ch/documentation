.. Ops One documentation master file, created by
   sphinx-quickstart on Sat Nov 19 12:26:29 2016.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

===========================================
Ops One Platform: Welcome
===========================================

This is the Ops One platform documentation.  It is aimed at a technical audience, mainly developers and sysadmins.
Marketing and contract related details are available on our `website <https://opsone.ch>`_.

Managed Server Version 7
-------------------------------------------

There are different managed server versions in use. Each version is based on a certain Debian release and tied to versions of further software like PHP and MySQL.
This concept allows you to select the appropriate version depending on the application you use, and also to switch to a newer generation in a planned way according to your needs.
Right now, you are looking at the documentation for the version 7:

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

Switch to the documentation of other generations by using the versions selector below.

Support
-------------------------------------------

Do you struggle with some configurations, or can we advise you somehow?  We're here and happy to help.
For any questions, don't hesitate to contact us:

* `Slack <https://opsone-ch.slack.com>`_ (according to SLA agreement)
* E-Mail: `team@opsone.ch <mailto:team@opsone.ch>`_

Open source
-------------------------------------------

This work is licensed under the `Creative Commons Attribution-ShareAlike 4.0 International License <http://creativecommons.org/licenses/by-sa/4.0/>`_.

.. toctree::
  :hidden:

  guides/index
  changelog
  server/index
  services/index
  development/index
  support
  faq

