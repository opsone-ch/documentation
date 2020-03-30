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

Generic ``devop`` user
----------------------

A user named ``devop`` is created by default. You can log into the server
with this user for debugging purposes or to execute some global tasks:

* read access to all system log files in ``/var/log/``
* read access to nginx vhosts in ``/etc/nginx/websites/``
* read access to the global modsecurity configuration in ``/etc/nginx/modsecurity/``
* ``puppet-agent`` to trigger a manual configuration management run
* ``reboot`` to trigger a manual server reboot
* ``diskusage`` to search for big files and folders
* ``iptables-list`` to list firewall rules and chains
* ``iptables-rules`` to show firewall rules
* ``update-ca-certificates``, see :doc:`ca-certificates` for details

.. hint:: use the ``lnav`` utility to display logs in a meaningful way (``lnav ~/log/`` as website user, ``lnav`` as ``devop`` user for global logs)

SSH client configuration
------------------------

Add client configurations to ``/etc/ssh/ssh_config`` by setting the
``ssh::config`` hash:

.. code-block:: json

  {
    "ssh::config": {
      "Host": "git",
      "HostName": "code.example.com",
      "User": "git"
    }
  }

.. Hint:: use ``man ssh_config`` (`online version <http://man.openbsd.org/ssh_config>`_) for available configuration options

SFTP
----

After adding your publickey to the server, is it possible to connect
over SFTP. We recommend to use one of the following clients:

-  `Filezilla <https://filezilla-project.org>`__
-  `Cyperduck <https://cyberduck.io>`__

.. Hint:: To store your key in the memory and not having to enter the password for every connection - use pageant (Windows) or ssh-add it (Linux)

