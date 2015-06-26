# Services

After you receive a ordered server, the machine is more or less empty and of no much use. However, you can add so called services to the machine wich will install and configure all necessary compontents.

Note: Keep the resource usage in mind. On a server with 1GB RAM for example, you wont be able to add a 1GB memcached instance.

Warning: While you can mix most of those services, some of them will play rather nicely together, but others wont due to different requirements. **In many cases, its more feasible to spread services over multiple servers.**


## Website

Our website module provides everything you need, to manage, deploy and run your website.
It supports the following website types, helpers and additional services:


### Types

Currently we support the following CMS, eCommerce systems, blogs and programmming languages for your website "out of the box",
with a preinstalled and optimized environment to improve the performance, scalability, security and availability of your website:

* [typo3cms](services/website.md#typo3cms)
* [typo3neos](services/website.md#typo3neos)
* [magento](services/website.md#magento)
* [wordpress](services/website.md#wordpress)
* [drupal](services/website.md#drupal)
* [php](services/website.md#php)
* [hhvm](services/website.md#hhvm)
* [html](services/website.md#html)
* [uwsgi](services/website.md#uwsgi)
* [symfony](services/website.md#Symfony)


### Environments

There are also many helpers, to improve your websites environment:

* [Environments](services/website.md#Environments)
    * DEV
    * STAGE
    * PROD
* Security
    * [Web Application Firewall (WAF)](services/website.md#Web_Application_Firewall)
    * [TLS Certificate](services/website.md#TLS_Certificates)

You can easily add more servcies to your server with the following modules:


## Databases

Install and manage databases.

* [MariaDB (similar to MySQL)](services/database.md#mysql-mariadb)
* eXist
* more on request


## FTP

Access the filesystem of your server.

* [SSH](/server/access.md#SSH)
* [SFTP](/server/access.md#SFTP)
* [FTP](/services/ftp.md)

## Networking
