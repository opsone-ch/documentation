Website
=======

Our website module provides everything you need, to manage, deploy and
run your website. It is type and environment based which means you have
to select a particular type (e.g. typo3cms) and environment (e.g. PROD).
According those settings, our automation will setup the server/vhost as
required.

By adding a website, the following parts are created on the server:

-  system user and group
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

typo3cmsv10 (Alpha)
^^^^^^^^^^^^^^^^^^^

.. list-table::

   * - Web server
     - nginx with ModSecurity WAF, core rule set and TYPO3 10.x compatible white/blacklists
   * - runtime environment
     - PHP 7.2
   * - Database
     - MySQL (MariaDB 10.x ) with database, user, and grants
   * - Default webroot
     - ~/web

-  PHP and nginx settings adjusted to TYPO3 10 requirements
-  latest TYPO3 CMS 10 sprint release cloned into ``/opt/typo3/TYPO3\_10/``
-  PHP and nginx settings adjusted to TYPO3 10 requirements
-  TYPO3 application context can be set by setting the ``TYPO3_CONTEXT`` environment variable in custom JSON,
   see `Environment Variables`_ for details
-  TYPO3 Scheduler executed every 5 minutes

.. warning:: This type can change and is meant to test TYPO3 10 sprint releases only. Do not run live applications with this type yet

typo3cmsv9
^^^^^^^^^^

.. list-table:: 

   * - Web server
     - nginx with ModSecurity WAF, core rule set and TYPO3 9.x compatible white/blacklists
   * - runtime environment
     - PHP 7.2
   * - Database
     - MySQL (MariaDB 10.x ) with database, user, and grants
   * - Default webroot
     - ~/web

-  PHP and nginx settings adjusted to TYPO3 9 requirements
-  latest TYPO3 CMS 9 LTS cloned into ``/opt/typo3/TYPO3\_9/``
-  PHP and nginx settings adjusted to TYPO3 9 requirements
-  TYPO3 application context can be set by setting the ``TYPO3_CONTEXT`` environment variable in custom JSON,
   see `Environment Variables`_ for details
-  TYPO3 Scheduler executed every 5 minutes

typo3cmsv8
^^^^^^^^^^

.. list-table:: 

   * - Web server
     - nginx with ModSecurity WAF, core rule set and TYPO3 8.x compatible white/blacklists
   * - runtime environment
     - PHP 7.2
   * - Database
     - MySQL (MariaDB 10.x ) with database, user, and grants
   * - Default webroot
     - ~/web

-  PHP and nginx settings adjusted to TYPO3 8 requirements
-  latest TYPO3 CMS 8 LTS cloned into ``/opt/typo3/TYPO3\_8/``
-  TYPO3 application context can be set by setting the ``TYPO3_CONTEXT`` environment variable in custom JSON,
   see `Environment Variables`_ for details
-  TYPO3 Scheduler executed every 5 minutes

typo3cmsv7
^^^^^^^^^^

.. list-table:: 

   * - Web server
     - nginx with ModSecurity WAF, core rule set and TYPO3 7.x compatible white/blacklists
   * - runtime environment
     - PHP 7.2
   * - Database
     - MySQL (MariaDB 10.x ) with database, user, and grants
   * - Default webroot
     - ~/web

-  PHP and nginx settings adjusted to TYPO3 7 requirements
-  latest TYPO3 CMS 7 LTS cloned into ``/opt/typo3/TYPO3\_7/``
-  TYPO3 application context can be set by setting the ``TYPO3_CONTEXT`` environment variable in custom JSON,
   see `Environment Variables`_ for details
-  TYPO3 Scheduler executed every 5 minutes

neos
^^^^

.. list-table::

   * - Web server
     - nginx with ModSecurity WAF, core rule set and Neos compatible white/blacklists
   * - runtime environment
     - PHP 7.2
   * - Database
     - MySQL (MariaDB 10.x ) with database, user, and grants
   * - Default webroot
     - ~/web

