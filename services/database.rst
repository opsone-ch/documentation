Database
========

Install and manage your favorite databases. Including users, grants, and
the configuration.

MySQL / MariaDB
---------------

Instead of MySQL, we use MariaDB, which is a drop-in replacement with
API/ABI compatibility to MySQL.

Prerequisites
~~~~~~~~~~~~~

You have to set mysql::server::root\_password manually.

::

    mysql::server::root_password: "password"

.. hint:: Min-Length: 8, Max-Length: 32, A-Za-z0-9 only

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

::

    database::databases:
      "withoutuser":
        "type": "mysql"
      "withuser":
        "type": "mysql"
        "user_password": "cleartext-password"

Users
~~~~~

-  add a User
-  you have to add desired grants additionally
-  if you add Users for remote Hosts, also add corresponding Firewall
   Rule

::

    database::users:
      "alice@localhost":
        "password": "cleartext-password"
      "box@remote.host":
        "password": "cleartext-password"

Grants
~~~~~~

-  grant Access for a User to a Database and Tables

::

    database::grants:
      "alice@localhost":
        "user":     "alice@localhost"
        "database": "withoutuser"
        "table":    "*"
      "box@remote.host":
        "user":     "box@remote.host"
        "database": "withoutuser"
        "table":    "*"
      "specifictable@localhost":
        "user":     "specifictable@localhost"
        "database": "withoutuser"
        "table":    "tablename"

Additional configuration options
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  ``mysql::server::password``: Password for the root User
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
backup, import it and remove the .sql file:

::

    cd ~/backup/ && lzop -d database.sql.lzo && mysql database < database.sql && rm database.sql

the database.sql.lzo.1 is the backup from yesterday.

Access
~~~~~~

phpmyadmin
^^^^^^^^^^

We provide a central `phpMyAdmin
installation <https://dbadmin.snowflakeops.ch>`__ to access your
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

::

    database::databases:
      "withuser":
        "type": "postgresql"
        "user_password": "cleartext-password"

Backup
~~~~~~

Every database is dumped daily into the ``~/backup/`` directory.

Elasticsearch
-------------

You can setup an Elasticsearch instance as simple as any database.

Settings
~~~~~~~~

The Elasticsearch Database Type accepts the following settings: \*
``memory_ratio`` - will set the memory available to elasticsearch (see
server/configuration for details) \* ``custom_conf`` - array that will
be appended to the elasticsearch config file (see example below) Note:
Don't overwrite ``path.repo`` here unless you know what you're doing.
Backup will probably fail.

Access
~~~~~~

Elasticsearch only locally accessible through localhost:9200. You can
setup a Proxy as follows:

::

    websites::site:
      "elasticproxy":
        "server_name": "elastic.host"
        "type":        "proxy"
        "members":
          - localhost:9200

Protection
~~~~~~~~~~

If you want to protect your instance, you can do so on the proxy set
above. If you put following example in your ``~cnf/nginx.conf``, you can
only write to elasticsearch from the ip/netmask set and will have naxsi
activated for all requests.

::

    location ~ /.* {
        limit_except GET {
            allow 154.132.02.15;
            deny all;
        }

        include /etc/nginx/naxsi/naxsi.rules;
        include /home/elastic/cnf/nginx_waf.conf;

        proxy_pass          http://elasticproxy;
        proxy_read_timeout  90;
        proxy_connect_timeout  90;
        proxy_redirect  default;
        proxy_set_header        Host $host;
        proxy_set_header        X-Real-IP $remote_addr;
        proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;

    }

Example
~~~~~~~

::

    database::databases:
      "elastic":
        "type":         "elasticsearch"
        "memory_ratio": "1.5"
        "custom_conf":
          - "node.name: my_elastic_node_004"
          - "discovery.zen.minimum_master_nodes: 2"

Backup
~~~~~~

Elasticsearch is backed up using the Snapshot-Feature: Every night, the
server takes a new snapshot backs this snapshot away. This way, you can
restore the indexes on a nightly basis. If you need to restore the data
of the past night, you can simple do this via the Rest API using the
``backup`` snapshot.

Note: Of course you can define other snapshots and backup manually more
often or keep them further back. Use ``custom_conf`` for configuring a
new snapshot-folder (make sure the user ``elasticsearch`` can write
there) and the rest of the setup is possible via Rest API.
