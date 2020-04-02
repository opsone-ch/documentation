.. index::
   pair: Access; SSH
   :name: access-ssh

Means to Access Your Server
===========================

SSH
---

Your server is accessible trough SSH by default. 
To ensure uniformity between SSH and web actions, there are no personal
SSH login users created. Log in with the desired websites user instead.

.. hint:: for security reasons, we allow key based logins only

Every aspect of the configuration is controlled through our configuration
management software. There is no root access possible neither for the
customer or ourself.

Shortcuts and sudo configuration
--------------------------------

Depending on the installed services, some shortcuts are available to execute certain commands with root privileges.
You will find a list of all shortcuts by typing ``help``.

.. index::
   pair: Access; devop
   :name: access_devop

Generic Admin User
------------------

A user named `devop` is created by default. You can log into the server
with this user for debugging purposes and to execute global tasks which are not
allowed to the website users:

* read access to all system log files in ``/var/log/``
* read access to nginx vhosts in ``/etc/nginx/websites/``
* read access to the global modsecurity configuration in ``/etc/nginx/modsecurity/``
* ``puppet-agent`` to trigger a manual configuration management run
* ``reboot`` to trigger a manual server reboot
* ``diskusage`` to search for big files and folders
* ``nft-list`` to list the current nftables configuration
* ``nft-check`` to validate the current nftables configuration
* ``update-ca-certificates``, see :ref:`cacertificates` for details

.. tip:: To display log files, use the :ref:`howto-logfile_lnav` and :ref:`howto-logfile_goaccess` utilities.

SFTP
----

After adding your publickey to the server, is it possible to connect
over SFTP. We recommend to use one of the following clients:

-  `Filezilla <https://filezilla-project.org>`__
-  `Cyperduck <https://cyberduck.io>`__

.. Hint:: To store your key in the memory and not having to enter the password for every connection - use pageant (Windows) or ssh-add it (Linux)