-  PHP and nginx settings adjusted to Neos requirements
-  ``FLOW_CONTEXT`` set according the selected environment (see `Environments`_)
-  ``FLOW_REWRITEURLS`` enabled

required configuration
~~~~~~~~~~~~~~~~~~~~~~

.. warning:: our approach to dynamically configure PHP is not compatible with Neos by default

As a workaround, we have to let know Neos about the environment variable
required to load the appropriate PHP settings, by defining the the
``PHP_INI_SCAN_DIR`` environment variable in ``Configuration/Settings.yaml``:

.. code-block:: yaml

  Neos:
    Flow:
      core:
        subRequestEnvironmentVariables:
          PHP_INI_SCAN_DIR: '/etc/php72/user/<username>/:/home/<username>/cnf/'

.. hint:: see `this Neos Discuss thread <https://discuss.neos.io/t/setup-process-error-with-custom-php-environment/4174>`__ for technical details

magento2
^^^^^^^^

.. list-table::

   * - Web server
     - nginx with ModSecurity WAF, core rule set and Magento 2 compatible white/blacklists
   * - runtime environment
     - PHP 7.1
   * - Database
     - MySQL (MariaDB 10.x ) with database, user, and grants
   * - Default webroot
     - ~/pub

-  PHP and nginx settings adjusted to Magento 2 requirements
-  Magento 2 cronjobs running every minute

wordpress
^^^^^^^^^

.. list-table:: 

   * - Web server
     - nginx with ModSecurity WAF, core rule set and Wordpress compatible white/blacklists
   * - runtime environment
     - PHP 7.2
   * - Database
     - MySQL (MariaDB 10.x ) with database, user, and grants
   * - Default webroot
     - ~/www

- PHP and nginx settings adjusted to WordPress requirements
- WP-CLI installed and available by using the ``wp`` command
- wp-cron.php is called every 5 minutes over CLI

.. hint:: Please disable the built in HTTP call to wp-cron.php by setting ``define('DISABLE_WP_CRON', true);``. This additional call is not necessary and disabling it will lower the load on your system.

php72
^^^^^

.. list-table:: 

   * - Web server
     - nginx with ModSecurity WAF and core rule set
   * - runtime environment
     - PHP 7.2
   * - Database
     - Optional: MySQL, MongoDB or PostgreSQL
   * - Default webroot
     - ~/www

php71
^^^^^

.. list-table:: 

   * - Web server
     - nginx with ModSecurity WAF and core rule set
   * - runtime environment
     - PHP 7.1
   * - Database
     - Optional: MySQL, MongoDB or PostgreSQL
   * - Default webroot
     - ~/www

html
^^^^

.. list-table:: 

   * - Web server
     - nginx with ModSecurity WAF and core rule set
   * - runtime environment
     - for static content only
   * - Database
     - unavailable
   * - Default webroot
     - ~/www

uwsgi
^^^^^

.. list-table:: 

   * - Web server
     - nginx with ModSecurity WAF and core rule set
   * - runtime environment
     - uWSGI Daemon, Python virtualenv
   * - Database
     - Optional: MySQL, MongoDB or PostgreSQL
   * - Default webroot
     - ~/www

-  uWSGI Daemon (Symlink your appropriate wsgi configuration to ``~/wsgi.py``)
-  Python virtualenv ``venv-<sitename>`` configured within uWSGI and the user login shell
-  all requests are redirected to the uWSGI daemon by default. To serve
   static files, add appropriate locations to the `Custom configuration`_ like this:

   ::

       location /static/ {
         root /home/user/application/;
       }

.. hint:: to control the uwsgi daemon, use the ``uwsgi-reload`` and ``uwsgi-restart`` shortcuts

redirect
^^^^^^^^

.. list-table:: 

   * - Web server
     - nginx with ModSecurity WAF and core rule set
   * - runtime environment
     - for redirects only
   * - Database
     - unavailable
   * - Default webroot
     - unavailable

