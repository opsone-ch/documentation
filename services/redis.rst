Redis
=====

The ``redis`` service is used to install and run Redis.

Configuration
-------------

Options
"""""""

Currently, there are no options available. Please contact us if you need something in particular.

Full example
""""""""""""

.. code-block:: json

  {
    "base::modules": [
      "redis"
    ]
  }

Usage
-----

By default, Redis is bound to localhost on its default port 6379 (``127.0.0.1:6379``).

.. hint:: most applications will connect automatically with this default settings

PHP
===

Depending on your applications requirements, you might need the *phpredis* extension to use
Redis from PHP. The extension is precompiled and installed, but not loaded by default. 

To load *phpredis* in your environment, specify the extenion in ``~/cnf/php.ini``:

.. code-block:: ini

  extension = redis.so

.. hint:: see :ref:`Custom PHP configuration <php.ini>` for details

Debugging
---------

For debugging purposes, use *redis-cli* to connect to the Redis server:

.. code-block:: console

  $ redis-cli set key1 test
  OK
  $ redis-cli --scan
  key1
  $ redis-cli get key1
  "test"

.. hint:: for details, see the `redis-cli documentation <https://redis.io/topics/rediscli>`__

