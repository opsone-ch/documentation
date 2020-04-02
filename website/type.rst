.. index::
   pair: Website; Type
   :name: website_type

Type
====

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
-  ``FLOW_CONTEXT`` set according the selected context (see :ref:`website_context`)
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
- We have a request limit for ``wp-login.php`` and ``xmlrpc.php`` in place. For both options, our default limit is set to 10 request per minute
- You can override our defaults inside the Website custom JSON as shown in the exmaple below:

  .. code-block:: json

      {
        "wordpress_limit_login": "20r/m",
        "wordpress_limit_xmlrpc": false,
      }
  
  - Request limit for ``wp-login.php`` is set to 20 requests per minute
  - Request limit for ``xmlrpc.php`` is disabled

.. hint:: Please disable the built in HTTP call to wp-cron.php by setting ``define('DISABLE_WP_CRON', true);``. This additional call is not necessary and disabling it will lower the load on your system.

.. index::
   triple: Website; Type; PHP 7.2
   :name: website_type-php72

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

.. index::
   triple: Website; Type; PHP 7.1
   :name: website_type-php71

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

