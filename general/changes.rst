.. index::
   triple: Server; Changelog; Version 6 to 7 Changes
   :name: server-changelog

======================
Version 6 to 7 Changes
======================

.. warning::

   WIP: This content was not yet completed. We will add the remaining
   changes as soon as possible.
   Please contact us if you have any questions regarding a particular function.

System Wide
===========

* updated to Debian 10 Buster
* iptables replace by nftables
* file based external backup replaced by a snapshot based one
* maximum diskspace raised to 10TB

Website
=======

* removed outdated types, see :ref:`website-type` for details
* support for TLS 1.3
* removed the ``~/cnf/nginx-redirect.conf`` configuration file which was not nowhere correctly in use
* installed goaccess, see :ref:`howto-logfile_goaccess`

See :ref:`website`.

Firewall
========

* switched from iptables to nftables

See  :ref:`firewall`.

Postfix
=======

* added the ``smtp_sasl_password_maps`` option

See  :ref:`postfix`.

