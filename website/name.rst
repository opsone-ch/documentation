.. index::
   pair: Website; Name
   :name: website-name

====
Name
====

The website name is defined once when you create the website initially.
All parts configured within the system are tied to this name so it
**cannot be modified afterwards**.

The name must start with a lower case letter, followed by lower case letters,
digits, underscores or dashes. It may be only up to 32 characters long.

Among others, the name is used to configure:

* system user and group
* database name and username (applies only when a database is configured)
* webserver vhost name
* configuration files
* type related cronjobs
* unix sockets, for example used between nginx and PHP

