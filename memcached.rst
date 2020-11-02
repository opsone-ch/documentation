.. index::
   single: Memcached
   :name: memcached

=========
Memcached
=========

Memcached is fully configured through the `Custom JSON` :ref:`customjson_server`.

Enable
======

To install memcached, set ``memcached::ensure`` to `present`.


Memory Ratio
============

By default, a ``memory_ratio`` of 8 is used, which means memcached will
take up to 1/8 of this servers total memory.

address
=======

By default, memcached will listen on the localhost interface. If memcached has to
bind to another address, use the ``address`` parameter to specify it.

port
====

By default, memcached will listen on port 11211. If memcached has to bind to
another port, use the ``port`` parameter to specify it.

Full example
============

Configuration through `Custom JSON` :ref:`customjson_server`.

.. code-block:: json

   {
     "memcached::ensure": "present",
     "memcached::memory_ratio": "8",
     "memcached::address": "127.0.0.1",
     "memcached::port": "11211"
   }

