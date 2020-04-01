.. index::
   triple: Server; Access; SSH
   :name: server-access-ssh

Means to Access Your Server
===========================

SSH
---

Your server is accessible trough SSH by default. There are no personal
SSH login users supported to ensure uniformity between SSH and web actions.

.. hint:: for security reasons, we allow key based logins only

Every aspect of the configuration is controlled through our configuration
management software. There is no root access possible neither for the
customer or ourself.

Shortcuts and sudo configuration
--------------------------------

Depending on the installed services, some shortcuts are available to execute certain commands with root privileges.
You will find a list of all shortcuts by typing ``help``.

.. index::
   triple: Server; Access; devop
   :name: server-access-devop

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
* ``update-ca-certificates``, see :ref:`server-ca_certificates` for details

.. hint:: use the ``lnav`` utility to display logs in a meaningful way (``lnav ~/log/`` as website user, ``lnav`` as ``devop`` user for global logs)

SFTP
----

After adding your publickey to the server, is it possible to connect
over SFTP. We recommend to use one of the following clients:

-  `Filezilla <https://filezilla-project.org>`__
-  `Cyperduck <https://cyberduck.io>`__

.. Hint:: To store your key in the memory and not having to enter the password for every connection - use pageant (Windows) or ssh-add it (Linux)