- redirects everything to a custom target
- by default, we send a 307 HTTP code. To use your own code, add the ``target_code`` parameter to the websites custom JSON:

  .. code-block:: json

      {
        "target_code": "301"
      }

.. hint:: you can use any nginx variable as target (for example ``$scheme://www.example.com$request_uri``), see the `nginx Documentation <http://nginx.org/en/docs/varindex.html>`__ for available variables

proxy
^^^^^

.. list-table:: 

   * - Web server
     - nginx with ModSecurity WAF and core rule set
   * - runtime environment
     - for reverse proxy only
   * - Database
     - unavailable
   * - Default webroot
     - unavailable

-  nginx vhost configured as reverse proxy

.. hint:: to use advanced features or multiple backends, create your own upstream configuration in ``/etc/nginx/custom/http.conf`` and point ``proxy_pass`` to it. For security reasons, we only allow access to this configuration for the `devop user <../server/access.html#generic-devop-user>`__.

docker
^^^^^^

.. list-table:: 

   * - Web server
     - nginx with ModSecurity WAF and core rule set
   * - runtime environment
     - own container with docker
   * - Database
     - Optional: MySQL, MongoDB or PostgreSQL
   * - Default webroot
     - unavailable

-  nginx vhost configured as reverse proxy
-  install docker and puts the user into the docker group

.. hint:: to use advanced features or multiple backends, create your own upstream configuration in ``/etc/nginx/custom/http.conf`` and point ``proxy_pass`` to it. For security reasons, we only allow access to this configuration for the `devop user <../server/access.html#generic-devop-user>`__.

nodejs
^^^^^^

.. list-table:: 

   * - Web server
     - nginx with ModSecurity WAF and core rule set
   * - runtime environment
     - nodejs daemon, controlled by monit
   * - Database
     - Optional: MySQL, MongoDB or PostgreSQL
   * - Default webroot
     - socket: ~/cnf/nodejs.sock

- select custom node version trough `nvm <https://github.com/creationix/nvm#usage>`__, by default, the latest node lts version is installed
- symlink your app.js to ``~/app.js`` or overwrite path or other daemon
  options in ``OPTIONS`` at ``~/cnf/nodejs-daemon``:

  ::

      OPTIONS="/home/nodejs/application/app.js --prod"

- nodejs has to listen on the ``~/cnf/nodejs.sock`` socket, permission ``660``
- all requests are redirected to the nodejs daemon by default. To serve
  static files, add appropriate locations to the `Custom configuration`_ like this:

  ::

      location /static/ {
        root /home/user/application/;
        include /etc/nginx/custom/security.conf;
      }

.. hint:: to control the nodejs daemon, use the ``nodejs-restart`` shortcut

ruby
^^^^

.. list-table::

   * - Web server
     - nginx with ModSecurity WAF and core rule set
   * - runtime environment
     - ruby rbenv and foreman daemon
   * - Database
     - Optional: MySQL, MongoDB or PostgreSQL
   * - Default webroot
     - socket: ``~/cnf/ruby.sock``

-  ruby rbenv configured within foreman and the user login shell
-  foreman daemon, controlled by monit
-  symlink your Procfile to ``~/`` or overwrite path or other daemon
   options in ``OPTIONS`` at ``~/cnf/ruby-daemon``:

   ::

       OPTIONS="start web -f project/Procfile"

-  ruby has to listen on the ``~/cnf/ruby.sock`` socket, permission ``660``
-  all requests are redirected to the ruby daemon by default. To serve
   static files, add appropriate locations to the `Custom configuration`_ like this:

   ::

       location /static/ {
           root /home/user/application/;
       }

.. hint:: to control the ruby daemon, use the ``ruby-start`` / ``ruby-stop`` / ``ruby-restart`` shortcuts

Environments
------------

You have to select one of those environments for each website:

PROD
^^^^

-  for live sites
-  no access protection
-  phpinfo disabled (visible database credentials from environment variables)
-  E-Mails get sent to their designated recipient (PHP mail() only, see :doc:`../development/email` for details)

.. hint:: You can enable phpinfo by setting ``disable_functions=`` to a empty string in ``~/cnf/php.ini`` (don’t forget ``php-reload``). Important: phpinfo exposed many infos like environment variables such as database credentials. We recommend not to use phpinfo on a publicly accessible website. Please be careful and deactivate phpinfo afterwards.

STAGE
^^^^^

-  for stage / preview / testing access
-  password protected (User "preview", password from "preview_htpasswd" option)
-  phpinfo enabled
-  E-Mails get saved as file into the ~/tmp/ directory (PHP mail() only, :doc:`../development/email` for details)

DEV
^^^

-  for development
-  password protected (User "preview", password from "preview_htpasswd" option)
-  phpinfo enabled
-  Xdebug enabled, see :doc:`../development/phpdebugging` for details)
-  E-Mails get saved as file into the ~/tmp/ directory (PHP mail() only, :doc:`../development/email` for details)

