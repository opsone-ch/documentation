.. index::
   triple: How-to; PHP; Debugging
   :name: howto-phpdebugging

=============
PHP Debugging
=============

We use the PHP extension `Xdebug <https://xdebug.org/>`__ for debugging purposes.

.. tip::

   As alternative, we also provide a :ref:`website-advanced-blackfire` integration
   (external service, Blackfire account and subscription required).

Context
-------

Xdebug is enabled in ``DEV`` :ref:`website-context`, but can also be enabled in
the `Cockpit <https://cockpit.opsone.ch>`__ for ``STAGE`` and ``PROD`` context.
In the following we describe the Xdebug *Debug* and *Profile* feature.

For more features and details please refer to the `Xdebug documentation <https://xdebug.org/docs/>`__.

Xdebug Debug
------------

The Xdebug *Debug* Feature allows you to walk through your code to debug control flow and examine data structures.
You can use any IDE that supports Xdebug (DBGp protocol). This also includes PhpStorm and Visual Studio Code (with the `PHP Debug Extension <https://marketplace.visualstudio.com/items?itemName=felixfbecker.php-debug>`__).

To start you need to enable the *Debug* feature in ``~/cnf/php.ini`` and reload php with ``php-reload``.

.. code-block:: ini

  xdebug.mode = debug
  xdebug.start_with_request = yes

Afterwards, Xdebug sends debugging information to a predefined address and port.
To allow debug sessions with multiple websites at the same time,
a random port is assigned to each website at ``xdebug.client_port``.
If you debugg a website on our server you ned to reverse forward this port to your local machine/IDE.

.. code-block:: bash

  ssh -R 127.0.0.1:15750:127.0.0.1:9003 <username>@<hostname>
       ▲             ▲              ▲         ▲
       │             │              │         │
       │       xdebug.client_port   │    Website name and Server
  Reverse forward                Your IDE

Your IDE now has access to the debugging information at ``127.0.0.1:9003`` (Xdebug default port).

.. tip:: Use ``php -r 'echo ini_get("xdebug.client_port");'`` to get the debugging port.

Custom Port/Host
~~~~~~~~~~~~~~~~

Set the ``xdebug.client_port`` and ``xdebug.client_host`` string
within the `Custom JSON` :ref:`customjson_server`:

.. code-block:: json

  {
    "xdebug::client_port": "9003",
    "xdebug::client_host": "127.0.0.1"
  }

.. warning:: If set, those values will apply for all websites on this server. You'll loose the ability to debug multiple websites concurrently.

Xdebug Profile
--------------

The *Profile* feature allows you to find bottlenecks in your script and visualize those with an external tool such as KCacheGrind or WinCacheGrind.

To start you need to enable the *Profile* feature in ``~/cnf/php.ini`` and reload php with ``php-reload``.

.. code-block:: ini

  xdebug.mode = profile
  xdebug.start_with_request = yes

By default, profiler output will be written into the ``~/tmp/`` directory.



.. warning:: Enable profiling can generate a lot of data. Make sure your diskspace is sufficient to store this files and disable profiling as soon as possible

Trigger
-------

Both features, *Debug* and *Profile*, support a trigger.
The trigger ensures that the feature is not activated for every, but only for selected requests.
For this you ned to set ``xdebug.start_with_request`` in ``~/cnf/php.ini`` to ``trigger`` and reload php with ``php-reload``.

.. code-block:: ini

  xdebug.mode = debug,profile
  xdebug.start_with_request = trigger

Cou can trigger Xdebug *Debug* and *Profile* by using the ``XDEBUG_TRIGGER`` GET/POST parameter, or set a cookie with the name ``XDEBUG_TRIGGER``.
There are also `browser extensions <https://xdebug.org/docs/step_debug#browser-extensions>`__ that do this for you.