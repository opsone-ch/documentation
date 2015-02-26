# Database 

Install and manage your favorite databases. Including users, grants, and the configuration.

## MySQL / MariaDB

At the moment only MariaDB (drop-in replacement for MySQL) is supported. More database types on request. (eXist etc).

## Prerequisites

* dont forget to set mysql::server::root_password
```
mysql::server::root_password: "password"
```


## Databases

* add a Database
* title: Database Name
* type: Database Type, only "mysql" supported by now
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


## Users

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


## Grants

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

