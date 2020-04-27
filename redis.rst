.. index::
   single: Redis
   :name: redis

=====
Redis
=====

The Redis service is used to install and run Redis.
Redis is configured as a cache, therefore no data is stored persistently.

Redis is fully configured through the `Custom JSON` :ref:`customjson_server`.

Enable
======

To install Redis, set ``redis::ensure`` to `present`.

Memory Ratio
============

By default, a ``memory_ratio`` of 2 is used, which means Redis
will take up to 50% of the servers total memory.

maxmemory_policy
================

``maxmemory_policy`` is configured to ``noeviction`` by default.
Read more `about maxmemory at Redis <https://redis.io/topics/lru-cache>`__.

Full example
============

.. code-block:: json

  {
    "redis::ensure": "present",
    "redis::memory_ratio": "2",
    "redis::maxmemory_policy": "noeviction"
  }

Usage
=====

By default, Redis is bound to localhost on its default port 6379 (``127.0.0.1:6379``).

.. tip:: most applications will connect automatically with this default settings

PHP
===

Depending on your applications requirements, you might need the *phpredis* extension to use
Redis from PHP. The extension is precompiled and installed, but not loaded by default. 

To load *phpredis* in your environment, specify the extenion in ``~/cnf/php.ini``:

.. code-block:: ini

  extension = redis.so

.. tip:: For details, see :ref:`custom PHP configuration <website-advanced-php>`.

Debugging
=========

For debugging purposes, use *redis-cli* to connect to the Redis server:

.. code-block:: console

  $ redis-cli set key1 test
  OK
  $ redis-cli --scan
  key1
  $ redis-cli get key1
  "test"

.. tip:: for details, see the `redis-cli documentation <https://redis.io/topics/rediscli>`__
