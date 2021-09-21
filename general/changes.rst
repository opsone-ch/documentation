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
* PHP the ``SERVER_NAME`` is now dynamic, see :ref:`website-type_php`
* added composer v2, see :ref:`website-type_php-composer`
* added :ref:`order <firewall_rule-order>` parameter for firewall rules
* updated ProFTPD to supports TLSv1.2 and TLSv1.3
* added ``umask 027`` for PHP (all versions), Node.js, ruby and python
* PHP 5.6 disabled the modules xdebug and apcu
* PHP 7.0 disabled the modules xdebug and memcached

See :ref:`website`.

