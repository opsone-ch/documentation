.. index::
   single: Website
   :name: website

=======
Website
=======

To create a new website, there are only a few settings required:

* `name` will define the name used for system wide settings like users
  or databases (see :ref:`website-name`)
* `type` will define the preloaded settings for a certain application
  type (see :ref:`website-type`)
* `context` will define the context used within your application and
  is also used to set some default settings (see :ref:`website-context`)
* (optional) a `server name` when your website must listen to other
  hostnames than the default one

After creating, you can log into your newly created website by using
the websites name as SSH username (see :ref:`access-ssh`).

This and all other options are outlined within this chapter:

.. toctree::
   :maxdepth: 2

   name
   type
   context
   ssl
   waf
   limits
   envvar
   cron
   advanced/index

Custom configuration
--------------------

node
^^^^

.. warning:: use only to enable node within another website type for actions like gulp. To run your own node based website, use the `nodejs`_ type

To execute custom node commands (for example gulp), add nvm (Node Version Manager) to any website by setting
the following custom JSON:

.. code-block:: json

    {
      "nvm": true
    }

By default, the latest node lts version will be installed, however you can also install and select any other version.

::

    $ nvm ls-remote
    $ nvm install <version>

.. hint:: see the `nvm readme <https://github.com/creationix/nvm#usage>`__ for details

security configuration
^^^^^^^^^^^^^^^^^^^^^^

Access to certain private files and directories like ``.git`` is forbidden by including the global ``/etc/nginx/custom/security.conf`` file within the vhost configuration.

This file also contains the following security headers:

* ``add_header X-Frame-Options "SAMEORIGIN" always;``
* ``add_header X-Content-Type-Options "nosniff" always;``
* ``add_header X-XSS-Protection "1; mode=block always";``
* ``add_header Referrer-Policy "strict-origin-when-cross-origin" always;``

You can disable this include by setting ``security_conf`` to ``false`` within the custom JSON configuration. If you disable this, we recommend to copy the content into your own nginx.conf and adjust it to your own needs (you can view the content with the devop user). Please be aware of any ramifications, and do not disable this
settings unless you absolutely know what you're doing.

.. warning:: make sure to deny access to private files and directories manually, or include our global security locations from ``/etc/nginx/custom/security.conf`` within your own configuration.

.. index::
   triple: Website; Listen; Port
   :name: website_listen

Listen
------

By default, nginx will bind to the primary IP address of the eth0
interface and the 80/443 port. You can specify listen options explicitly
per website, for example within setups where Varnish is used and the
nginx vhost does not have to listen on external interfaces.

.. code-block:: json

  {
    "website::sites": {
      "username": {
        "env": "PROD",
        "type": "php",
        "listen_ip": "127.0.0.1",
        "listen_port": "8080",
        "listen_options": "option_value",
        "ipv6_listen_ip": "::1",
        "ipv6_listen_port": "8080",
        "ipv6_listen_options": "option_value"
      }
    }
  }

.. hint:: If you set ``listen_options`` and ``ipv6_listen_options`` to ``default_server``, the corresponding web page becomes the default server and listens to every server name.

Monitoring
----------

All sites with ``"env": "PROD"`` are monitored 24/7 by default. If you
have some sites with frequent outages (e.g. for development purposes),
which have to have ``"env": "PROD"`` for other reasons, or sites which
are not reachable from everywhere due to security reasons, please
deactivate monitoring by setting ``"monitoring": "false"`` in custom JSON:

.. code-block:: json

    {
      "monitoring": false
    }

