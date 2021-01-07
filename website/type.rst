.. index::
   pair: Website; Type
   :name: website-type

====
Type
====

The selected `type` will determine the configuration of your website.

.. index::
   triple: Website; Type; Basic Types
   :name: website-type_basic

Basic Types
===========

To run your own application with a certain technology stack, use one
of our basic types.

.. index::
   triple: Website; Type; Docker
   :name: website-type_docker

Docker
------

This Type is used to run your own Docker container behind a website acting
as reverse proxy.

* a website type :ref:`website-type_proxy` is configured
* Docker will be installed and configured
* created website user is member of the `docker` group and thus allowed
  to execute ``docker`` commands

.. tip:: Also take a look at our How-to :ref:`howto-docker`.

.. index::
   triple: Website; Type; HTML
   :name: website-type_html

HTML
----

Used to create a HTML only website with no dynamic processing altogether.

.. index::
   triple: Website; Type; Node.js
   :name: website-type_nodejs

Node.js
-------
Your Node.js application is executed with a daemon controlled by Monit. To work properly, its necessary to run the application directly and not by, for example, ``npm run start`` which would fork the actuall process and lead to incorrect process handling.

.. tip:: Have a look at our How-to :ref:`howto-nuxt` as well.

* select custom node version trough `nvm <https://github.com/creationix/nvm#usage>`__, by default, the latest node lts version is installed
* nodejs has to listen on the ``~/cnf/nodejs.sock`` socket, permission ``660``

  * most applications are able to listen on unix sockets which is our preferred way to connect Node applications to the webserver
  * for technical details, see ``server.listen`` within the `Node api documentation <https://nodejs.org/api/net.html#net_server_listen_path_backlog_callback>`__
  * if you cannot configure your application to listen on a unix socket, you can configure a custom TCP port by setting ``nodejs_port`` in `Custom JSON` :ref:`customjson_website`
  * you have to make sure the port is not already in use
  * you have to make sure your application does listen on this particular TCP port (the configured port from ``nodejs_port`` is exposed as ``$NODEJS_PORT`` environment variable for dynamic configurations)

* symlink your app.js to ``~/app.js`` or overwrite path or other daemon
  options in ``OPTIONS`` at ``~/cnf/nodejs-daemon``:

  ::

      OPTIONS="/home/nodejs/application/app.js --prod"

.. tip:: to control the nodejs daemon, use the ``nodejs-restart`` shortcut

.. index::
   triple: Website; Type; PHP
   :name: website-type_php

PHP
---

* PHP installed and running as FPM service included in nginx
* you can select the desired version at the `Advanced` tab
* for custom configurations, see :ref:`website-advanced-php`

.. index::
   triple: Website; Type; Pytohn
   :name: website-type_python

Python
------

* uWSGI daemon (place or symlink your appropriate wsgi configuration to ``~/wsgi.py``)
* Python venv configured within uWSGI and the user login shell

.. tip:: To control the uwsgi daemon, use the ``uwsgi-reload`` and ``uwsgi-restart`` shortcuts.

.. index::
   triple: Website; Type; Proxy
   :name: website-type_proxy

Proxy
-----

* nginx website configured as reverse proxy
* select the desired backend with the `Proxy Pass` setting
* the `Proxy pass` value must also include the protocol. Example: ``http://127.0.0.1:8080``

.. tip::

   To use advanced features like multiple backends, create your own upstream configuration in ``/etc/nginx/custom/http.conf`` and point ``proxy_pass`` to it.
   See :ref:`website-advanced-nginx_server` nginx configuration.

.. index::
   triple: Website; Type; Redirect
   :name: website-type_redirect

Redirect
--------

* to redirects everything to a custom target
* set `Target` to your desired destination
* by default, we send a 307 HTTP redirect code

To use your own redirect code, add the ``target_code`` string within the
`Custom JSON` :ref:`customjson_website`:

.. code-block:: json

   {
     "target_code": "301"
   }

