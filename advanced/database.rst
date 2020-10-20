.. index::
   single: Database
   :name: database

========
Database
========

Manage databases including users, grants, and their configuration.

.. tip::

   This configurations are used in custom setups only. Mostly, it
   is sufficient to select your desired database within the :ref:`website`
   configuration.

.. index::
   triple: Database; MariaDB; MySQL
   :name: database_mariadb

MariaDB
=======

Instead of MySQL, we use MariaDB, which is a drop-in replacement with
API/ABI compatibility to MySQL.

Database
--------

You can configure MariaDB databases through the ``database::databases`` hash
within the `Custom JSON` :ref:`customjson_server`.

Options
~~~~~~~

* hash name: database Name
* type: database type, use ``mysql``
* user\_password: adds a user with the same name as the database with
  this password and all privileges to the created database

Example
~~~~~~~

Configure databases through the ``database::databases`` hash
within the `Custom JSON` :ref:`customjson_server`:

.. code-block:: json

  {
    "database::databases": {
      "<database-name-without-user>": {
        "type": "mysql"
      },
      "<database-name-with-user>": {
        "type": "mysql",
        "user_password": "<cleartext-password>"
      }
    }
  }

.. tip::

   If you add a database without ``user_password`` option, you have to configure
   the desired users and grants by yourself.
   For special configurations like external access, you have to configure
   the desired users and grants by yourself.

Users
-----

You can configure MariaDB users through the ``database::users`` hash
within the `Custom JSON` :ref:`customjson_server`:

.. code-block:: json

  {
    "database::users": {
      "<username>@localhost": {
        "password": "<cleartext-password>"
      },
      "<username>@<remote-hostname>": {
        "password": "<cleartext-password>"
      }
    }
  }

.. tip::

   If you add users for remote hosts, also add corresponding :ref:`firewall`.

Grants
------

You can configure MariaDB grants through the ``database::grants`` hash
within the `Custom JSON` :ref:`customjson_server`:

.. code-block:: json

  {
    "database::grants": {
      "<username>@localhost": {
        "user": "<username>@localhost",
        "database": "<database-name>",
        "table": "*"
      },
      "<username>@<remote-hostname>": {
        "user": "<username>@<remote-hostname>",
        "database": "<database-name>",
        "table": "*"
      },
      "<username-for-specific-table>@<remote-hostname>": {
        "user": "<username-for-specific-table>@<remote-hostname>",
        "database": "<database-name>",
        "table": "<specific-table-name>"
      },
      "<username-for-specific-table-with-privileges>@<remote-hostname>": {
        "user": "<username-for-specific-table>@<remote-hostname>",
        "database": "<database-name>",
        "table": "<specific-table-name>",
        "privileges": [
          "SELECT",
          "INSERT"
        ]
      }
    }
  }

Custom configuration
--------------------

You can set custom MariaDB configuration options through the
``database::wrapper::mysql::options`` hash
within the `Custom JSON` :ref:`customjson_server`:

.. code-block:: json

   {
     "database::wrapper::mysql::options": {
       "ft_min_word_len": 1
     }
   }

.. warning::

   This will directly affect the MariaDB server configuration. We have no means
   to check your configuration and cannot guarantee anythign if you change such
   values. Please make sure that you know what you're doing and contact us
   beforehand if you have any questions.

Restore
-------

You can restore mysql databases from snapshots with the ``mysqlrestore`` command.

-  mysqlrestore starts a second and temporary MariaDB instance from which then can be restored
-  the temporary instance runs on a separate port, further details are displayed directly on the console
-  mysqlrestore must be running to work with it. So you need to use a second SSH connection until you are done.

Binary Logging
--------------

The MySQL binary log is disabled by default. You can activate the binary log as follows.
But keep in mind that binary logging can take up a lot of diskspace.

.. code-block:: json

  {
    "database::wrapper::mysql::skip_log_bin": false
  }

Rollback with binary logging:

-  start-datetime: time of the last nightly dump
-  stop-datetime: required restore point

::

  mysqlbinlog --start-datetime="2020-02-09 22:07:00" --stop-datetime="2020-02-10 17:15:00" /var/log/mysql/mysql-bin.* | mysql database

Access
------

phpmyadmin
~~~~~~~~~~

We provide a central `phpMyAdmin
installation <https://dbadmin.opsone.ch>`__ to access your
database. Use the following settings to connect:

-  Server: database hostname
-  Username: see DB\_USERNAME in ``~/.profile``
-  Password: see DB\_PASSWORD in ``~/.profile``

SSH tunnel
~~~~~~~~~~

To access the database with common database tools like MySQL Workbench,
create a SSH tunnel to the server and forward the MySQL port. After
that, configure your favorite MySQL tool to connect to the forwarded
localhost.

::

    ssh -L 3306:localhost:3306 user@remotehost

Or directly with every ssh connection to the server with the following
ssh .config entry:

::

    LocalForward 3306 127.0.0.1:3306

local
~~~~~

simply access your database over the shell:

::

    mysql

.. index::
   pair: Database; PostgreSQL
   :name: database_postgresql

TLS
~~~

You can connect to all MariaDB databases with TLS enabled. Each server does generete its
own, self-signed certificate. To verify the servers identity, you can fetch the corresponding
certificate from ``/etc/mysql/tls.crt`` by using the `devop` user (see :ref:`access_devop`).

PostgreSQL
==========

Database
--------

You can configure PostgreSQL databases through the ``database::databases`` hash
within the `Custom JSON` :ref:`customjson_server`.

Options
~~~~~~~

* hash name: database Name
* type: database type, use ``postgresql``
* user\_password: adds a user with the same name as the database with
  this password and grant all privileges

Example
~~~~~~~

Configure databases through the ``database::databases`` hash
within the `Custom JSON` :ref:`customjson_server`:

.. code-block:: json

  {
    "database::databases": {
      "withuser": {
        "type": "postgresql",
        "user_password": "cleartext-password"
      }
    }
  }

Backup
------

Every database is dumped daily into the ``~/backup/`` directory.

.. index::
   pair: Database; MongoDB
   :name: database_mongodb

MongoDB
=======

Due to MongoDB licensing restriction, we are not allowed to provide
MongoDB as a service. We can provide MongoDB as Managed Service though.
Setup is individual according to your needs.

`Get in touch with us <mailto:team@opsone.ch>`__ for further details.

.. index::
   pair: Database; Elasticsearch
   :name: database_elasticsearch

Elasticsearch
=============

We provide Elasticsearch as Managed Service. Setup is individual according to your needs.

`Get in touch with us <mailto:team@opsone.ch>`__ for further details.

