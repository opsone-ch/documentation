Website Service
===============

Our website module provides everything you need, to manage, deploy and
run your website. It is type and environment based which means you have
to select a particular type (e.g. typo3cms) and environment (e.g. PROD).
According those settings, our automation will setup the server/vhost as
required.

Add website
-----------

Add a website with a configuration like this:

.. code-block:: json

  {
    "website::sites": {
      "username": {
        "server_name": "example.net www.example.net",
        "env": "PROD",
        "type": "php"
      }
    }
  }

-  username: Is used as system user name (SSH Login, CGI User) and
   database name, if a database exist
-  2 - 16 lowercase letters only (as this name is used in several
   places, we have to limit its value to the least common denominator)
-  server\_name: add host names which this vhost will listen on. You
   have to define all names explicit, also with and/or without www.
-  env: One of DEV, STAGE or PROD (see `Environments`_)
-  type: software type of this particular website (see `Types`_)

By adding a website, the following parts are created on the server:

-  system user
-  system group
-  home directory (/home/username/)
-  directory for temporary files (/home/username/tmp/)
-  directory for log files (/home/username/log/)
-  directory for additional configuration files (/home/username/cnf/)
-  directory for backups (used for database dumps,
   /home/username/backup/)
-  environment variables for bash and zsh (~/.profile and ~/.zprofile)
-  SSH authorised keys
-  webserver vhost configuration (for custom configurations, see `Custom configuration`_)

Types
-----

You have to define one of the following types for each website.

.. note:: If you need a type not mentioned here yet, do not hesitate to contact us

typo3cms
^^^^^^^^

-  nginx 1.6 with naxsi WAF, core rule set and TYPO3 white/blacklists
-  PHP-FPM 5.6
-  MariaDB 10.x with database, user, and grants
-  TYPO3 CMS 6.2 cloned into /var/lib/typo3/TYPO3\_6-2/
-  TYPO3 Scheduler executed every 5 minutes

.. code-block:: json

  {
    "website::sites": {
      "examplenet": {
        "password": "Efo9ohh4EiN3Iifeing7eijeeP4iesae",
        "server_name": "typo3.example.net www.typo3.example.net",
        "env": "PROD",
        "type": "typo3cms"
      }
    }
  }

To use other TYPO3 CMS versions, add the following array:

.. code-block:: json

  {
    "website::typo3versions": [
      "4.5"
    ]
  }

At the moment, only TYPO3 CMS 4.5 and 6.2 are available. For TYPO3 CMS
7.x, see seperate type below.

.. note:: please note that some older TYPO3 versions may not be fully compatible with this generation

typo3cmsv7
^^^^^^^^^^

-  nginx 1.6 with naxsi WAF, core rule set and TYPO3 7.x compatible
   white/blacklists
-  PHP-FPM 5.6
-  MariaDB 10.x with database, user, and grants
-  latest TYPO3 CMS 7.x cloned into /var/lib/typo3/TYPO3\_7/
-  Default webroot is ~/web
-  PHP-Settings adjusted to 7.x-requirements
-  TYPO3 ApplicationContext can be set
-  TYPO3 Scheduler executed every 5 minutes

.. code-block:: json

  {
    "website::sites": {
      "examplenet": {
        "password": "Efo9ohh4EiN3Iifeing7eijeeP4iesae",
        "server_name": "typo3.example.net www.typo3.example.net",
        "env": "PROD",
        "type": "typo3cmsv7",
        "applicationContext": "Production/Live"
      }
    }
  }

typo3cmsv8
^^^^^^^^^^

-  nginx 1.6 with naxsi WAF, core rule set and TYPO3 8 compatible white/blacklists
-  PHP-FPM 7.0 (self compiled and packaged version in `/opt/php/php70`)
-  MariaDB 10.x with database, user, and grants
-  latest TYPO3 CMS 8 cloned into /var/lib/typo3/TYPO3\_8/
-  Default webroot is ~/web
-  PHP-Settings adjusted to 8.x-requirements
-  TYPO3 ApplicationContext can be set
-  TYPO3 Scheduler executed every 5 minutes

.. code-block:: json

  {
    "website::sites": {
      "examplenet": {
        "password": "Efo9ohh4EiN3Iifeing7eijeeP4iesae",
        "server_name": "typo3.example.net www.typo3.example.net",
        "env": "PROD",
        "type": "typo3cmsv8",
        "applicationContext": "Production/Live"
      }
    }
  }

typo3neos
^^^^^^^^^

-  nginx 1.6 with naxsi WAF, core rule set and TYPO3 Neos
   white/blacklists
-  PHP-FPM 5.6
-  MariaDB 10.x with database, user, and grants

.. code-block:: json

  {
    "website::sites": {
      "neosexample": {
        "password": "Efo9ohh4EiN3Iifeing7eijeeP4iesae",
        "server_name": "neos.example.net www.neos.example.net",
        "env": "PROD",
        "type": "typo3neos"
      }
    }
  }

magento
^^^^^^^

-  nginx 1.6 with naxsi WAF, core rule set and magento white/blacklists
-  PHP-FPM 5.6 with mcrypt module
-  MariaDB 10.x with database, user, and grants

.. code-block:: json

  {
    "website::sites": {
      "magentoexample": {
        "server_name": "magento.example.net",
        "env": "PROD",
        "type": "magento",
        "password": "Aiw7vaakos04h7e"
      }
    }
  }

magento2
^^^^^^^^

-  nginx 1.6 with naxsi WAF, core rule set and Magento 2 white/blacklists
-  PHP-FPM 7.0 (self compiled and packaged version in `/opt/php/php70`)
-  PHP modules and settings adjusted to Magento 2 requirements
-  nginx vHost adjusted to Magento 2 requirements
-  MariaDB 10.x with database, user, and grants

.. code-block:: json

  {
    "website::sites": {
      "magentotwoexample": {
        "server_name": "magento2.example.net",
        "env": "PROD",
        "type": "magento2",
        "password": "Aiw7vaakos04h7e"
      }
    }
  }

wordpress
^^^^^^^^^

- nginx 1.6 with naxsi WAF, core rule set and WordPress
  white/blacklists
- PHP-FPM 5.6
- MariaDB 10.x with database, user, and grants
- WP-CLI
- wp-cron.php is called every 5 minutes over CLI

.. hint:: Please disable the built in HTTP call to wp-cron.php by setting ``define('DISABLE_WP_CRON', true);``. This additional call is not necessary and disabling it will lower the load on your system.

.. code-block:: json

  {
    "website::sites": {
      "wordpressexample": {
        "server_name": "wordpress.example.net",
        "env": "PROD",
        "type": "wordpress",
        "password": "Aiw7vaakos04h7e"
      }
    }
  }

wordpress70
^^^^^^^^^^^

-  nginx 1.6 with naxsi WAF, core rule set and WordPress
   white/blacklists
-  PHP-FPM 7.0 (self compiled and packaged version in `/opt/php/php70`)
-  MariaDB 10.x with database, user, and grants
-  WP-CLI

.. code-block:: json

  {
    "website::sites": {
      "wordpressexample": {
        "server_name": "wordpress.example.net",
        "env": "PROD",
        "type": "wordpress70",
        "password": "Aiw7vaakos04h7e"
      }
    }
  }

drupal
^^^^^^

-  nginx 1.6 with naxsi WAF, core rule set and drupal white/blacklists
-  PHP-FPM 5.6
-  MariaDB 10.x with database, user, and grants

.. code-block:: json

  {
    "website::sites": {
      "drupalexample": {
        "server_name": "drupal.example.net",
        "env": "PROD",
        "type": "drupal",
        "password": "Aiw7vaakos04h7e"
      }
    }
  }

php
^^^

