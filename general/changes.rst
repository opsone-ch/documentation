.. index::
   triple: Server; Changelog; Version 6 to 7 Changes
   :name: server-changelog

======================
Version 6 to 7 Changes
======================

System Wide
===========

* updated to Debian 10 Buster
* iptables replace by nftables
* file based external backup replaced by a snapshot based one
* maximum diskspace raised to 10TB

Website
=======

* nginx 1.16
* support for TLS 1.3, see :ref:`website-ssl`
* ModSecurity 3/OWASP CRS 3.2, see :ref:`website-waf`
* MariaDB 10.3, default charset set to ``utf8mb4``
* PHP version selector for versions 5.6, 7.0, 7.2, 7.4 per website
* updated name restrictions: Length up to 32 characters, support for digits, underscore and dash
* uniform profile between interactive and non-interactive, login and non-login zsh & bash shells
* type related cronjobs will run each 15min with a randomly spread offset calculated from the website name
* `Docker` type: enabled user namespace mappnig, see :ref:`howto-docker`
* removed outdated types and added new ones, see :ref:`website-type`
* removed the ``~/cnf/nginx-redirect.conf`` configuration file which was not nowhere correctly in use
* override for all type specific presets: preview auth, phpinfo, sendmail (Cockpit website `Advanced` tab)
* installed goaccess, see :ref:`howto-logfile_goaccess`
* custom error page is taken out of ``error.html`` within the default webroot
* custom error page can distinguish between WAF and non-WAF 403 errors
* added ``WEBSITE_CONTEXT`` variable, see :ref:`website-envvar`
* added ``WEBSITE_SERVER_NAME`` variable, see :ref:`website-envvar`

See :ref:`website`.

Firewall
========

* switched from iptables to nftables

See  :ref:`firewall`.

Postfix
=======

* added the ``smtp_sasl_password_maps`` option

See  :ref:`postfix`.

Caching
=======

* removed module altogether
* use the respective new servies :ref:`varnish`, :ref:`redis` and :ref:`memcached`

