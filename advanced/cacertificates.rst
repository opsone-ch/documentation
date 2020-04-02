.. index::
   triple: Server; CA Certificates; SSL Trust Store
   :name: cacertificates

===============
CA Certificates
===============

Global CA certificates are installed and updated by the ``ca-certificates`` packages from the Debian distribution.

Add Own Certificates
--------------------

To add your own certificates to the servers trust store,
place them within ``/usr/local/share/ca-certificates``.

You can access this directory by login with the devop user (see :ref:`access_devop`).

.. tip:: After adding a certificate, update the trust store by executing ``update-ca-certificates``.

