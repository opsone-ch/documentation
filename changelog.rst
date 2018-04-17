Changelog
=========

We are using so called server generations,
based on a certain Debian release and tied to versions of further software like PHP, MySQL and so on.
This concept allows you to select the appropriate version depending on the application you use,
and also to switch to a newer generation in a planned way according to your needs.
Right now, you are looking at the documentation of the 6th generation.

Changes between 5.0 - 6.0
-------------------------------------------

- update to Debian Stretch
- switch from SysVinit to systemd
- removed javascript service, install a up-to-date nodejs version trough the nodejs website service instead
- removed HHVM website type which was not used anymore
- removed typo3cms & typo3cmsv7 website types
- removed drupal website type as we can achieve the very same configuration with the php72 type
- removed magento type
- renamed typo3neos website type to neos
- removed rabbitmq service which was not used at all. Please contact us if you plan to use this service for a new project
- removed subversion package and configuration. If you still need subversion somewhere, please install manually through base::packages
- switched nginx web application firewall from naxsi to modsecurity

