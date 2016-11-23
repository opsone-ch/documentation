FTP Service
===========

This service will install and configure ProFTPD and manage virtual
users.

.. warning:: use FTP only if really required (for example for webcam access). Most use cases are just fine with SSH/SCP

Users
-----

-  adds a FTP User
-  password: crypt password as used in /etc/passwd
-  uid: Linux system user id of desired user. Lookup on server before
   adding.
-  gid: Linux system group id of desired group. Lookup on server before
   adding.
-  home: access is restricted to this directory

::

    ftp::users:
      "alice":
        "password": "$6$1sLLOf5.$GAZDHYXEjs0MpR5uHBAR5eD00MpUasTgbyIP27PZ8WprL98XeU01N502ogYn1JKrgqEiTXn1/lkFBNZ46zZHY/"
        "uid":      "1005"
        "gid":      "1005"
        "home":     "/home/examplenet/www/webcam/"

Hint: The password has to be encrypted. Use the following command to
encrypt your desired password: ``mkpasswd -m sha-512``

Hint: Use the "id" command to determine the appropriate uid/gid

Note: Access is enabled by both FTP and FTPS. Use the server FQDN to
connect by FTPS as we use the \*.snowflakehosting.ch wildcard
certificate by default

Directories
-----------

-  add custom per directory options
-  see ProFTPD Documentation for Details: http://www.proftpd.org/docs/

::

    ftp::directories:
      "/home/examplenet/tmp/":
        "limit":
          "WRITE":
            "DenyAll":
            "AllowUser": "alice"

will led to this ProFTPD configuration:

::

    <Directory /home/examplenet/tmp/>
        <Limit WRITE>
            DenyAll undef
            AllowUser alice
        </Limit>
    </Directory>
