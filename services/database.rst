Database
========

Install and manage your favorite databases. Including users, grants, and
the configuration.

MySQL / MariaDB
---------------

Instead of MySQL, we use MariaDB, which is a drop-in replacement with
API/ABI compatibility to MySQL.

Databases
~~~~~~~~~

-  add a Database
-  title: Database Name
-  type: Database Type: "mysql"
-  user\_password: adds a User with the same Name as the Database with
   this Password and grant all privileges

   -  without this, you have to add user/grants by yourself (see below),
      otherwise only root can access this database
   -  it is only possible to add a local User here. For special
      Configurations (e.g. external access or grants to particular
      Tables use users/grants below)

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

Users
~~~~~

-  add a User
-  you have to add desired grants additionally
-  if you add Users for remote Hosts, also add corresponding Firewall
   Rule

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

Grants
~~~~~~

-  grant Access for a User to a Database and Tables

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

Additional configuration options
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  ``mysql::server::ft_min_word_len``: Value for the ft\_min\_word\_len
   option

Backup
~~~~~~

Every database is backed up daily into the users backup directory:

::

    /home/userdir/backup/

Restore
^^^^^^^

Choose between 2 options.

1. "rollback" with the MySQL binlog (point in time recovery)
2. restore the nightly backup

Rollback
''''''''

Import the binlog.

-  start-datetime: time of the last nightly dump
-  stop-datetime: required restore point

and rollback:

::

    mysqlbinlog --start-datetime="2015-02-09 22:07:00" --stop-datetime="2015-02-10 17:15:00" /var/log/mysql/mysql-bin.* | mysql database

Nightly restore
'''''''''''''''

for a complete restore of the nightly database backup, decompress the
backup, import it and remove the latest .sql.lzo file:

::

    lzop -dc ~/backup/<database>.sql.lzo | mysql <database>

the database.sql.lzo.1 is the backup from yesterday.

Access
~~~~~~

phpmyadmin
^^^^^^^^^^

We provide a central `phpMyAdmin
installation <https://dbadmin.opsone.ch>`__ to access your
database. Use the following settings to connect:

-  Server: database hostname, e.g. customer01.snowflakehosting.ch
-  Username: see DB\_USERNAME in ``~/.profile``
-  Password: see DB\_PASSWORD in ``~/.profile``

SSH tunnel
^^^^^^^^^^

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
^^^^^

simply access your database over the shell:

::

    mysql

Postgresql
----------

Databases
~~~~~~~~~

-  add a Database
-  title: Database Name
-  type: Database Type: "postgresql"
-  user\_password: adds a User with the same Name as the Database with
   this Password and grant all privileges

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
~~~~~~

Every database is dumped daily into the ``~/backup/`` directory.

Elasticsearch
-------------

We provide Elasticsearch as Managed Service. Setup is individual according to your needs.

`Get in touch with us <mailto:team@opsone.ch>`__ for further details.