-  nginx 1.6 with naxsi WAF and core rule set
-  PHP-FPM 5.6
-  MariaDB 10.x with database, user, and grants (use "dbtype": "mysql",
   otherwise without database)

.. code-block:: json

  {
    "website::sites": {
      "phpexamplenet": {
        "server_name": "php.example.net",
        "env": "PROD",
        "type": "php",
        "dbtype": "mysql",
        "password": "Aiw7vaakos04h7e"
      }
    }
  }

php70
^^^^^

-  nginx 1.6 with naxsi WAF and core rule set
-  PHP-FPM 7.0 (self compiled and packaged version in `/opt/php/php70`)
-  MariaDB 10.x with database, user, and grants (use "dbtype": "mysql",
   otherwise without database)

.. code-block:: json

  {
    "website::sites": {
      "phpexamplenet": {
        "server_name": "php.example.net",
        "env": "PROD",
        "type": "php70",
        "dbtype": "mysql",
        "password": "Aiw7vaakos04h7e"
      }
    }
  }

php72
^^^^^

-  nginx 1.6 with naxsi WAF and core rule set
-  PHP-FPM 7.2 (self compiled and packaged version in `/opt/php/php72`)
-  MariaDB 10.x with database, user, and grants (use "dbtype": "mysql",
   otherwise without database)

.. code-block:: json

  {
    "website::sites": {
      "phpexamplenet": {
        "server_name": "php.example.net",
        "env": "PROD",
        "type": "php72",
        "dbtype": "mysql",
        "password": "Aiw7vaakos04h7e"
      }
    }
  }

hhvm
^^^^

-  nginx 1.6 with naxsi WAF and core rule set
-  HHVM with PHP-FPM 5.6 fallback
-  MariaDB 10.x with database, user, and grants (use "dbtype": "mysql",
   otherwise without database)
-  please contact us to evaluate the feasibility within your project

.. code-block:: json

  {
    "website::sites": {
      "hhvmexamplenet": {
        "server_name": "hhvm.example.net",
        "env": "PROD",
        "type": "hhvm",
        "dbtype": "mysql",
        "password": "ohQueeghoh0bath"
      }
    }
  }

html
^^^^

-  nginx 1.6 with naxsi and core rule set
-  for static content only (this documentation is served trough the html
   type)

.. code-block:: json

  {
    "website::sites": {
      "htmlexamplenet": {
        "server_name": "html.example.net",
        "env": "PROD",
        "type": "html"
      }
    }
  }

uwsgi
^^^^^

-  nginx 1.6 with naxsi WAF and core rule set
-  uwsgi Daemon (Symlink your appropriate wsgi configuration to
   ~/wsgi.py)
-  Python virtualenv ``venv-<sitename>`` configured within uwsgi and the
   user login shell
-  there is no database added by default, choose one of
-  PostgreSQL 9.4 with database, user, and grants
   (``"dbtype": "postgresql"``)
-  MariaDB 10.x with database, user, and grants (``"dbtype": "mysql"``)
-  all requests are redirected to the uwsgi daemon by default. To serve
   static files, add appropriate locations to the `Custom configuration`_ like this:

   ::

       location /static/
       {
       root /home/user/application/;
       }

.. code-block:: json

  {
    "website::sites": {
      "uwsgiexample": {
        "server_name": "uwsgi.example.net",
        "env": "PROD",
        "type": "uwsgi",
        "dbtype": "postgresql",
        "password": "ohQueeghoh0bath"
      }
    }
  }

Hint: to control the uwsgi daemon, use the ``uwsgi-reload`` and
``uwsgi-restart`` shortcuts

Symfony
^^^^^^^

-  nginx 1.6 with naxsi WAF, core rule set and Symfony white/blacklists
-  PHP-FPM 5.6
-  MariaDB 10.x with database, user, and grants

.. code-block:: json

  {
    "website::sites": {
      "symfonyexample": {
        "password": "Efo9ohh4EiN3Iifeing7eijeeP4iesae",
        "server_name": "symfony.example.net www.symfony.example.net",
        "env": "PROD",
        "type": "symfony"
      }
    }
  }

Hint: For security reason, PHP execution is just allow for app.php,
app\_dev.php, config.php. All other requests end up in a 403 forbidden
error.

Redirect
^^^^^^^^

-  nginx 1.6
-  301 redirect domain(s) (add server name) to custom target
-  `$scheme://www.example.com`\ request\_uri (with request uri parameters)
-  `$scheme://www.example.com` (request every uri to www.example.com)
-  `$scheme://www.example.com/subsite/` (redirect the domain to any subsite of example.com)
-  TLS / SSL is available

.. code-block:: json

  {
    "redirectexample": {
      "server_name": "example.to",
      "target": "$scheme://domain.com$request_uri",
      "env": "PROD",
      "type": "redirect"
    }
  }

Proxy
^^^^^

-  nginx 1.6
-  Proxy requests to a server or group of servers:
-  hostname, IPs and ports are available
-  works also with unix sockets
-  TLS / SSL is supported

.. code-block:: json

  {
    "proxyexample": {
      "server_name": "proxy.to",
      "env": "PROD",
      "type": "proxy",
      "members": [
        "localhost:8080",
        "127.0.0.1:8081",
        "unix:/tmp/backend"
      ]
    }
  }

Hint: to proxy external sites / hosts please contact our support.
(outgoing firewall rules needs to be applied)

nodejs
^^^^^^

-  nginx 1.6 with naxsi WAF and core rule set
-  nodejs daemon, controlled by monit
-  symlink your app.js to ~/app.js or overwrite path or other daemon
   options in ``OPTIONS`` at ``~/cnf/nodejs-daemon``:

   ::

       OPTIONS="/home/nodejs/application/app.js --prod"

-  nodejs has to listen on the ``~/cnf/nodejs.sock`` socket, permission
   ``660``
-  there is no database added by default, choose one of
-  PostgreSQL 9.4 with database, user, and grants
   (``"dbtype": "postgresql"``)
-  MariaDB 10.x with database, user, and grants (``"dbtype": "mysql"``)
-  all requests are redirected to the nodejs daemon by default. To serve
   static files, add appropriate locations to the `Custom configuration`_ like this:

   ::

       location /static/
       {
           root /home/user/application/;
       }

.. code-block:: json

  {
    "website::sites": {
      "nodejs": {
        "server_name": "nodejs.example.net",
        "env": "PROD",
        "type": "nodejs",
        "dbtype": "mysql",
        "password": "ohQueeghoh0bath"
      }
    }
  }

Hint: to control the nodejs daemon, use the ``nodejs-restart`` shortcut

todoyu
^^^^^^

-  nginx 1.6 with naxsi WAF, core rule set and todoyu white/blacklists
-  PHP-FPM 5.6
-  MariaDB 10.x with database, user, and grants
-  access to external SMTP/POP3/IMAP ports
-  todoyu cronjob
-  todoyu access rules

.. code-block:: json

  {
    "website::sites": {
      "todoyuexample": {
        "password": "Efo9ohh4EiN3Iifeing7eijeeP4iesae",
        "server_name": "todoyu.example.net www.todoyu.example.net",
        "env": "PROD",
        "type": "todoyu"
      }
    }
  }

ruby
^^^^

-  nginx 1.6 with naxsi WAF and core rule set
-  Python virtualenv ``venv-<sitename>`` configured within the
   user login shell
-  ruby rbenv configured within foreman and the
   user login shell
-  foreman daemon, controlled by monit
-  symlink your Procfile to ~/ or overwrite path or other daemon
   options in ``OPTIONS`` at ``~/cnf/ruby-daemon``:

   ::

       OPTIONS="start web -f project/Procfile"

-  ruby has to listen on the ``~/cnf/ruby.sock`` socket, permission
   ``660``
