.. index::
   pair: Server; Firewall
   :name: server-firewall

==============
Firewall Rules
==============

.. attention::
   This site covers the IP/network firewall.
   There is also a web application firewall within :ref:`Website <website-waf>`.

Default Settings
================

All incoming and outgoing traffic is blocked by default, except:

- related or established connections
- ICMP/ICMPv6
- Traceroute
- SSH
- outgoing connections to some common services (see :ref:`` below)

.. tip:: Outgoing connections might not be allowed by default according on your company guidelines.

Change Default Allowed Outgoing Ports
-------------------------------------

Alter the list of allowed outgoing ports by adding only the desired ports to the
``nftables::allow_outgoing_ports`` array within the `Custom JSON` :ref:`server-customjson_server`:

.. index::
   triple: Server; Firewall; Default Allowed Outgoing Ports
   :name: firewall_default-allowed-outgoing-ports

Default Settings
~~~~~~~~~~~~~~~~

.. code-block:: json

   {
     "nftables::firewall::allow_outgoing_ports": [ 25, 80, 110, 143, 443, 465, 587, 993, 995 ]
   }

Allow HTTP and HTTP Only
~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: json

   {
     "nftables::firewall::allow_outgoing_ports": [ 80, 443 ]
   }

Deny any Outgoing Ports
~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: json

   {
     "nftables::allow_outgoing_ports": false
   }

Automatic Rules
===============

Where possible, we add required firewall rules when you configure a certain service, for example:

* the :ref:`server-website` module will allow incoming HTTP/HTTPS
* the :ref:`server-ftp` module will allow incoming FTP

.. index::
   triple: Server; Firewall; Custom Rules
   :name: server-firewall_customrules

Custom Rules
============

To allow your desired incoming or outgoing connections, you can add custom firewll rules ``/etc/nftables.conf``
by adding the rule to the ``nftables::rules`` hash within the `Custom JSON` :ref:`server-customjson_server`:

.. code-block:: json

   {
     "nftables::rules": {
       "accept incoming port example for IPv4": {
         "chain": "input",
         "rule": "tcp dport 1234 accept ip saddr 192.168.1.1"
       },
       "accept incoming port example for IPv6": {
         "chain": "input",
         "rule": "tcp dport 1234 accept ip6 saddr 2001:db8::1"
       },
       "accept outgoing port example for IPv4": {
         "chain": "output",
         "rule": "tcp dport 1234 accept ip daddr 192.168.1.1"
       },
       "accept outgoing port example for IPv6": {
         "chain": "output",
         "rule": "tcp dport 1234 accept ip6 daddr 2001:db8::1"
       }
     }
   }

.. attention:: Make sure to always add rules for both IPv4 and IPv6.

.. tip:: Details about possible rule configurations are listed in the `nftables Wiki <https://wiki.nftables.org/wiki-nftables/index.php/Quick_reference-nftables_in_10_minutes#Rules>`__.

Request Limits
==============

nftables can also be used to  limit requests matching certain conditions.

.. tip::

   You can also limit connections within your :ref:`server-firewall_customrules`.
   Details about possible configurations are listed in the
   `nftables Wiki <https://wiki.nftables.org/wiki-nftables/index.php/Rate_limiting_matchings>`__.

By default, we limit the following connections:

Incoming SSH
------------

Incoming SSH connections are limited to 15 per minute. You can alter or remove
this limit by setting the ``nftables::input_ssh_limit`` within the `Custom JSON`
:ref:`server-customjson_server`:

.. code-block:: json

   {
     "nftables::input_ssh_limit": "15/minute"
   }

Incoming ICMP
-------------

Incoming ICMP connections are limited to 10 per second. You can alter or remove
this limit by setting the ``nftables::input_icmp_limit`` within the `Custom JSON`
:ref:`server-customjson_server`:

.. code-block:: json

   {
     "nftables::input_icmp_limit": "10/second"
   }

Incoming ICMPv6
---------------

Incoming ICMPv6 connections are limited to 10 per second. You can alter or remove
this limit by setting the ``nftables::input_icmpv6_limit`` within the `Custom JSON`
:ref:`server-customjson_server`:

.. code-block:: json

   {
     "nftables::input_icmpv6_limit": "10/second"
   }

Debugging
=========

To debug your firewall configuration syntax or take a look at the log files,
you can login in with the `devop` user (see :ref:`server-access-devop`).

Commands
--------

The following commands are available:

* ``nft-list`` to list the current nftables configuration.
* ``nft-check`` to validate the current nftables configuration.
  This command will also show you the problematic parts if you have any errors in your syntax.

Log Files
---------

Blocked connections are logged to `syslog` and written to ``/var/log/messages``.
This file is readable trough `devop` user (see :ref:`server-access-devop`) as well.

