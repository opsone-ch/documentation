Changelog
=========

We are using so called server generations,
based on a certain Debian release and tied to versions of further software like PHP, MySQL and so on.
This concept allows you to select the appropriate version depending on the application you use,
and also to switch to a newer generation in a planned way according to your needs.
Right now, you are looking at the documentation for the 201701 generation.

Changes between 5.0 - 6.0
-------------------------------------------

- update to Debian Stretch
- switch from SysVinit to systemd
- removed javascript service, install a up-to-date nodejs version trough the nodejs website service instead
- removed HHVM website type which was not used at all

