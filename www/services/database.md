# Database Service

Install and manage your favorite databases. Including users, grants, and the configuration.


## MySQL / MariaDB

Instead of MySQL, we use MariaDB, which is a drop-in replacement with API/ABI compatibility to MySQL.


### Prerequisites

You have to set mysql::server::root_password manually.

```
mysql::server::root_password: "password"
```

Hint: Min-Length: 8, Max-Length: 32, A-Za-z0-9 only.


### Databases

* add a Database
* title: Database Name
* type: Database Type: "mysql"
* user_password: adds a User with the same Name as the Database with this Password and grant all privileges
    * without this, you have to add user/grants by yourself (see below), otherwise only root can access this database
    * it is only possible to add a local User here. For special Configurations (e.g. external access or grants to particular Tables use users/grants below)

```
database::databases:
  "withoutuser":
    "type": "mysql"
  "withuser":
    "type": "mysql"
    "user_password": "cleartext-password"
```


### Users

* add a User
* you have to add desired grants additionally
* if you add Users for remote Hosts, also add corresponding Firewall Rule

```
database::users:
  "alice@localhost":
    "password": "cleartext-password"
  "box@remote.host":
    "password": "cleartext-password"
```


### Grants

* grant Access for a User to a Database and Tables

```
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
```


### Backup

Every database is backed up daily into the users backup directory:

``` 
/home/userdir/backup/
```

#### Restore

Choose between 2 options.

1. "rollback" with the MySQL binlog (point in time recovery)
2. restore the nightly backup

##### Rollback

Import the binlog.

* start-datetime: time of the last nightly dump
* stop-datetime: required restore point

and rollback:

```
mysqlbinlog --start-datetime="2015-02-09 22:07:00" --stop-datetime="2015-02-10 17:15:00" /var/log/mysql/mysql-bin.* | mysql database
```

##### Nightly restore

for a complete restore of the nightly database backup, decompress the backup, import it and remove the .sql file:

```
cd ~/backup/ && lzop -d database.sql.lzo && mysql database < database.sql && rm database.sql
```
the database.sql.lzo.1 is the backup from yesterday.

** Hint: ** If you need to restore older backups, feel free to contact our [Support](/support.md)

---

### Access

#### phpmyadmin

Access your database over the web with [phpMyAdmin](https://dbadmin.snowflakehosting.ch) and enter the credentials

* Server: server01.snowflakehosting.ch
* Username: your user
* Password: your password

#### SSH tunnel

To access the database with common database tools like MySQL Workbench, create a SSH tunnel to the server
and forward the MySQL port. After that, configure your favorite MySQL tool to connect to the forwarded localhost.

```
ssh -L 3306:localhost:3306 user@remotehost
```

Or directly with every ssh connection to the server with the following ssh .config entry:

```
LocalForward 3306 127.0.0.1:3306
```

#### local

simply access your database over the shell:

```
mysql
```

## Postgresql


### Prerequisites

You have to set `postgresql::server::postgres_password` manually.

```
postgresql::server::postgres_password: "password"
```

Hint: Min-Length: 8, Max-Length: 32, A-Za-z0-9 only.


### Databases

* add a Database
* title: Database Name
* type: Database Type: "postgresql"
* user_password: adds a User with the same Name as the Database with this Password and grant all privileges

```
database::databases:
  "withuser":
    "type": "postgresql"
    "user_password": "cleartext-password"
```

### Backup

Every database is dumped daily into the `~/backup/` directory.