-  there is no database added by default, choose one of
    -  PostgreSQL 9.4 with database, user, and grants
       (``"dbtype": "postgresql"``)
    -  MariaDB 10.x with database, user, and grants (``"dbtype": "mysql"``)
-  all requests are redirected to the ruby daemon by default. To serve
   static files, add appropriate locations to the `Custom configuration`_ like this:

   ::

       location /static/
       {
           root /home/user/application/;
       }

.. code-block:: json

  {
    "website::sites": {
      "ruby": {
        "server_name": "ruby.example.net",
        "env": "PROD",
        "type": "ruby",
        "dbtype": "mysql",
        "password": "ohQueeghoh0bath"
      }
    }
  }

.. hint:: to control the nodejs daemon, use the ``ruby-start`` / ``ruby-stop`` / ``ruby-restart`` shortcuts

Environments
------------

You have to select one of those environments for each website:

PROD
^^^^

-  for live sites
-  no access protection
-  phpinfo disabled (visible database credentials from environment variables)
-  E-Mails get sent to their designated recipient (PHP mail() only, see :doc:`../development/email` for details)

STAGE
^^^^^

-  for stage / preview / testing access
-  password protected (User "preview", password from "htpasswd" option)
-  phpinfo enabled
-  E-Mails get saved as file into the ~/tmp/ directory (PHP mail() only, :doc:`../development/email` for details)

DEV
^^^

-  for development
-  password protected (User "preview", password from "htpasswd" option)
-  phpinfo enabled
-  Xdebug enabled, see :doc:`../development/phpdebugging` for details)
-  E-Mails get saved as file into the ~/tmp/ directory (PHP mail() only, :doc:`../development/email` for details)

User Handling
^^^^^^^^^^^^^

The preview user gets applied to all non PROD environments and is
intended for your own use, but also to allow access to other parties
like your customer. Use the "htpasswd" option to set a particular
password to the preview user. You have to use a htpasswd encrypted value
which you can generate like this on your local workstation:

::

    htpasswd -n preview

Configuration example:

.. code-block:: json

  {
    "devexamplenet": {
      "type": "typo3cms",
      "env": "DEV",
      "server_name": "dev.example.net www.dev.example.net",
      "password": "1234",
      "htpasswd": "$apr1$RSDdas2323$23case23DCDMY.0xgTr/"
    }
  }

Furthermore, you can add additional users trough the "website::users"
configuration like this:

.. code-block:: json

  {
    "website::users": {
      "alice": {
        "preview": "$apr1$RXDs3l18$w0VJrVN5uoU6DMY.0xgTr/"
      },
      "bob": {
        "preview": "$apr1$RSDdas2323$23case23DCDMY.0xgTr/"
      }
    }
  }

You can add such uers for yourself and your co-workers. If you work on
multiple websites, you do not have to look up the corresponding password
all the time but just use the global one.

To rename the default "preview" username, use the ``preview_username`` parameter on a website:

.. code-block:: json

  {
    "devexamplenet": {
      "type": "typo3cms",
      "env": "DEV",
      "server_name": "dev.example.net www.dev.example.net",
      "password": "1234",
      "preview_username": "showme",
      "htpasswd": "$apr1$RSDdas2323$23case23DCDMY.0xgTr/"
    }
  }

Furthermore, its possible to set the preview username globally through ``website::preview_username``.

.. note:: Please keep in mind that this password gets often transfered over unencrypted connections. As always, we recommend to use a particular password for only this purpose

Disable exeptions
^^^^^^^^^^^^^^^^^

Never show detailed application based exeptions on PROD, to avoid
`information
leakage <https://www.owasp.org/index.php/Information_Leakage>`__.
Disable the output directly in your application. For example in TYPO3:

::

    $TYPO3_CONF_VARS['SYS']['displayErrors'] = '0'; 

Environment Variables
~~~~~~~~~~~~~~~~~~~~~

For each website, the following environment variables are created by
default, and are available within the shell and also the webserver.

-  SITE\_ENV (DEV, STAGE or PROD)
-  DB\_HOST (Database hostname, only if there is a database)
-  DB\_NAME (Database name, only if there is a database)
-  DB\_USERNAME (Database username, only if there is a database)
-  DB\_PASSWORD (Database password, only if there is a database)

.. hint:: to use the .profile environmet within a cronjob, prepend the following code to your command: ``/bin/bash -c 'source $HOME/.profile; ~/original/command'``

Example usage within PHP
^^^^^^^^^^^^^^^^^^^^^^^^

As soon there is a database installed, the following variables are added
to the environment and can be used from within your application. TYPO3
Example:

::

    $typo_db_username = $_SERVER['DB_USERNAME'];
    $typo_db_password = $_SERVER['DB_PASSWORD'];
    $typo_db_host     = $_SERVER['DB_HOST'];
    $typo_db          = $_SERVER['DB_NAME'];

Additionaly, you can use the "SITE\_ENV" variable to set parameters
according the current environment:

::

    switch ($_SERVER['SITE_ENV']) {
        case 'DEV':
            $recipient = 'dev@example.net';
            break;
        case 'STAGE':
            $recipient = 'dev@example.net';
            break;
        case 'PROD':
            $recipient = 'customer@example.com';
            break;
    }

If you configure your application like this, you can copy all data
between different servers or vhosts (DEV/STAGE/PROD) and all settings
are applied as desired.

Example usage within typoscript
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

    [globalString = _SERVER|SITE_ENV = DEV]
        # doSometing
    [global]


TLS Certificates
----------------

By adding a TLS certificate to your website, the following
configurations/features are applied to the vhost:

-  SPDY 3.1
-  TLS 1.0, 1.1, 1.2
-  SNI
-  HSTS
-  daily Expiration Date Check
-  global HTTP to HTTPS redirect