User Handling
^^^^^^^^^^^^^

The preview user gets applied to all non PROD environments and is
intended for your own use, but also to allow access to other parties
like your customer. Use the "Preview password" option to set a particular
password to the preview user. You have to use a htpasswd encrypted value
which you can generate like this on your local workstation:

::

    htpasswd -n preview

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
    "preview_username": "showme",
  }

Furthermore, its possible to set the preview username globally through ``website::preview_username``.

.. note:: Please keep in mind that this password gets often transfered over unencrypted connections. As always, we recommend to use a particular password for only this purpose

Disable exceptions
^^^^^^^^^^^^^^^^^^

Never show detailed application based exeptions on PROD, to avoid
`information
leakage <https://www.owasp.org/index.php/Information_Leakage>`__.
Disable the output directly in your application. For example in TYPO3:

::

    $TYPO3_CONF_VARS['SYS']['displayErrors'] = '0'; 

Default Environment Variables
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

For each website, the following environment variables are created by
default, and are available within the shell and also the webserver.

-  SITE\_ENV (DEV, STAGE or PROD)
-  DB\_HOST (Database hostname, only if there is a database)
-  DB\_NAME (Database name, only if there is a database)
-  DB\_USERNAME (Database username, only if there is a database)
-  DB\_PASSWORD (Database password, only if there is a database)
-  PROXY\_PASS (Proxy Pass, only for type proxy)

.. hint:: to use the .profile environmet within a cronjob, prepend the following code to your command: ``/bin/bash -c 'source $HOME/.profile; ~/original/command'``

Example usage in PHP
~~~~~~~~~~~~~~~~~~~~

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

Example usage in typoscript
~~~~~~~~~~~~~~~~~~~~~~~~~~~

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
-  daily `Qualys SSL Labs <https://www.ssllabs.com/>`__ API Check
-  global HTTP to HTTPS redirect

Let's Encrypt
^^^^^^^^^^^^^

We support free tls certificates by `Let's Encrypt <https://letsencrypt.org/>`__.
You can activate Letsencrypt for your website in the cockpit.
The certificates are automatically renewed 30 days before expiration.

Debug validation problems
~~~~~~~~~~~~~~~~~~~~~~~~~

In order to debug validation issues, we introduced the ``letsencrypt-renew`` shortcut which will trigger a run of our Let's Encrypt client, and let you see all debug output to identifiy possible problems.

-  Make sure that all hosts added to ``Server name`` end up on your server already.
-  Let's Encrypt will try to reach your website at the endpoint ``/.well-known/acme-challenge/``. Make sure that you do not overwrite this path within your `own nginx configuration <#custom-configuration>`__.

Renewal
~~~~~~~

Certificates from Let's Encrypt will be valid for 90 days. They are renewed automatically as soon as they expire in under 30 days. You can follow these checks and renewals by grep for ``letsencrypt`` in ``/var/log/syslog``.

