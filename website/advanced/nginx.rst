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

    # allow your ip
    allow <your-address>;

    # allow our monitoring
    allow 2a04:503:0:1008::112;
    allow 185.17.70.112;
    deny all;

Custom MIME Type
~~~~~~~~~~~~~~~~

::

    include mime.types;
    types {
        text/cache-manifest appcache;
    }

Favicon per Domain
~~~~~~~~~~~~~~~~~~

::

    location = /favicon.ico {
        try_files /favicons/$http_host.ico /favicons/default.ico
    }

DCV (Domain Control Validation)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    location ~ ^\/.well-known\/pki-validation\/fileauth\.txt$ {
            allow all;
            satisfy any;
            alias /path/to/fileauth.txt;
    }

ACME Challenge
~~~~~~~~~~~~~~

::

    location ~ ^\/.well-known\/acme-challenge\/(.*)$ {
        allow all;
        satisfy any;
        alias /usr/local/dehydrated/.acme-challenges/$1;
    }

Custom Maintenance Page
~~~~~~~~~~~~~~~~~~~~~~~

::

    error_page 404 /error/404.html
    error_page 503 /error/maintenance.html;

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

.. index::
   triple: Website; Listen; Port
   :name: website-advanced-nginx_listen

Listen
======

By default, nginx will bind to the primary IP address of the eth0
interface and the 80/443 port. You can specify listen options explicitly
per website, for example to use in concunction with Varnish.

The following options are available within the `Custom JSON`
:ref:`customjson_website`:

.. code-block:: json

  {
    "listen_ip": "127.0.0.1",
    "listen_port": "8080",
    "listen_options": "option_value",
    "ipv6_listen_ip": "::1",
    "ipv6_listen_port": "8080",
    "ipv6_listen_options": "option_value"
  }

.. tip::

   If you set ``listen_options`` and ``ipv6_listen_options`` to ``default_server``,
   the corresponding web page becomes the default server and listens to every server name.
   This is useful for landing/fallback pages where you do not want to add every host name
   individually.

