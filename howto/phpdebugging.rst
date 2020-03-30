.. index::
   triple: How-to; PHP; Debugging
.. _howto-phpdebugging:

=============
PHP Debugging
=============

We use `Xdebug <https://xdebug.org/>`__ for debugging purposes. For
details, please refer to the `Xdebug
documentation <https://xdebug.org/docs/>`__.

Environments
------------

Xdebug is installed and enabled in all ``DEV`` environments

Debugging
---------

Remote debugging is enabled by default in all ``DEV`` environments.
To allow multiple debug
sessions in multiple installations at the same time, a random port is
assigned to each website at ``xdebug.remote_port``. If your debug
destination (e.g. PhpStorm) is on another machine, you have to reverse
forward this debug port to your desired destination, e.g.
``ssh -R 13377:localhost:13377 <username>@<hostname>``.

.. hint:: Use ``php -r 'echo ini_get("xdebug.remote_port");'`` to get the debugging port.

Custom Xdebug Port/Host
~~~~~~~~~~~~~~~~~~~~~~~

You can specify own  values for ``xdebug.remote_port`` and ``xdebug.remote_host`` through Hiera.

.. code-block:: json

  {
    "xdebug::remote_port": "9000",
    "xdebug::remote_host": "192.168.0.1"
  }

.. warning:: If set, those values will apply for all websites on this server. You'll loose the ability to debug multiple websites concurrently.

Profiler
--------

Profiling is disabled by default, enable it by setting
``xdebug.profiler_enable = On`` or you can trigger the generation of
profiler files by using the ``XDEBUG_PROFILE`` GET/POST parameter, or
set a cookie with the name ``XDEBUG_PROFILE``. By default, profiler
output well be written into the ``~/tmp/`` directory.

.. warning:: Enable profiling can generate a lot of data. Make sure your diskspace is sufficient to store this files and disable profiling as soon as possible

