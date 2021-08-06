.. index::
   single: Varnish
   :name: varnish

=======
Varnish
=======

Varnish is fully configured through the `Custom JSON` :ref:`customjson_server`.

Enable
======

To install Varnish, set ``varnish::ensure`` to `present`.

address/address6
================

By default, Varnish will listen on the localhost interface. If Varnish has to
bind to other addresses, use the ``address`` and ``address6`` parameter
to specify them.

port/port6
==========

By default, Varnish will listen on port 8022. If Varnish has to bind to
another port, use the ``port`` and ``port6`` parameter to specify them.

backend_host/backend_port
=========================

By default, Varnish will use 127.0.0.1 as backend host and 8080 as backend port.
If Varnish has to use another backend, use the ``backend_host`` and ``backend_port`` parameter to specify them.

vcl\_type
=========

With ``vcl_type``, you choose a tempalte which is used by Varnish as
default VCL configuration. By now, the following types are available:

* ``default``: Varnish default configuration which does not very much
  but is perfetly suitable for your own, custom configuration trough
  ``vcl_include``
* ``typo3``: Varnish configuration for the ``varnish`` TYPO3 extension
  (see
  `GitLab <https://gitlab.com/opsone_ch/typo3/varnish/-/blob/master/Resources/Private/Example/default.vcl>`__)

vcl\_include
============

By default, Varnish uses HTTP headers to decide whether a request should be cached or not.
See the chapter `The role of HTTP Headers <https://varnish-cache.org/docs/6.1/users-guide/increasing-your-hitrate.html#the-role-of-http-headers>`_ in the official Varnish documentation.

With ``vcl_include``, you can define a full path to a additional
configuration file. This file gets included into the Varnish default
configuration.

.. tip::

   Keep in mind to issue a ``puppet-agent`` run after changing the local
   Varnish configuration. Puppet will copy your local configuration file
   to a global location and ensure that Varnish is able to read it.

Memory Ratio
============

By default, a ``memory_ratio`` of 2 is used, which means Varnish will
take up to 50% of this servers total memory.

daemon_options
==============

Add one or more startup options to the Varnish daemon with ``daemon_options``.

Minimal example
===============

Configuration through `Custom JSON` :ref:`customjson_server`.

.. code-block:: json

   {
     "varnish::ensure": "present"
   }

Varnish uses the default configurations as described above.

Full example
============

Configuration through `Custom JSON` :ref:`customjson_server`.

.. code-block:: json

   {
     "varnish::ensure": "present",
     "varnish::address": "192.168.1.1",
     "varnish::port": "80",
     "varnish::address6": "2001:db8::1",
     "varnish::port6": "80",
     "varnish::vcl_type": "default",
     "varnish::vcl_include": "/home/user/cnf/varnish.vcl",
     "varnish::memory_ratio": "4",
     "varnish::daemon_options": "-p vcc_allow_inline_c=on",
     "varnish::backend_host": "127.0.0.1",
     "varnish::backend_port": "8080"
   }

Tools
=====

You can run these tools by login with the devop user (see :ref:`access_devop`).

* ``varnishlog``: `Display Varnish logs <https://varnish-cache.org/docs/trunk/reference/varnishlog.html>`__
* ``varnishncsa``: `Display Varnish logs in NCSA combined log format <https://varnish-cache.org/docs/trunk/reference/varnishncsa.html>`__
* ``varnishhist``: `Varnish request histogram <https://varnish-cache.org/docs/trunk/reference/varnishhist.html>`__
* ``varnishstat``: `Varnish Cache statistics <https://varnish-cache.org/docs/trunk/reference/varnishstat.html>`__
* ``varnishtop``: `Varnish log entry ranking <https://varnish-cache.org/docs/trunk/reference/varnishtop.html>`__
* ``varnish-reload``: Reloads the Varnish Daemon
* ``varnish-restart``: Restarts the Varnish Daemon