Furthermore, we check all certificates from our monitoring and will contact you if there are certificates expiring in less than 21 days.

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

-  SSL key: generated private key
-  SSL key: signed certificate, including appropriate intermediate
   certificates

Warning: Make sure the first ``Server name`` used is valid within your
certificate as we redirect all HTTP requests within this vHost to
``https://first-in-server_name``

HTTP redirect
^^^^^^^^^^^^^

By default, all HTTP requests within a given vHost are redirected to HTTPS keeping the hostname supplied by the client. If you want to change this behaviour somehow, for example by always redirect to the first hostname of the vhost, you can set ``http_redirect_dest`` to another value like ``https://$server_name$request_uri``.

Furthermore, its possible to set the redirect destination globally through ``website::http_redirect_dest`` which will be used on all HTTP redirects without a explicitly set ``http_redirect_dest``.


~/cnf/nginx-redirect.conf
~~~~~~~~~~~~~~~~~~~~~~~~~

Included within the server block of each HTTP to HTTPS redirect. You can use this file to configure specific redirect rules and settings.


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

We use `ModSecurity <https://modsecurity.org>`__ as additional protection against application level attacks such as cross site-scripting or SQL injections.
By default, the core rules set will be loaded, and we block common vulnerabilities and zero day attacks by adding some more global rules.

.. warning:: this is just a additional security measure. Regardless its existence, remember to keep your application, extensions and libraries secure and up to date

.. hint:: keep up to date with changes by subscribing to our status uppdates at `opsstatus.ch <http://opsstatus.ch/>`__

Identify blocks
^^^^^^^^^^^^^^^

nginx error log
~~~~~~~~~~~~~~~

If a request is blocked, the server will issue a `403 forbidden` error. There are detailed informations available in the error log file:

::

    YYYY/MM/DD HH:MM:SS [error] 171896#0: *29428 [client 2a04:500::1] ModSecurity: Access denied with code 403 (phase 2). Matched "Operator `Ge' with parameter `5' against variable `TX:ANOMALY_SCORE' (Value: `5' ) [file "/etc/nginx/modsecurity/crs/rules/REQUEST-949-BLOCKING-EVALUATION.conf"] [line "80"] [id "949110"] [rev ""] [msg "Inbound Anomaly Score Exceeded (Total Score: 5)"] [data ""] [severity "2"] [ver ""] [maturity "0"] [accuracy "0"] [tag "application-multi"] [tag "language-multi"] [tag "platform-multi"] [tag "attack-generic"] [hostname "2a04:500::1"] [uri "/"] [unique_id "154850909196.529239"] [ref ""], client: 2a04:500::1, server: example.net, request: "GET /?union%20select=%22waf%20demo HTTP/2.0", host: "example.net"

.. hint:: for details, see the `ModSecurity documentation <https://github.com/SpiderLabs/ModSecurity/wiki>`__

modsecurity audit log
~~~~~~~~~~~~~~~~~~~~~

More detailed informations including a full dump of the request and response can be obtained from the audit log file.
You'll find this at ``/var/log/nginx/modsecurity.log``.

.. hint:: you cannot read ``/var/log/`` from within the web applications context for security reasons, please use the generic ``devop`` account to take a look at them

custom WAF configuration
^^^^^^^^^^^^^^^^^^^^^^^^

The rules added from the core rules set and the custom rules added by us are there for a reason.
If you trigger a false positive, you should think about changing your application first of all.
As this is not always possible or feasible, you can disable certain rules or even the whole WAF
through the local nginx configuration located in ``~/cnf/nginx.conf``:

::

    # disable blocking triggered requests but still detect and log them
    modsecurity_rules 'SecRuleEngine DetectionOnly';

    # disable WAF alltogether
    modsecurity_rules 'SecRuleEngine Off';

    # disable certain rule
    modsecurity_rules 'SecRuleRemoveById 90001';

    # add custom rule
    modsecurity_rules 'SecRule "ARGS_NAMES|ARGS" "@contains blocked-value" "deny,msg:blocled,id:91001,chain"'

