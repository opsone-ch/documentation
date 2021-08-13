.. index::
   triple: Server; Changelog; Version 7 to 8 Changes
   :name: server-changelog

======================
Version 7 to 8 Changes
======================

System Wide
===========

* updated to Debian 11 Bullseye

Website
=======

* nginx 1.20
* ModSecurity 3/OWASP CRS 3.3, see :ref:`website-waf`
* MariaDB 10.10
* PHP deactivated include of ``.php.ini``
* added named locations in nginx for the following website types: nodejs, proxy, ruby, python.
* added default charset ``utf-8`` for the html website type
* added the ``X-Forwarded-Host`` header in our proxy website type

See :ref:`website`.

