.. index::
   triple: Server; CA Certificates; SSL Trust Store
   :name: cacertificates

===============
CA Certificates
===============

Global CA certificates are installed and updated by the ``ca-certificates`` packages from the Debian distribution.

Add own certificates
--------------------

To add own certificates to the servers trust store, place them within ``/usr/local/share/ca-certificates``.
You can access this directory by using the ``devop`` user.

.. hint:: After adding a certificate, update the trust store by executing ``update-ca-certificates``

