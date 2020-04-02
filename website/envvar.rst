.. index::
   triple: Website; Environment; Variables
   :name: website-envvar

=====================
Environment Variables
=====================

For each website, the following environment variables are created by
default, and are available within the shell and also the webserver:

* ``WEBSITE_CONTEXT`` (PROD, STAGE or DEV, see :ref:`website-context`)
* ``WEBSITE_SERVER_NAME`` (Configured server names within this website)
* ``DB_HOST`` (Database hostname, only if there is a database)
* ``DB_NAME`` (Database name, only if there is a database)
* ``DB_USERNAME`` (Database username, only if there is a database)
* ``DB_PASSWORD`` (Database password, only if there is a database)
* ``PROXY_PASS`` (Proxy Pass, only for type proxy)

Custom Environment Variables
============================

You can set or override environment variables per website, use the ``envvar`` option in custom JSON:

.. code-block:: json

    {
      "envvar": {
        "MYENVVAR": "this is the value",
        "DB_HOST": "override global DB_HOST variable here",
        "http_proxy": "override global http_proxy variable here"
      }
    }

Example Usage in PHP
====================

.. code-block:: php

   $config = array(
     'db_host'     => $_SERVER['DB_HOST'],
     'db_name'     => $_SERVER['DB_NAME'],
     'db_username' => $_SERVER['DB_USERNAME'],
     'db_password' => $_SERVER['DB_PASSWORD'],
   )


