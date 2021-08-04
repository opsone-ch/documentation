.. index::
   triple: Server; FTP; File Transfer Protocol
   :name: ftp

==========
FTP Access
==========

This service will install and configure ProFTPD and manage virtual users.

.. warning:: Nowadays, FTP is not required for your daily work anymore. Please use SSH/SCP which is already in place by default. See :ref:`access-ssh` for details.

Users
-----

-  adds a FTP User
-  password: crypt password as used in /etc/passwd
-  uid: Linux system user id of desired user. Lookup on server before
   adding.
-  gid: Linux system group id of desired group. Lookup on server before
   adding.
-  home: access is restricted to this directory

Configure the ``ftp::users`` hash within the `Custom JSON` :ref:`customjson_server`:

.. code-block:: json

  {
    "ftp::users": {
      "alice": {
        "password": "$6$1sLLOf5.$GAZDHYXEjs0MpR5uHBAR5eD00MpUasTgbyIP27PZ8WprL98XeU01N502ogYn1JKrgqEiTXn1/lkFBNZ46zZHY/",
        "uid": "1005",
        "gid": "1005",
        "home": "/home/examplenet/www/webcam/"
      }
    }
  }

.. tip:: The password has to be encrypted. Use the following command to encrypt your desired password: ``mkpasswd -m sha-512``

.. tip:: Use the "id" command to determine the appropriate uid/gid

Directories
-----------

-  add custom per directory options
-  see ProFTPD Documentation for Details: http://www.proftpd.org/docs/

Configure the ``ftp::directories`` hash within the `Custom JSON` :ref:`customjson_server`:

.. code-block:: json

  {
    "ftp::directories": {
      "/home/examplenet/tmp/": {
        "limit": {
          "WRITE": {
            "DenyAll": null,
            "AllowUser": "alice"
          }
        }
      }
    }
  }

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

.. warning::

   You can disable the TLS requirement by setting the  ``ftp::wrapper::proftpd::tlsrequired`` string to ``off``.
   As the FTP connection is not encrypted anymore, this option is strongly not recommended.
   Please contact us to find another solution.

Default Certificate
^^^^^^^^^^^^^^^^^^^

If not configured otherwise (see below), a self signed certificate bearing the hostname of the server will be created and used for ProFTPD.

Own Certificate
^^^^^^^^^^^^^^^

Specify your own certificate with the ``tls_key`` and ``tls_crt`` options.

Configure the ``ftp::wrapper::proftpd::tls_crt`` and ``ftp::wrapper::proftpd::tls_key``
strings within the `Custom JSON` :ref:`customjson_server`:

.. code-block:: json

   {
     "ftp::wrapper::proftpd::tls_crt": "-----BEGIN CERTIFICATE-----\nMY-TLS-CERTIFICATE\n",
     "ftp::wrapper::proftpd::tls_key": "-----BEGIN PRIVATE KEY-----\nMY-TLS-KEY"
   }

Own Certificate from File
^^^^^^^^^^^^^^^^^^^^^^^^^

Another option is to use existing certificates already in place on this server,
for example one thats used with nginx already.

Configure the locations with the ``ftp::wrapper::proftpd::tls_crt_file`` and ``ftp::wrapper::proftpd::tls_key_file``
strings within the `Custom JSON` :ref:`customjson_server`:

.. code-block:: json

   {
     "ftp::wrapper::proftpd::tls_crt_file": "/etc/nginx/ssl/<websitename>.crt",
     "ftp::wrapper::proftpd::tls_key_file": "/etc/nginx/ssl/<websitename>.key"
   }

.. tip:: With this option, you can also use certificates issued through nginx by Let's Encrypt.

Default Firewall Rule
^^^^^^^^^^^^^^^^^^^^^

By default, firewall rules to  allow incoming ports 21 (FTP) and 49152-49162 (FTP data) will be added.
To disable those default rules, set ``ftp::wrapper::proftpd::nftables`` to ``false``
within the `Custom JSON` :ref:`customjson_server`:

.. code-block:: json

   {
     "ftp::wrapper::proftpd::nftables": false
   }

.. note::

   Please make sure to allow access for our internal monitoring system manually
   (IPv4: ``185.17.70.112``, IPv6: ``2a04:503:0:1008::112``)