.. hint:: to apply the changes reload the nginx configuration with the ``nginx-reload`` shortcut

.. hint:: for details, see the `ModSecurity documentation <https://github.com/SpiderLabs/ModSecurity/wiki>`__

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
    }

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

~/cnf/nginx-prod.conf
^^^^^^^^^^^^^^^^^^^^^

Included within the server block on each website with environment set to PROD. For configuration examples, see the description of `~/cnf/nginx.conf`_ above.

~/cnf/nginx-stage.conf
^^^^^^^^^^^^^^^^^^^^^

Included within the server block on each website with environment set to STAGE. For configuration examples, see the description of `~/cnf/nginx.conf`_ above.

~/cnf/nginx-dev.conf
^^^^^^^^^^^^^^^^^^^^^

Included within the server block on each website with environment set to DEV. For configuration examples, see the description of `~/cnf/nginx.conf`_ above.

~/cnf/nginx\_waf.conf
^^^^^^^^^^^^^^^^^^^^^

Configure WAF exeptions here, see `Web Application Firewall`_ for details.

/etc/nginx/custom/http.conf
^^^^^^^^^^^^^^^^^^^^^^^^^^^

This file is directly integrated in ``http { }``, before ``server { }`` and can only be edited with the ``devop`` user. You can use this file for settings that must be configured at nginx http context.

custom configuration include
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Include your own, external configuration files within ``server { }`` or ``http { }`` by including the following configuration to your server's ``Custom JSON``:

* server level: set ``nginx::global_config::server_file``
* http level: set ``nginx::global_config::http_file``

.. warning:: if the configured files can not be found, the webserver will not be able to start.

::

    "nginx::global_config::server_file": "/absolut/path/to/your/file.conf"

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

custom log format
^^^^^^^^^^^^^^^^^

To alter the format used for nginx access logs, for example due to privacy reasons, you can use the ``website::wrapper::nginx::log_format`` configuration.

This configuration is only available globally for all websites on a server, to change to default "combined" format to replace the actual visitors ip address with 127.0.0.1, use the following example:

::

  "website::wrapper::nginx::log_format": "127.0.0.1 - $remote_user [$time_local] \"$request\" $status $body_bytes_sent \"$http_referer\" \"$http_user_agent\""

.. _php.ini:

PHP
^^^

You can set custom PHP configurations trough the ``~/cnf/php.ini`` file.
See the `PHP Documentation <http://php.net/manual/en/configuration.file.per-user.php>`__ for details.

.. warning:: You have to reload php after changes with the ``php-reload`` shortcut

::

    memory_limit = 1G
    extension = ldap.so

.. hint:: list available extensions in ``/opt/php/php72/lib/php/extensions/no-debug-non-zts-20170718/``

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

  {
    # GeoIP Settings for nginx
    "nginx::http_cfg_append": [
      "geoip_country  /home/user/geoip/GeoIPv6.dat",
      "geoip_city /home/user/geoip/GeoLiteCityv6.dat"
    ]

    # GeoIP related environment variables
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

Environment Variables
---------------------

To set or override environment variables per website, use the ``envvar`` option in custom JSON:

.. code-block:: json

    {
      "envvar": {
        "MYENVVAR": "this is the value",
        "DB_HOST": "override global DB_HOST variable here",
        "http_proxy": "override global http_proxy variable here"
      }
    }

White label
-----------

Default Virtual Host
^^^^^^^^^^^^^^^^^^^^

The default vhost is stored in ``/var/www/``. You can use your own content stored in a git repository with the following configuration.

.. code-block:: json

    {
      "website::default::webroot::gitsource": "git@git.example.com:acme/project",
      "website::default::webroot::gitkey": "-----BEGIN RSA PRIVATE KEY-----[..]-----END RSA PRIVATE KEY-----",
    }