.. tip:: You can use any nginx variable as target (for example ``$scheme://www.example.com$request_uri``), see the `nginx Documentation <http://nginx.org/en/docs/varindex.html>`__ for available variables.

.. index::
   triple: Website; Type; Ruby
   :name: website-type_ruby

Ruby
----

* rbenv configured within foreman and the user login shell
* Foreman daemon, controlled by Monit
* Ruby has to listen on the ``~/cnf/ruby.sock`` socket, permission ``660``
* symlink your Procfile to ``~/`` or overwrite path or other daemon
  options in ``OPTIONS`` at ``~/cnf/ruby-daemon``:

   ::

       OPTIONS="start web -f project/Procfile"

.. tip::

   To control the Ruby daemon, use the
   ``ruby-start`` / ``ruby-stop`` / ``ruby-restart`` shortcuts.

.. tip::

   To use a custom Ruby version, see the
   `rbenv <https://github.com/rbenv/rbenv#command-reference>`__ manual.

.. index::
   triple: Website; Type; Application Types
   :name: website-type_application

Application Types
=================

We provide elaborated types for certain web applications. If your desired
application is amongst them, we recommend to use them instead of a basic
type.

.. index::
   triple: Website; Type; Drupal
   :name: website-type_drupal

Drupal
---------

* :ref:`website-type_php` type with PHP version 7.4
* MariaDB database
* application related PHP and nginx configuration (webroot ``~/web``)
* application related cronjobs (see :ref:`website-cron_type`)
* application related WAF rules (see :ref:`website-waf`)

.. index::
   triple: Website; Type; Magento 1
   :name: website-type_magento1

Magento 1
---------

* :ref:`website-type_php` type with PHP version 5.6
* MariaDB database
* application related PHP and nginx configuration (webroot ``~/pub``)
* application related cronjobs (see :ref:`website-cron_type`)
* application related WAF rules (see :ref:`website-waf`)

.. index::
   triple: Website; Type; Magento 2
   :name: website-type_magento2

Magento 2
---------

* :ref:`website-type_php` type with PHP version 7.2
* MariaDB database
* application related PHP and nginx configuration (webroot ``~/pub``)
* application related cronjobs (see :ref:`website-cron_type`)
* application related WAF rules (see :ref:`website-waf`)

.. index::
   triple: Website; Type; Neos
   :name: website-type_neos

Neos
----

* :ref:`website-type_php` type with PHP version 7.4
* MariaDB database
* application related PHP and nginx configuration (webroot ``~/Web``)
* application related WAF rules (see :ref:`website-waf`)
* ``FLOW_CONTEXT`` environment variable set according to selected :ref:`website-context`
* ``FLOW_REWRITEURLS`` environment variable enabled

Required Configuration
~~~~~~~~~~~~~~~~~~~~~~

.. warning:: Our approach to dynamically configure PHP is not compatible with Neos by default.

As a workaround, we have to let know Neos about the environment variable
required to load the appropriate PHP settings, by defining the the
``PHP_INI_SCAN_DIR`` environment variable in ``Configuration/Settings.yaml``:

.. code-block:: yaml

  Neos:
    Flow:
      core:
        subRequestEnvironmentVariables:
          PHP_INI_SCAN_DIR: '/etc/php72/user/<username>/:/home/<username>/cnf/'

.. tip:: See `this Neos Discuss thread <https://discuss.neos.io/t/setup-process-error-with-custom-php-environment/4174>`__ for technical details.

.. index::
   triple: Website; Type; TYPO3 6
   :name: website-type_typo3v6

TYPO3 v6
--------

* :ref:`website-type_php` type with PHP version 5.6
* MariaDB database
* application related PHP and nginx configuration
* application related cronjobs (see :ref:`website-cron_type`)
* application related WAF rules (see :ref:`website-waf`)
* latest TYPO3 6 version available in ``/opt/typo3/TYPO3_6/``
* ``TYPO3_CONTEXT`` environment variable set according to selected :ref:`website-context`

Required Configuration
~~~~~~~~~~~~~~~~~~~~~~

.. warning::

   As this TYPO3 version has reached its end of life already,
   compatibility settings are required within the application.

* ``DB/Connections/Default/initCommands`` must be set to ``SET sql_mode = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';``
* PHP 5.6 does not have FreeType support included
* some (system) extensions like frontend do need a small adjustment (see `Ticket#83414 <https://forge.typo3.org/issues/83414#note-7>`__)

TYPO3 v7
--------

* :ref:`website-type_php` type with PHP version 7.2
* MariaDB database
* application related PHP and nginx configuration (webroot ``~/web``)
* application related cronjobs (see :ref:`website-cron_type`)
* application related WAF rules (see :ref:`website-waf`)
* latest TYPO3 7 version available in ``/opt/typo3/TYPO3_7/``
* ``TYPO3_CONTEXT`` environment variable set according to selected :ref:`website-context`

Required Configuration
~~~~~~~~~~~~~~~~~~~~~~

.. warning::

   As this TYPO3 version has reached its end of life already,
   compatibility settings are required within the application.

* Install Tool is not usable to install new versions from scratch (see `Ticket#82023 <https://forge.typo3.org/issues/82023>`__)
* ``DB/Connections/Default/initCommands`` must be set to ``SET sql_mode = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';``
* Some extensions like the frontend sysext need a small adjustment (see `Ticket#83414 <https://forge.typo3.org/issues/83414#note-7>`__)

.. index::
   triple: Website; Type; TYPO3 8
   :name: website-type_typo3v8

TYPO3 v8
--------

* :ref:`website-type_php` type with PHP version 7.2
* MariaDB database
* application related PHP and nginx configuration (webroot ``~/web``)
* application related cronjobs (see :ref:`website-cron_type`)
* application related WAF rules (see :ref:`website-waf`)
* latest TYPO3 8 version available in ``/opt/typo3/TYPO3_8/``
* ``TYPO3_CONTEXT`` environment variable set according to selected :ref:`website-context`

.. index::
   triple: Website; Type; TYPO3 9
   :name: website-type_typo3v9

TYPO3 v9
--------

* :ref:`website-type_php` type with PHP version 7.2
* MariaDB database
* application related PHP and nginx configuration (webroot ``~/web``)
* application related cronjobs (see :ref:`website-cron_type`)
* application related WAF rules (see :ref:`website-waf`)
* latest TYPO3 9 version available in ``/opt/typo3/TYPO3_9/``
* ``TYPO3_CONTEXT`` environment variable set according to selected :ref:`website-context`

.. index::
   triple: Website; Type; TYPO3 10
   :name: website-type_typo3v10

TYPO3 v10
---------

* :ref:`website-type_php` type with PHP version 7.4
* MariaDB database
* application related PHP and nginx configuration (webroot ``~/web``)
* application related cronjobs (see :ref:`website-cron_type`)
* application related WAF rules (see :ref:`website-waf`)
* latest TYPO3 10 version available in ``/opt/typo3/TYPO3_10/``
* ``TYPO3_CONTEXT`` environment variable set according to selected :ref:`website-context`

.. index::
   triple: Website; Type; Wordpress
   :name: website-type_wordpress

Wordpress
---------

* :ref:`website-type_php` type with PHP version 7.4
* MariaDB database
* application related PHP and nginx configuration
* application related cronjobs (see :ref:`website-cron_type`)
* application related WAF rules (see :ref:`website-waf`)
* WP-CLI installed and available by using the ``wp`` command
* additional :ref:`website-limits` for ``wp-login.php`` and ``xmlrpc.php`` (10r/m)

To override the default request limits, use the ``wordpress_limit_login``
and ``wordpress_limit_xmlrpc`` strings within the `Custom JSON` :ref:`customjson_website`:

.. code-block:: json

   {
     "wordpress_limit_login": "20r/m",
     "wordpress_limit_xmlrpc": false,
    }

.. tip:: Please disable the built in HTTP call to wp-cron.php by setting ``define('DISABLE_WP_CRON', true);``. This additional call is not necessary and disabling it will lower the load on your system.

