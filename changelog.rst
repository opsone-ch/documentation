Changelog
=========

We are using so called server generations,
based on a certain Debian release and tied to versions of further software like PHP, MySQL and so on.
This concept allows you to select the appropriate version depending on the application you use,
and also to switch to a newer generation in a planned way according to your needs.
Right now, you are looking at the documentation of the 6th generation.

Changes between 5.0 - 6.0
-------------------------------------------

System Wide
^^^^^^^^^^^

- update to Debian Stretch
- switched from SysVinit to systemd
- removed rabbitmq service which was not used at all. Please contact us if you plan to use this service for a new project
- removed subversion package and configuration. Please install and configure manually, if you still need subversion somewhere
- msmtp was replaced by Postfix to send outgoing mails. See :doc:`server/e-mail` for details
- new feature to add custom ca certificates to the servers key chain. See :doc:`server/ca-certificates` for details
- Netdata added for realtime metrics monitoring, see :doc:`server/monitoring` for details

Website Service
^^^^^^^^^^^^^^^

- switched nginx web application firewall from naxsi to ModSecurity
- renamed the ``htpasswd`` parameter to ``preview_htpasswd``
- proxy type: removed ``members`` option, add ``proxy_pass`` option
- proxy type: export Proxy Pass as ``PROXY_PASS`` Environment Variable
- nodejs type: select desired node version trough nvm. By default, the latest lts version is installed
- redirect type: added ``target_code`` parameter
- neos type: will use PHP 7.2
- wordpress type: will use PHP 7.2
- added local, environment dependent nginx configuration files ``nginx-prod.conf``, ``nginx-stage.conf``, ``nginx-dev.conf``
- added ``~/cnf/nginx-redirect.conf`` include to each http to http redirect vhost to influence its behaviour
- added php71 type
- added php72 type
- added typo3cmsv9 type
- added typo3cmsv10 type
- added magento2 type
- added docker type
- typo3cmsv7 and typo3cmsv8 types will use PHP 7.2
- added ``nvm`` parameter to each website to enable node on any website type
- removed different PHP configuration settings and added central ``~/cnf/php.ini`` configuration file instead
- renamed typo3neos website type to neos
- removed javascript service, install a up-to-date nodejs version trough the nodejs website service instead
- removed HHVM website type which was not used anymore
- removed typo3cms website type which is EOL
- removed magento (v1) type which is EOL
- removed php type which is EOL
- removed php70 type which is EOL
- removed drupal website type as we can achieve the very same configuration with the php72 type
- removed todoyu website type as we can achieve the very same configuration with the php72 type
- removed symfony website type as we can achieve the very same configuration with the php72 type

Database Service
^^^^^^^^^^^^^^^^

- removed ``mysql::server::root_password`` altogether. We're using the unix_socket plugin to login as root now.

Solr Service
^^^^^^^^^^^^^^^

- added Solr 7
- removed Solr 5 which is EOL
- removed Solr 4 which is EOL

Tomcat Service
^^^^^^^^^^^^^^^

- removed service altogether as it was used for Solr only which runs standalone in recent versions
- please contact us if you plan to use Tomcat for a new project

