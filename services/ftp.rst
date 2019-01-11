FTP
===

This service will install and configure ProFTPD and manage virtual
users.

.. warning:: for your daily operations, please use SSH/SCP which is already in place by default

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

.. hint:: The password has to be encrypted. Use the following command to encrypt your desired password: ``mkpasswd -m sha-512``

.. hint:: Use the "id" command to determine the appropriate uid/gid

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

TLS Certificates
----------------

- TLS is enabled and required by default
- there is a option to disable the TLS requirement. As we try to avoid the usage of unencrypted FTP connections, this option is not documented. Please contact us in case you have to enable plain-text access

default certificate
^^^^^^^^^^^^^^^^^^^

If not configured otherwise (see below), a self signed certificate bearing the hostname of the server will be created and used for ProFTPD.

own certificate
^^^^^^^^^^^^^^^

Specify your own certificate with the ``tls_key`` and ``tls_crt`` options.

::

    ftp::wrapper::proftpd::tls_crt: |
      -----BEGIN CERTIFICATE-----
      MY-TLS-CERTIFICATE

    ftp::wrapper::proftpd::tls_key: |
      -----BEGIN PRIVATE KEY-----
      MY-TLS-KEY

own certificate in file
^^^^^^^^^^^^^^^^^^^^^^^

Another option is to use existing certificates already in place on this server, for example one thats used with nginx already. Specify the certificates location with the ``tls_key_file`` and ``tls_crt_file`` options.

::

    ftp::wrapper::proftpd::tls_crt_file: "/etc/nginx/ssl/<websitename>.crt"
    ftp::wrapper::proftpd::tls_key_file: "/etc/nginx/ssl/<websitename>.key"

.. hint:: With this option, you can also use certificates issued through nginx by Let's Encrypt

