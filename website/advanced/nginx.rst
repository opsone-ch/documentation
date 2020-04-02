.. index::
   triple: Website; Custom Configuration; nginx
   :name: website-advanced-nginx

=====
nginx
=====

You can add specific configurations to nginx on serveral levels.

.. index::
   triple: Website; nginx; Website Level Configuration
   :name: website-advanced-nginx_website

Website Level
=============

The file ``~/cnf/nginx.conf`` will be included within the ``server {}`` configuration
of the current vhost. It is used to alter the configuration of the current website.

.. tip:: After changes, reload nginx with the ``nginx-reload`` shortcut.

.. tip::

   For Details, see the `Server Block Examples <http://wiki.nginx.org/ServerBlockExample>`__ and
   `Rewrite Rule <http://wiki.nginx.org/HttpRewriteModule#rewrite>`__ documentation


Examples
--------

Add Basic Auth to Location
~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    location ~* "^/example/" {
        auth_basic "Example name";
        auth_basic_user_file /home/user/www/example/.htpasswd;
        root /home/user/www/;
    }

IP Protection
~~~~~~~~~~~~~

::

    allow <your-address>;
    allow 2a04:503:0:102::2:4;
    allow 91.199.98.23;
    deny all;

Custom MIME Type
~~~~~~~~~~~~~~~~

::

    include mime.types;
    types {
        text/cache-manifest appcache;
    }

Context Specific
----------------

While the main configuration should go into ``~/cnf/nginx.conf``, you can also use :ref:`website-context` specific
files which are taken into account when the repsective context is used only:

* ``~/cnf/nginx-prod.conf``
* ``~/cnf/nginx-stage.conf``
* ``~/cnf/nginx-dev.conf``

These files will be loaded, but are not created by default.

.. index::
   triple: Website; nginx; Server Level Configuration
   :name: website-advanced-nginx_server

Server Level
============

The file ``/etc/nginx/custom/http.conf`` is directly integrated in ``http { }``,
before ``server { }`` and can only be edited with the :ref:`access_devop` user.
You can use this file for settings that must be configured at nginx http context.

.. index::
   triple: Website; nginx; Custom Configuration Include
   :name: website-advanced-nginx_include

Custom Configuration Include
============================

Include your own, external configuration files within ``server { }`` or ``http { }``
by including the following configuration to your server's ``Custom JSON``:

.. code-block:: json

   {
     "nginx::global_config::server_file": "/absolut/path/to/your/server.conf",
     "nginx::global_config::http_file": "/absolut/path/to/your/http.conf"
   }

.. tip:: This is especially useful, when you deploy your own configuration with :ref:`globalrepo`.

.. index::
   triple: Website; nginx; Webroot
   :name: website-advanced-nginx_webroot

Custom Webroot
==============

By default, the webroot directory is choosen according vendor recommendations,
depending on the selected type. Some deployment workflows require other locations,
which you can select through the ``custom_webroot`` string within the
`Custom JSON` :ref:`customjson_website`:

.. code-block:: json

   {
     "custom_webroot": "deploy/current/html"
   }

.. warning::

   The directory specified here needs to be a real directory. **Symlinks are not allowed**.
   This applies only to the last directory though (in the example above, ``current`` can be
   a symlink but ``html`` cannot).

.. index::
   triple: Website; nginx; Log Format
   :name: website-advanced-nginx_logformat

Custom Log Format
=================

To alter the format used for nginx access logs, for example due to privacy reasons,
you can use the ``website::wrapper::nginx::log_format`` string within the
`Custom JSON` :ref:`customjson_server`.

This configuration is only available globally for all websites on a server,
to change to default `combined` format to replace the actual visitors
ip address with 127.0.0.1, use the following example:

.. code-block:: json

   {
     "website::wrapper::nginx::log_format": "127.0.0.1 - $remote_user [$time_local] \"$request\" $status $body_bytes_sent \"$http_referer\" \"$http_user_agent\""
   }