Automated Certificate Management Environment (ACME/Let's Encrypt)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

We support ACME certificates by `Let's
Encrypt <https://letsencrypt.org/>`__. To enable this, set ``ssl_acme``
to true. You can select a specific ACME provider by
``ssl_acme_provider``, however by now only ``letsencrypt`` is available
and already set as default, so you can omit this usually.

.. warning:: Let's Encrypt will try to reach your server by HTTP. Make sure that all hosts added to ``server_name`` end up on your server already, otherwise validation will fail

Debug validation problems
~~~~~~~~~~~~~~~~~~~~~~~~~

In order to debug validation issues, we introduced the ``letsencrypt-renew`` shortcut which will trigger a run of our Let's Encrypt client, and let you see all debug output to identifiy possible problems.

- Make sure that all hosts added to ``Server name`` point to the correct server (A and AAAA DNS records).
- Let's Encrypt will try to reach your website at the endpoint ``/.well-known/acme-challenge/`` for validation purposes. Make sure that you do not overwrite this path within your `own nginx configuration <#custom-configuration>`__.
- You can check access to the validation directory by yourself by fetching the control file reachable at ``http://example.com/.well-known/acme-challenge/monitoring``

Renewal
~~~~~~~

Certificates from Let's Encrypt will be valid for 90 days. They are renewed automatically as soon as they expire in under 30 days. You can follow these checks and renewals by grep for ``letsencrypt`` in ``/var/log/syslog``.

Furthermore, we check all certificates from our monitoring and will contact you if there are certificates expiring in less than 21 days.

Export
~~~~~~

Existing Lets Encrypt certificates can be read with the `devop user <../server/access.html#generic-devop-user>`__.
This is useful if you want to temporarily use the old certificate on a new server (e.g. for a migration).

You can find your certificates under ``/etc/nginx/tls``.

.. warning:: As soon as the certificates leave our servers, we no longer have control over them. Please be aware of this and be careful.

Configuration example
~~~~~~~~~~~~~~~~~~~~~

.. code-block:: json

  {
    "devexamplenet": {
      "type": "html",
      "env": "PROD",
      "ssl_acme": "true",
      "ssl_acme_provider": "letsencrypt",
      "server_name": "dev.example.net www.dev.example.net"
    }
  }

Order certificate
^^^^^^^^^^^^^^^^^

Requirements
^^^^^^^^^^^^

To validate domain ownership, our certificate issuer will send a E-Mail
to one of the following addresses:

-  webmaster@example.net
-  admin@example.net
-  administrator@example.net

Create certificate and key
^^^^^^^^^^^^^^^^^^^^^^^^^^

::

    $ openssl req -newkey rsa:4096 -x509 -nodes -days 3650 -out www.example.net.crt -keyout www.example.net.key
    Country Name (2 letter code) [AU]:CH
    State or Province Name (full name) [Some-State]:Luzern
    Locality Name (eg, city) []:Luzern
    Organization Name (eg, company) [Internet Widgits Pty Ltd]:example Ltd
    Organizational Unit Name (eg, section) []:
    Common Name (eg, YOUR name) []:www.example.net
    Email Address []:webmaster@example.net

Extract certificate signing request
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

    openssl x509 -x509toreq -signkey www.example.net.key -in www.example.net.crt

Submit this CSR to us for further processing, or order certificate by yourself from the issuer of your choice.

Configure website
^^^^^^^^^^^^^^^^^

-  ssl\_key: generated private key
-  ssl\_cert: signed certificate, including appropriate intermediate
   certificates

Note: make sure to use the correct line indenting

.. code-block:: json

  {
    "website::sites": {
      "magentoexample": {
        "server_name": "magento.example.net",
        "env": "PROD",
        "type": "magento",
        "password": "Aiw7vaakos04h7e",
        "ssl_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDRHc47/0zg+cAg\nMkHKY1U7TOFChPawiNmU94MYjOTzK/Lc4C2op1sDCAP4Ow+qx7BK8NLJkHUPyOXU\nzjTTTUN/dGoElGz4gFaCCkMhk8hRZEs8jTwAm8tq4ruUVk9DIgQ9K/potm5kzT/T\nKyW85hETMLi+tRw9Kbn/j4QljWmqcd4mPWyaMT1o4lDTszq7NCHGch+dxa4FJYib\nz05C6+BVpw9w+BWFERlbgG5hvMMXtxexlju24e2fJV/TPCVbgDk/ecFDhupRMdj9\nZKrlPcUZNReWxgX+ZGT8YfWI2tYfW9+H6iVvcwV2gftiDp4+N4r4Ae52cMFxcKBR\n5fn4i8hbAgMBAAECggEAYv66MBr3GRYChvtju9z0b2NAzE3HvuC6KFRYAlpI1Hl8\numWCF/JKGpBD2NKU4yMvaPrCvtsdH8DaVLjdtx4/kunYepyNTcLrsRoMl6uvTCCv\noVW3Dw6x6MK3TEzjrwM+gHr+S235qsyjp2MotVkwwiXxf46bdLT5MWuOgnyEhkQQ\ncmv6qDmjgDP5vH5r4riAlPKMq+jGtLc/2QWs22UxQS0/a7n0pks472AonLI8r1M8\nsYcCAC6uEvxRZdVcJOlRK78dPI3NLxFhSbvv/GcVOypyhvQ3uVYV71xA/AgcpBLd\nFc2FULRCCU/UEjmo62uYNkG09lCchBwK8BLYYWrCoQKBgQDqL5Eo9oLMTuzysu8I\nvemXODOTfxQb1OTH1dyA4kSAtmNF2IO5rNnvVsS5YlbSjZMEXRMYTSflp7L7ae2l\nXLqjhijdB6l5cdgsPyHD2phYOvJzWMuzjkCtIjm5QfdMfsUZnBSPbwaRF1zWxbVn\nmHlWi3Zcu8U65l9gsJviZelqqwKBgQDkmG4W1SEySON4i44JwzsmXQHP1d8KHES1\nhB1IETNYV2HzIAWnnX/fqPwqyahzegKTGut9U7kJ8QHsHvz56nHdiQ8zw4BZxQPw\nj4Pms1IpzpO48yf4swskqwgkk5W6wTHCD/Q48tqFtAMPwC/D88F966ipc6lyldsJ\nUXvLeeMZEQKBgGTHYZWaOAGKOYfcHufJKnwMEI350wKDJI0m6ISCWu51DtWg7lb6\nHrNTyMbqnehwSoNHNo9vrKq0914gYMeX1y3F71HnGTSNHHU2Gea57HOTsoCXBtpX\nblfTcbnavHyr1VBHDcYIBnBr+GTooj9Zq2XmEGKp35+QQh1PA1ZzevaPAoGASdop\nLv06VVmRC9/iSqslT/aaYEATZ9vMIuyE3USZVwAcKAT/brCGoIaiuVwfLPeNH2OC\nEyJaVKjlWxiD2GXy1YSzQaD2tYneBPkIvx7N+62+sfD0x/doMTeEUPTRWd2SqsSm\nvUNQcAPBPXR0uhTlPT5GZkB0zQ03D6KgoRNG2FECgYEAgXPJjIsqhcC0PNEuRgdC\n9pZq+Prvp4TniVwQKyPniw/FjAplI4uN/+1fiYPexaLzINnXUuvOTYPABec3T2DZ\nGV0lffmdZ+CleU1Xi5DjLGn8m0Gdy6mecE2Le9/Q13o3owF9rm0Drhqqd8T6vVt3\nhiw7C+lCp2XheqP+QchwxiY=\n-----END PRIVATE KEY-----\n",
        "ssl_cert": "-----BEGIN CERTIFICATE-----\nMIIEATCCAumgAwIBAgIJAMdVCMOVZl30MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYD\nVQQGEwJDSDEPMA0GA1UECAwGWnVyaWNoMQ8wDQYDVQQHDAZadXJpY2gxIzAhBgNV\nBAoMGnNub3dmbGFrZSBwcm9kdWN0aW9ucyBHbWJIMRowGAYDVQQDDBF0eXBvMy5l\neGFtcGxlLm5ldDEkMCIGCSqGSIb3DQEJARYVd2VibWFzdGVyQGV4YW1wbGUubmV0\nMB4XDTE1MDIxMjEyMDU1MloXDTI1MDIwOTEyMDU1MlowgZYxCzAJBgNVBAYTAkNI\nMQ8wDQYDVQQIDAZadXJpY2gxDzANBgNVBAcMBlp1cmljaDEjMCEGA1UECgwac25v\nd2ZsYWtlIHByb2R1Y3Rpb25zIEdtYkgxGjAYBgNVBAMMEXR5cG8zLmV4YW1wbGUu\nbmV0MSQwIgYJKoZIhvcNAQkBFhV3ZWJtYXN0ZXJAZXhhbXBsZS5uZXQwggEiMA0G\nCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDRHc47/0zg+cAgMkHKY1U7TOFChPaw\niNmU94MYjOTzK/Lc4C2op1sDCAP4Ow+qx7BK8NLJkHUPyOXUzjTTTUN/dGoElGz4\ngFaCCkMhk8hRZEs8jTwAm8tq4ruUVk9DIgQ9K/potm5kzT/TKyW85hETMLi+tRw9\nKbn/j4QljWmqcd4mPWyaMT1o4lDTszq7NCHGch+dxa4FJYibz05C6+BVpw9w+BWF\nERlbgG5hvMMXtxexlju24e2fJV/TPCVbgDk/ecFDhupRMdj9ZKrlPcUZNReWxgX+\nZGT8YfWI2tYfW9+H6iVvcwV2gftiDp4+N4r4Ae52cMFxcKBR5fn4i8hbAgMBAAGj\nUDBOMB0GA1UdDgQWBBSSJyPyLa8CNKMDR3BAOcuuzzEqlTAfBgNVHSMEGDAWgBSS\nJyPyLa8CNKMDR3BAOcuuzzEqlTAMBgNVHRMEBTADAQH/MA0GCSqGSIb3DQEBCwUA\nA4IBAQAMKv2Kdw2LkskJm/GAkEsavoYf6qAPruwcsp8cx+7doXOpptZ/w+m8NK8i\n6ffi65wQ4TGlFxEvXM1Ts4S1xF/+6JVnnp8RVGvfgDL7xi6juMqbtM5yBxjHKO6W\nAuxOmwPcd6cO5qL+MCSgIe13bn/V4bw/JLv9LONuwXHJuv0FEoazbSyB6uTwYf2D\npWHEkXvkz5A1hqu3y2jFq2cQffoO31GGx29U3uSl+Esp5bL/J0bQd3TUbwvu6FY1\nNgUR7Mx1t/4/uk9FRl87d2rRslc5VyvD5v7MFE6jYJap74j5BrrfUUTNbzVXdPCS\nv8jOaIjDp5AMoZxbPMlv/5Tk85uF"
      }
    }
  }

Warning: Make sure the first ``server_name`` used is valid within your
certificate as we redirect all HTTP requests within this vHost to
``https://first-in-server_name``

HTTP redirect
^^^^^^^^^^^^^

By default, all HTTP requests within a given vHost are redirected to HTTPS using the first name in ``server_name``. If you want to change this behaviour somehow, for example by keep the current hostname of the HTTP request, you can set ``http_redirect_dest`` to another value like ``https://$host$request_uri``.

Furthermore, its possible to set the redirect destination globally through ``website::http_redirect_dest`` which will be used on all HTTP redirects without a explicitly set ``http_redirect_dest``.

Cipher Suite
^^^^^^^^^^^^

You can configure a desired cipher suite configuration trough `website::ssl_ciphers`:

.. code-block:: json

  {
    "website::ssl_ciphers": "desired-cipher-suites"
  }

.. warning:: We configure and update this value with sane defaults. Overwrite only when really required, and if you are aware of the consequences.


Diffie-Hellman parameters
^^^^^^^^^^^^^^^^^^^^^^^^^

Diffie-Hellman parameters are used for perfect forward secrecy. We supply default
Diffie-Hellman parameters and update them on a regular schedule. If you want to use
your own Diffie-Hellman parameters, you can generate them:

::

  openssl dhparam -out /tmp/dhparam.pem 4096

and configure them trough `website::ssl_dhparam`:

.. code-block:: json

  {
    "website::ssl_dhparam": "-----BEGIN DH PARAMETERS-----\nMIICCAKCAgEAoOePp+Uv2M34IA+basW9CBHp/jsZihB3FI8KVRLVFJPIUJ9Llm8F\n...\n-----END DH PARAMETERS-----"
  }

HSTS Header
^^^^^^^^^^^

By default, we add a HTTP Strict Transport Security (HSTS) header to each TLS enabled website:

::

 Strict-Transport-Security max-age=63072000;

Use the `header_hsts` parameter to override the default HSTS header:

.. code-block:: json

  {
    "header_hsts": "max-age=3600; includeSubDomains; preload"
  }

.. hint:: See the OWASP `HTTP Strict Transport Security Cheat Sheet <https://www.owasp.org/index.php/HTTP_Strict_Transport_Security_Cheat_Sheet>`__ for details

Test
^^^^

We recommend the following online services for testing:

-  `Qualys SSL Labs <https://www.ssllabs.com/ssltest/>`__
-  `Symantec SSL
   Toolbox <https://ssltools.websecurity.symantec.com/checker/views/certCheck.jsp>`__

Web Application Firewall
------------------------

We use `Naxsi <https://github.com/nbs-system/naxsi>`__ as additional
protection against application level attacks such as cross
site-scripting or SQL injections. We also block common vulnerabilities
and zero day attacks, see our `status site <http://status.snowflake.ch/>`__ for updates.

Warning: this is just a additional security measure. Regardless its
existence, remember to keep your application, extensions and libraries
secure and up to date

Identify blocks
^^^^^^^^^^^^^^^

If a request is blocked, the server will issue a "403 forbidden" error.
There are detailed informations available in the error log file:

::

    2015/02/17 14:03:04 [error] 15296#0: *1855 NAXSI_FMT: ip=192.168.0.22&server=www.example.net&uri=/admin/&learning=0&vers=0.53-1&total_processed=1&total_blocked=1&block=1&cscore0=$XSS&score0=8&zone0=BODY|NAME&id0=1310&var_name0=login[username]&zone1=BODY|NAME&id1=1311&var_name1=login[username], client: 192.168.0.22, server: www.example.net, request: "POST /admin/ HTTP/1.1", host: "www.example.net", referrer: "http://www.example.net/admin/"

To learn more about the log syntax, vist the `Naxsi
documentation <https://github.com/nbs-system/naxsi/wiki>`__.

Extensive logging
^^^^^^^^^^^^^^^^^

If you want to debug the WAF block (often used with internal rules), you
can increase the nginx error log level to "debug".

See `Nginx documentation error
log <http://nginx.org/en/docs/ngx_core_module.html#error_log>`__ for
more information.

Manage false positives
~~~~~~~~~~~~~~~~~~~~~~

If you are certain, that your request to the application is valid (and
well coded), you can whitelist the affected rule(s) within the
~/cnf/nginx\_waf.conf File:

::

    BasicRule wl:1310,1311 "mz:$ARGS_VAR:tx_sfpevents_sfpevents[event]|NAME";
    BasicRule wl:1310,1311 "mz:$ARGS_VAR:tx_sfpevents_sfpevents[controller]|NAME";

See the `Naxsi
documentation <https://github.com/nbs-system/naxsi/wiki/whitelists>`__
for details.

.. hint:: to apply the changes reload the nginx configuration with the ``nginx-reload`` shortcut

.. hint:: we strongly recommend to add the ``~/cnf/`` directory to the source code management of your choice

Autocreate rules
~~~~~~~~~~~~~~~~

With nx\_util, you can parse & analyze naxsi log files. It will propose
appropriate whitelist rules tailored to your application

Warning: Use on DEV/STAGE Environment only. Otherwise you will end up
whitelisting actual attacks.

::

    /usr/local/bin/nx_util.py -lo error.log

    Deleting old database :naxsi_sig
    List of imported files :['error.log']
    Importing file error.log
            Successful events :6
            Filtered out events :0
            Non-naxsi lines :0
            Malformed/incomplete lines 5
    End of db commit...
    Count (lines) success:6
    ########### Optimized Rules Suggestion ##################
    # total_count:2 (33.33%), peer_count:1 (100.0%) | ], possible js
    BasicRule wl:1311 "mz:$URL:/events/event/|$ARGS_VAR:tx_sfpevents_sfpevents[controller]|NAME";
    # total_count:2 (33.33%), peer_count:1 (100.0%) | [, possible js
    BasicRule wl:1310 "mz:$URL:/events/event/|$ARGS_VAR:tx_sfpevents_sfpevents[controller]|NAME";
    # total_count:1 (16.67%), peer_count:1 (100.0%) | ], possible js
    BasicRule wl:1311 "mz:$URL:/events/event/|$ARGS_VAR:tx_sfpevents_sfpevents[event]|NAME";
    # total_count:1 (16.67%), peer_count:1 (100.0%) | [, possible js
    BasicRule wl:1310 "mz:$URL:/events/event/|$ARGS_VAR:tx_sfpevents_sfpevents[event]|NAME";

Learning Mode
~~~~~~~~~~~~~

To enable the Naxsi learning mode, set the Naxsi flag in the
``~/cnf/nginx.conf`` file:

::

     set $naxsi_flag_learning 1;

Which means that Naxsi will not block any request, but logs the
"to-be-blocked" requests in your ``~log/error.log``.

Warning: Use on DEV/STAGE Enviroment only. Otherwise you will end up
with an unprotected installation.

Make sure, that you analyze the error.log carefully and only whitelist
valid requests afterwards.

Dynamic configuration
^^^^^^^^^^^^^^^^^^^^^

Naxsi supports a limited set of variables, that can override or modify
its behavoir. You can use them in your ``~/cnf/nginx.conf`` file. For
example, enable the learning mode for an specific ip:

::

     if ($remote_addr = "1.2.3.4") {
      set $naxsi_flag_learning 1;
     }

More on the `dynamicmodifiers page <https://github.com/nbs-system/naxsi/wiki/dynamicmodifiers>`__.

.. hint:: this is a powerful feature in use with the `nginx vars <http://nginx.org/en/docs/varindex.html>`

Request limits
--------------

The number of connections and requests are limited to ensure that a
single user (or bot) cannot overload the whole server.

Limits
^^^^^^

-  50 connections / address
-  50 requests / second / address
-  150 requests / second (burst)
-  >150 requests / second / address (access limited)

With this configuration, a particular visitor can open up to 50
concurrent connections and issue up to 50 requests / second.

If the visitor issues more than 50 request / second, those requests are
delayed and other clients are served first.

If the visitor issues more than 150 request / second, those requests
will not processed anymore, but answered with the 503 status code.

Adjust limits
^^^^^^^^^^^^^

To adjust this limits (e.g. for special applications such as API calls,
etc), set a higher "load zone" in your local configuration
(``~/cnf/nginx.conf``):

::

    # connection limits (e.g. 75 connections)
    limit_conn addr 75;

    # limit requests / second: (small, medium, large)
    limit_req zone=medium burst=500;
    limit_req zone=large burst=1500;

.. hint:: to apply the changes reload the nginx configuration with the ``nginx-reload`` shortcut

Zones
^^^^^

-  small = 50 requests / second (burst: 150req/sec)
-  medium = 150 requests / second (burst: 500 req/sec)
-  large = 500 requests / second (burst: 1500 req/sec)

Note: the default zone is "small" and will fit most use cases

.. warning:: in SPDY, each concurrent request is considered a separate connection

.. hint:: for Details, see the `Module ngx\_http\_limit\_req\_module <http://nginx.org/en/docs/http/ngx_http_limit_req_module.html>`__ documentation

Custom configuration
--------------------

nginx
^^^^^

You can add specific configurations like redirects or headers within the
``~/cnf/`` directory.

.. warning:: You have to reload nginx after changes with the ``nginx-reload`` shortcut

~/cnf/nginx.conf
^^^^^^^^^^^^^^^^

Included within the server block and used to configure specific
redirects, enable gzip and other stuff directly in the nginx.conf.

::

    if ($http_host = www.example.net) {
        rewrite (.*) http://www.example.com;
    }

or you can password protect a subdirectory:

::

    location ~* "^/example/" {
        auth_basic "Example name";
        auth_basic_user_file /home/user/www/example/.htpasswd;
        root /home/user/www/;
        include /etc/nginx/custom/security.conf;
    }

.. warning:: when overriding default locations, make sure to deny access to private files and directories manually, or include our global security locations from ``/etc/nginx/custom/security.conf``.

or add a IP protection:

::

    allow <your-address>;
    allow 2a04:503:0:102::2:4;
    allow 91.199.98.23;
    deny all;

.. hint:: Always allow access from `91.199.98.23` and `2a04:503:0:102::2:4` (monitoring)

or add custom MIME types:

::

    include mime.types;
    types {
        text/cache-manifest appcache;
    }

if you like to run PHP in this subdirectory, don't forget to add this
nested in the location section from the example on top:

::

    location ~ \.php {
        try_files /dummy/$uri @php;
    }

.. hint:: for Details, see the `Server Block Examples <http://wiki.nginx.org/ServerBlockExample>`__ and `Rewrite Rule <http://wiki.nginx.org/HttpRewriteModule#rewrite>`__ documentation

~/cnf/nginx\_waf.conf
^^^^^^^^^^^^^^^^^^^^^

Configure WAF exeptions here, see `Web Application Firewall`_ for details.

/etc/nginx/custom/http.conf
^^^^^^^^^^^^^^^^^^^^^^^^^^^

This file is directly integrated in ``http { }``, before ``server { }`` and can only be edited with the ``devop`` user. You can use this file for settings that must be configured at nginx http context.

custom configuration include
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Include your own, external configuration files within ``server { }`` or ``http { }``.

* http level: set ``website::global_config_http``
* server level: set ``website::global_config_server``

.. hint:: with this setting, you can deploy own, system wide configuration files from a Git repository. See :doc:`globalrepo` for details.

custom webroot
^^^^^^^^^^^^^^

By default, the webroot directory location is choosen according vendor recommendations,
depending on the selected type.

Some deployment workflows require other locations, which you can select through the
`custom_webroot` parameter, relative to the home directory.

.. warning:: by now, the directory specified here needs to be a real directory (**no symlinks allowed**)

.. code-block:: json

  {
    "custom_webroot": "deploy/current/html"
  }

PHP
^^^

You can set custom PHP configurations trough a ``.user.ini`` files in
the corresponding directory, e.g. ``~/www/.user.ini``. See the `PHP
Documentation <http://php.net/manual/en/configuration.file.per-user.php>`__
for details.

custom log format
^^^^^^^^^^^^^^^^^

To alter the format used for nginx access logs, for example due to privacy reasons, you can use the ``website::wrapper::nginx::log_format`` configuration.

This configuration is only available globally for all websites on a server, to change to default "combined" format to replace the actual visitors ip address with 127.0.0.1, use the following example:

.. code-block:: json

  {
    "website::wrapper::nginx::log_format": "127.0.0.1 - $remote_user [$time_local] \"$request\" $status $body_bytes_sent \"$http_referer\" \"$http_user_agent\""
  }

Cronjobs
--------

Add custom cronjobs through the `crontab -e` command:

::

    SHELL=/usr/local/vzscripts/sfoutputtosyslog
    PHP_INI_SCAN_DIR=:/etc/php5/cli/user/<username>/

    #       +------------------------------------ minute (0 - 59)
    #       |       +---------------------------- hour (0 - 23)
    #       |       |       +-------------------- day of month (1 - 31)
    #       |       |       |       +------------ month (1 - 12)
    #       |       |       |       |       +---- day of week (0 - 6) (Sunday=0 or 7)
    #       |       |       |       |       |

    #       10      2       *       *       *       <command>

            5	    *       *       *       *       <path-to-job>

.. hint:: For PHP based jobs, please set `PHP_INI_SCANDIR` manually to make sure that user specific settings are respected

type related cronjobs
^^^^^^^^^^^^^^^^^^^^^

* Application specific cronjobs are predefined already (for example, TYPO3 scheduler job on TYPO3 types, see type description for details)
* if you want to disable this type related cronjob defined by us, set ``type_cronjob`` to ``false``

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

GeoIP
-----

To use your GeoIP database with nginx, store the appropriate data files
on your server and add the following configuration:

.. code-block:: json

  # GeoIP Settings for nginx
  {
    "nginx::http_cfg_append": [
      "geoip_country  /home/user/geoip/GeoIPv6.dat",
      "geoip_city /home/user/geoip/GeoLiteCityv6.dat"
    ]
  }

  # GeoIP related environment variables
  {
    "environment::variables": {
      "GEOIP_ADDR": "$remote_addr",
      "GEOIP_COUNTRY_CODE": "$geoip_country_code",
      "GEOIP_COUNTRY_NAME": "$geoip_country_name",
      "GEOIP_REGION": "$geoip_region",
      "GEOIP_REGION_NAME": "$geoip_region_name",
      "GEOIP_CITY": "$geoip_city",
      "GEOIP_AREA_CODE": "$geoip_area_code",
      "GEOIP_LATITUDE": "$geoip_latitude",
      "GEOIP_LONGITUDE": "$geoip_longitude",
      "GEOIP_POSTAL_CODE": "$geoip_postal_code"
    }
  }

.. hint:: for details, see the `Module ngx\_http\_geoip\_module <http://nginx.org/en/docs/http/ngx_http_geoip_module.html>`__ documentation

PHP Modules
-----------

To install additional PHP modules, use the following configuration:

.. code-block:: json

  {
    "website::php": {
      "modulename": {
        "ensure": "installed",
        "package": "php5-packagename"
      }
    }
  }

For example if you like to install php5-ldap use:

.. code-block:: json

  {
    "website::php": {
      "ldap": {
        "ensure": "installed",
        "package": "php5-ldap"
      }
    }
  }

.. hint:: some types might have the needed package preinstalled. For example "magento" comes with "php5-mcrypt"

You will find a list of supported PHP modules `here <http://puppet-php.readthedocs.org/en/latest/extensions.html>`__.

Composer
--------

Every PHP based website type has composer installed and auto updated.

.. hint:: For details, see the `Composer <https://getcomposer.org/doc/>`__ documentation

TYPO3 7
^^^^^^^

On composer based TYPO3 7 installations, composer runs after every TYPO3
core update, if the following conditions are fulfilled:

-  ``type: typo3cmsv7``
-  ``~/composer.json`` exists
-  ``~/composer.json`` contains ``typo3/cms``

Command used on websites with ``env: DEV``:
``/usr/local/bin/composer update -n -o typo3/cms``
Command used on all other environments:
``/usr/local/bin/composer update --no-dev -n -o typo3/cms``

.. hint:: Composer runs only after changes within the global TYPO3 core in ``/var/lib/typo3``. During deployments, you still have to run composer manually

TYPO3 CMS with Composer
^^^^^^^^^^^^^^^^^^^^^^^

To use TYPO3 CMS 6.x or 7.x with composer, use the following command:

::

    # Export HTTPS PROXY settings to use with get.typo3.org
    export HTTPS_PROXY_REQUEST_FULLURI=false

    # Download the Base Distribution, the latest "stable" release (6.2)
    composer create-project typo3/cms-base-distribution CmsBaseDistribution

    # Download the Base Distribution, the "dev" branch (7.x)
    composer create-project typo3/cms-base-distribution CmsBaseDistribution dev-master

    # Download the Base Distribution, the "dev" 6.2 branch
    composer create-project typo3/cms-base-distribution CmsBaseDistribution 6.2.x-dev

TYPO3 Neos with Composer
^^^^^^^^^^^^^^^^^^^^^^^^

To use TYPO3 Neos 1.2 with composer, use the following command:

::

    # Create Web/tmp directory, install Neos 1.2 with composer, move to users home directory and cleanup
    mkdir ~/Web/tmp/ && cd ~/Web/tmp/ && composer create-project --no-dev typo3/neos-base-distribution TYPO3-Neos-1.2 && rsync -a --delete-after ~/Web/tmp/TYPO3-Neos-1.2/ ~/

Symfony with Composer
^^^^^^^^^^^^^^^^^^^^^

To use Symfony 2 with composer, use the following command:

::

    # Create Web/tmp directory, install Symfony2 with composer, move to users home directory and cleanup
    mkdir ~/web/tmp/ && cd ~/web/tmp/ && composer create-project symfony/framework-standard-edition symfony && rsync -a --delete-after ~/web/tmp/symfony/ ~/

Ioncube
-------

You can enable ionCube loader globally by using the following configuration:

PHP 5
^^^^^

.. code-block:: json

  {
    "base::modules": [
      "website::wrapper::phpioncube"
    ]
  }

PHP 7
^^^^^

.. code-block:: json

  {
    "base::modules": [
      "website::wrapper::php70ioncube"
    ]
  }

Monitoring
----------

All sites with ``"env": "PROD"`` are monitored 24/7 by default. If you
have some sites with frequent outages (e.g. for development purposes),
which have to have ``"env": "PROD"`` for other reasons, or sites which
are not reachable from everywhere due to security reasons, please
deactivate monitoring by setting ``"monitoring": "false"``.

.. code-block:: json

  {
    "website::sites": {
      "examplenet": {
        "type": "html",
        "env": "PROD",
        "monitoring": "false"
      }
    }
  }

SSH Access Keys
---------------

.. code-block:: json

  {
    "website::sites": {
      "examplenet": {
        "ssh_key": {
          "contact@example.net": {
            "key": "ssh-rsa AAAAB....."
          }
        }
      }
    }
  }

Environment Variables
---------------------

You can set or override environment variables per website by setting the ``envvar`` option:

.. code-block:: json

  {
    "website::sites": {
      "examplenet": {
        "envvar": {
          "MYENVVAR": "this is the value",
          "DB_HOST": "override global DB_HOST variable here",
          "http_proxy": "override global http_proxy variable here"
        }
      }
    }
  }

Delete website
--------------

As a security measure, you have to define explicit that you want to
delete a website:

.. code-block:: json

  {
    "website::sites": {
      "examplenet": {
        "ensure": "absent"
      }
    }
  }

As soon as "ensure" equals set to "absent", all configurations and data
related to this site gets removed at once. After the next configuration
run, you can remove the whole part from the website::sites hash.

Warning: After setting ``ensure`` to ``absent``, do not run
``puppet-agent`` with this particular user. Use another, remaining user
or the generic ``devop`` user to run ``puppet-agent``

Full configuration example
--------------------------

.. code-block:: json

  {
    "website::sites": {
      "examplenet": {
        "password": "1234",
        "server_name": "typo3.example.net www.typo3.example.net",
        "env": "PROD",
        "type": "typo3cms"
      },
      "devexamplenet": {
        "password": "1234",
        "server_name": "dev.example.net www.dev.example.net",
        "env": "DEV",
        "htpasswd": "$apr1$RSDdas2323$23case23DCDMY.0xgTr/",
        "type": "typo3cms"
      },
      "wordpressexample": {
        "server_name": "wordpress.example.net",
        "env": "PROD",
        "type": "wordpress",
        "password": "Aiw7vaakos04h7e"
      },
      "drupalexample": {
        "server_name": "drupal.example.net",
        "env": "PROD",
        "type": "drupal",
        "password": "Aiw7vaakos04h7e"
      },
      "phpexamplenet": {
        "server_name": "php.example.net",
        "env": "PROD",
        "type": "php"
      },
      "hhvmexamplenet": {
        "server_name": "hhvm.example.net",
        "env": "PROD",
        "type": "php",
        "dbtype": "mysql",
        "password": "ohQueeghoh0bath"
      },
      "htmlexamplenet": {
        "server_name": "html.example.net",
        "env": "PROD",
        "type": "html"
      },
      "neosexample": {
        "password": "Efo9ohh4EiN3Iifeing7eijeeP4iesae",
        "server_name": "neos.example.net www.neos.example.net",
        "env": "PROD",
        "type": "typo3neos"
      },
      "uwsgiexample": {
        "server_name": "uwsgi.example.net",
        "env": "PROD",
        "type": "uwsgi",
        "dbtype": "postgresql",
        "password": "ohQueeghoh0bath"
      },
      "symfonyexample": {
        "server_name": "symfony.example.net www.symfony.example.net",
        "password": "Efo9ohh4EiN3Iifeing7eijeeP4iesae",
        "env": "PROD",
        "type": "symfony"
      },
      "redirectexample": {
        "server_name": "example.to",
        "target": "$scheme://domain.com$request_uri",
        "env": "PROD",
        "type": "redirect"
      },
      "proxyexample": {
        "server_name": "proxy.to",
        "env": "PROD",
        "type": "proxy",
        "members": [
          "localhost:8080",
          "127.0.0.1:8081",
          "unix:/tmp/backend"
        ]
      },
      "magentoexample": {
        "server_name": "magento.example.net",
        "env": "PROD",
        "type": "magento",
        "password": "Aiw7vaakos04h7e",
        "ssl_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDRHc47/0zg+cAg\nMkHKY1U7TOFChPawiNmU94MYjOTzK/Lc4C2op1sDCAP4Ow+qx7BK8NLJkHUPyOXU\nzjTTTUN/dGoElGz4gFaCCkMhk8hRZEs8jTwAm8tq4ruUVk9DIgQ9K/potm5kzT/T\nKyW85hETMLi+tRw9Kbn/j4QljWmqcd4mPWyaMT1o4lDTszq7NCHGch+dxa4FJYib\nz05C6+BVpw9w+BWFERlbgG5hvMMXtxexlju24e2fJV/TPCVbgDk/ecFDhupRMdj9\nZKrlPcUZNReWxgX+ZGT8YfWI2tYfW9+H6iVvcwV2gftiDp4+N4r4Ae52cMFxcKBR\n5fn4i8hbAgMBAAECggEAYv66MBr3GRYChvtju9z0b2NAzE3HvuC6KFRYAlpI1Hl8\numWCF/JKGpBD2NKU4yMvaPrCvtsdH8DaVLjdtx4/kunYepyNTcLrsRoMl6uvTCCv\noVW3Dw6x6MK3TEzjrwM+gHr+S235qsyjp2MotVkwwiXxf46bdLT5MWuOgnyEhkQQ\ncmv6qDmjgDP5vH5r4riAlPKMq+jGtLc/2QWs22UxQS0/a7n0pks472AonLI8r1M8\nsYcCAC6uEvxRZdVcJOlRK78dPI3NLxFhSbvv/GcVOypyhvQ3uVYV71xA/AgcpBLd\nFc2FULRCCU/UEjmo62uYNkG09lCchBwK8BLYYWrCoQKBgQDqL5Eo9oLMTuzysu8I\nvemXODOTfxQb1OTH1dyA4kSAtmNF2IO5rNnvVsS5YlbSjZMEXRMYTSflp7L7ae2l\nXLqjhijdB6l5cdgsPyHD2phYOvJzWMuzjkCtIjm5QfdMfsUZnBSPbwaRF1zWxbVn\nmHlWi3Zcu8U65l9gsJviZelqqwKBgQDkmG4W1SEySON4i44JwzsmXQHP1d8KHES1\nhB1IETNYV2HzIAWnnX/fqPwqyahzegKTGut9U7kJ8QHsHvz56nHdiQ8zw4BZxQPw\nj4Pms1IpzpO48yf4swskqwgkk5W6wTHCD/Q48tqFtAMPwC/D88F966ipc6lyldsJ\nUXvLeeMZEQKBgGTHYZWaOAGKOYfcHufJKnwMEI350wKDJI0m6ISCWu51DtWg7lb6\nHrNTyMbqnehwSoNHNo9vrKq0914gYMeX1y3F71HnGTSNHHU2Gea57HOTsoCXBtpX\nblfTcbnavHyr1VBHDcYIBnBr+GTooj9Zq2XmEGKp35+QQh1PA1ZzevaPAoGASdop\nLv06VVmRC9/iSqslT/aaYEATZ9vMIuyE3USZVwAcKAT/brCGoIaiuVwfLPeNH2OC\nEyJaVKjlWxiD2GXy1YSzQaD2tYneBPkIvx7N+62+sfD0x/doMTeEUPTRWd2SqsSm\nvUNQcAPBPXR0uhTlPT5GZkB0zQ03D6KgoRNG2FECgYEAgXPJjIsqhcC0PNEuRgdC\n9pZq+Prvp4TniVwQKyPniw/FjAplI4uN/+1fiYPexaLzINnXUuvOTYPABec3T2DZ\nGV0lffmdZ+CleU1Xi5DjLGn8m0Gdy6mecE2Le9/Q13o3owF9rm0Drhqqd8T6vVt3\nhiw7C+lCp2XheqP+QchwxiY=\n-----END PRIVATE KEY-----\n",
        "ssl_cert": "-----BEGIN CERTIFICATE-----\nMIIEATCCAumgAwIBAgIJAMdVCMOVZl30MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYD\nVQQGEwJDSDEPMA0GA1UECAwGWnVyaWNoMQ8wDQYDVQQHDAZadXJpY2gxIzAhBgNV\nBAoMGnNub3dmbGFrZSBwcm9kdWN0aW9ucyBHbWJIMRowGAYDVQQDDBF0eXBvMy5l\neGFtcGxlLm5ldDEkMCIGCSqGSIb3DQEJARYVd2VibWFzdGVyQGV4YW1wbGUubmV0\nMB4XDTE1MDIxMjEyMDU1MloXDTI1MDIwOTEyMDU1MlowgZYxCzAJBgNVBAYTAkNI\nMQ8wDQYDVQQIDAZadXJpY2gxDzANBgNVBAcMBlp1cmljaDEjMCEGA1UECgwac25v\nd2ZsYWtlIHByb2R1Y3Rpb25zIEdtYkgxGjAYBgNVBAMMEXR5cG8zLmV4YW1wbGUu\nbmV0MSQwIgYJKoZIhvcNAQkBFhV3ZWJtYXN0ZXJAZXhhbXBsZS5uZXQwggEiMA0G\nCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDRHc47/0zg+cAgMkHKY1U7TOFChPaw\niNmU94MYjOTzK/Lc4C2op1sDCAP4Ow+qx7BK8NLJkHUPyOXUzjTTTUN/dGoElGz4\ngFaCCkMhk8hRZEs8jTwAm8tq4ruUVk9DIgQ9K/potm5kzT/TKyW85hETMLi+tRw9\nKbn/j4QljWmqcd4mPWyaMT1o4lDTszq7NCHGch+dxa4FJYibz05C6+BVpw9w+BWF\nERlbgG5hvMMXtxexlju24e2fJV/TPCVbgDk/ecFDhupRMdj9ZKrlPcUZNReWxgX+\nZGT8YfWI2tYfW9+H6iVvcwV2gftiDp4+N4r4Ae52cMFxcKBR5fn4i8hbAgMBAAGj\nUDBOMB0GA1UdDgQWBBSSJyPyLa8CNKMDR3BAOcuuzzEqlTAfBgNVHSMEGDAWgBSS\nJyPyLa8CNKMDR3BAOcuuzzEqlTAMBgNVHRMEBTADAQH/MA0GCSqGSIb3DQEBCwUA\nA4IBAQAMKv2Kdw2LkskJm/GAkEsavoYf6qAPruwcsp8cx+7doXOpptZ/w+m8NK8i\n6ffi65wQ4TGlFxEvXM1Ts4S1xF/+6JVnnp8RVGvfgDL7xi6juMqbtM5yBxjHKO6W\nAuxOmwPcd6cO5qL+MCSgIe13bn/V4bw/JLv9LONuwXHJuv0FEoazbSyB6uTwYf2D\npWHEkXvkz5A1hqu3y2jFq2cQffoO31GGx29U3uSl+Esp5bL/J0bQd3TUbwvu6FY1\nNgUR7Mx1t/4/uk9FRl87d2rRslc5VyvD5v7MFE6jYJap74j5BrrfUUTNbzVXdPCS\nv8jOaIjDp5AMoZxbPMlv/5Tk85uF\n-----END CERTIFICATE-----\n"
      },
      "deleteme": {
        "ensure": "absent"
      }
    }
  }
