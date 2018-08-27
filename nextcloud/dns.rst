Custom domain
=============

By default we provide a subdomain under which Nextcloud is available. However, you are free to use your own domain like ``cloud.example.com``.

::

    # Name                Type        Value
    <YOUR-DOMAIN>         IN CNAME    <OUR-SERVER>
    <YOUR-DOMAIN>         IN TXT      v=spf1 mx include:opsdata.ch -all

Please contact us so that we can prepare everything on the server side.

.. note:: HTTPS Certificate: We use Let's Encrypt and issue a new certificate for your domain.