Caching
=======

.. warning::

   WIP: This content was not yet adapted and checked for version 7,
   which we will do as soon as possible.
   If in doubt, please contact us for details regarding this topic.

Install and manage different caching applications. By now, the following
backends are supported:

-  memcached
-  Varnish

memcached
---------

To install memcached, add ``memcached`` to the ``caching::backend``
hash.

Memory Ratio
~~~~~~~~~~~~

By default, a ``memory_ratio`` of 8 is used, which means memcached will
take up to 1/8 of this servers total memory.

address
~~~~~~~

By default, memcached will listen on the localhost interface. If memcached has to
bind to another address, use the ``address`` parameter to specify it.

port
~~~~

By default, memcached will listen on port 11211. If memcached has to bind to
another port, use the ``port`` parameter to specify it.

Full example
~~~~~~~~~~~~

.. code-block:: json

  {
    "caching::backend": {
      "memcached": {
        "ensure": "present",
        "memory_ratio": "8",
        "address": "127.0.0.1",
        "port": "11211"
      }
    }
  }

Varnish
-------

To install Varnish, add ``varnish`` to the ``caching::backend`` hash.

address/address6
~~~~~~~~~~~~~~~~

By default, Varnish will listen on the eth1 interface. If Varnish has to
bind to other addresses, use the ``address`` and ``address6`` parameter
to specify them.

port/port6
~~~~~~~~~~

By default, Varnish will listen on port 80. If Varnish has to bind to
another port, use the ``port`` and ``port6`` parameter to specify them.

vcl\_type
~~~~~~~~~

With ``vcl_type``, you choose a tempalte which is used by Varnish as
default VCL configuration. By now, the following types are available:

-  ``default``: Varnish default configuration which does not very much
   but is perfetly suitable for your own, custom configuration trough
   ``vcl_include``
-  ``typo3``: Varnish configuration for the ``varnish`` TYPO3 extension
   (see
   `GitLab <https://gitlab.com/opsone_ch/typo3/varnish/-/blob/master/Resources/Private/Example/default.vcl>`__)

vcl\_include
~~~~~~~~~~~~

With ``vcl_include``, you can define a full path to a additional
configuration file. This file gets included into the Varnish default
configuration.

.. hint:: keep in mind to issue a ``puppet-agent`` run after changing the local Varnish configuration. Puppet will copy your local configuration file to a global location and ensure that Varnish is able to read it

Memory Ratio
~~~~~~~~~~~~

By default, a ``memory_ratio`` of 2 is used, which means Varnish will
take up to 50% of this servers total memory.

daemon_options
~~~~~~~~~~~~~~

Add one or more startup options to the Varnish daemon with ``daemon_options``.

.. warning:: changing this value can led to unintended consequences. Please make sure to plan any changes carefully and ask us for advice if you're in doubt

Full example
~~~~~~~~~~~~

.. code-block:: json

  {
    "caching::backend": {
      "varnish": {
        "ensure": "present",
        "address": "185.17.68.153",
        "port": "80",
        "address6": "2a04:503:0:1003::153",
        "port6": "80",
        "vcl_type": "default",
        "vcl_include": "/home/user/cnf/varnish.vcl",
        "memory_ratio": "4"
      },
      "caching::wrapper::varnish::daemon_options": "-p vcc_allow_inline_c=on"
    }
  }

Redis
-----

The Redis service is used to install and run Redis.
Redis is configured as a cache, therefore no data is stored persistently.

Memory Ratio
~~~~~~~~~~~~

By default, a ``memory_ratio`` of 2 is used, which means Redis
will take up to 1/2 of this servers total memory.

maxmemory_policy
~~~~~~~~~~~~~~~~

``maxmemory_policy`` is configured to ``noeviction`` by default.
Read more `about maxmemory at Redis <https://redis.io/topics/lru-cache>`__.

Full example
~~~~~~~~~~~~

.. code-block:: json

  {
    "base::modules": [
      "redis"
    ],
    "redis::memory_ratio": "2",
    "redis::maxmemory_policy": "noeviction"
  }

Usage
~~~~~

By default, Redis is bound to localhost on its default port 6379 (``127.0.0.1:6379``).

.. hint:: most applications will connect automatically with this default settings

PHP
~~~

Depending on your applications requirements, you might need the *phpredis* extension to use
Redis from PHP. The extension is precompiled and installed, but not loaded by default. 

To load *phpredis* in your environment, specify the extenion in ``~/cnf/php.ini``:

.. code-block:: ini

  extension = redis.so

.. hint:: For details, see :ref:`custom PHP configuration <website_php.ini>`.

Debugging
~~~~~~~~~

For debugging purposes, use *redis-cli* to connect to the Redis server:

.. code-block:: console

  $ redis-cli set key1 test
  OK
  $ redis-cli --scan
  key1
  $ redis-cli get key1
  "test"

.. hint:: for details, see the `redis-cli documentation <https://redis.io/topics/rediscli>`__
