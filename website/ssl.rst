.. index::
   triple: Website; SSL; Certificate
   :name: website-ssl

================
SSL/HTTPS Access
================

Enable :ref:`website-ssl_letsencrypt` or add your :ref:`website-ssl_owncertificate`
to make your website reachable over HTTPS. Nowadays, this is considered good
practice and should be enabled on all websites.

As soon as you enable SSL with us, we will make sure that all state of the art
settings are in place. Also, we will check your certificate every day trough
`Qualys SSL Labs <https://www.ssllabs.com/>`__.

When SSL is enabled, access to the website by HTTP is not possible anymore but
redirectet to HTTPS instead (:ref:`website-ssl_httpredirect` for details).

.. index::
   triple: Website; SSL; Let's Encrypt
   :name: website-ssl_letsencrypt

.. index::
   triple: Website; SSL; Auto SSL
   :name: website-ssl_autossl

Auto SSL (Let's Encrypt)
========================

We support free ssl certificates by `Let's Encrypt <https://letsencrypt.org/>`__.
Just activate Let's Encrypt on your desired website.
The certificates are automatically renewed 30 days before expiration.

Debug validation problems
-------------------------

In order to debug validation issues, we introduced the ``letsencrypt-renew`` shortcut which will trigger a run of our Let's Encrypt client, and let you see all debug output to identifiy possible problems.

* Make sure that all hosts added to ``Server name`` point to the correct server (A and AAAA DNS records).
* Let's Encrypt will try to reach your website at the endpoint ``/.well-known/acme-challenge/`` for validation purposes. Make sure that you do not overwrite this path within your `own nginx configuration <#custom-configuration>`__.
* You can check access to the validation directory by yourself by fetching the control file reachable at ``http://example.com/.well-known/acme-challenge/monitoring``

Renewal
-------

Certificates from Let's Encrypt will be valid for 90 days. They are renewed automatically as soon as they expire in under 30 days. You can follow these checks and renewals by grep for ``letsencrypt`` in ``/var/log/syslog``.

Furthermore, we check all certificates from our monitoring and will contact you if there are certificates expiring in less than 21 days.

Export
------

Existing Let's Encrypt certificates are saved within ``/etc/nginx/ssl`` and
can be read with the :ref:`access_devop`.
This is useful if you want to temporarily use the old certificate on a new server.

.. index::
   triple: Website; SSL; Own Certificate
   :name: website-ssl_owncertificate

Own Certificate
===============

You can add your own certificate by using the `SSL cert` and `SSL key` fields
within the desired websites `Advanced` tab.

Before installing a custom certificate, please make sure that:

* your key matches your certificate
* all required intermediate certificates are included
* you used up-to-date settings to generate your key and signing request

.. tip::

   Please contact us if you are not proficient with this topic.
   We are happy to guide you through the process and can also
   order and install custom certificates on your behalf.

.. index::
   triple: Website; SSL; HTTP Redirect
   :name: website-ssl_httpredirect

HTTP Redirect
=============

By default, all HTTP requests within a given website are redirected
to HTTPS keeping the hostname supplied by the client. If you want to
change this behaviour somehow, for example by always redirect to the
first hostname of the vhost, you can set ``http_redirect_dest`` string
within the `Custom JSON` :ref:`customjson_website`:

.. code-block:: json

   {
     "http_redirect_dest": "https://$server_name$request_uri"
   }

Furthermore, it is possible to set the redirect destination globally
through ``website::http_redirect_dest`` which will be used on all
HTTP redirects without a explicitly set ``http_redirect_dest``
within the `Custom JSON` :ref:`customjson_server`:

.. code-block:: json

   {
     "website::http_redirect_dest": "https://$server_name$request_uri"
   }

Advanced Configuration
======================

We will make sure that all required settings do match the state of the art
configuration. Usually it is not required to change those settings, nevertheless
it is possible and might be required in certain use cases.

Cipher Suite
------------

Configure your desired cipher suite trough ``website::ssl_ciphers``
within the `Custom JSON` :ref:`customjson_server`:

.. code-block:: json

  {
    "website::ssl_ciphers": "desired-cipher-suites"
  }

.. warning:: We configure and update this value with sane defaults. Overwrite only when really required, and if you are aware of the consequences.

Diffie-Hellman parameters
-------------------------

Diffie-Hellman parameters are used for perfect forward secrecy. We supply default
Diffie-Hellman parameters and update them on a regular schedule. If you want to use
your own Diffie-Hellman parameters, you can generate them:

::

  openssl dhparam -out /tmp/dhparam.pem 4096

and configure them trough ``website::ssl_dhparam``
within the `Custom JSON` :ref:`customjson_server`:

.. code-block:: json

  {
    "website::ssl_dhparam": "-----BEGIN DH PARAMETERS-----\nMIICCAKCAgEAoOePp+Uv2M34IA+basW9CBHp/jsZihB3FI8KVRLVFJPIUJ9Llm8F\n...\n-----END DH PARAMETERS-----"
  }

.. index::
   pair: Website; HSTS
   :name: website_hsts

HSTS Header
-----------

By default, we add a HTTP Strict Transport Security (HSTS) header to each SSL enabled website:

::

 Strict-Transport-Security max-age=63072000;

Use the ``header_hsts`` string to override the default HSTS header
within the `Custom JSON` :ref:`customjson_website`:

.. code-block:: json

  {
    "header_hsts": "max-age=3600; includeSubDomains; preload"
  }

.. tip:: See the OWASP `HTTP Strict Transport Security Cheat Sheet <https://cheatsheetseries.owasp.org/cheatsheets/HTTP_Strict_Transport_Security_Cheat_Sheet.html>`__ for details.

Test
====

We recommend the following online services for testing:

-  `Qualys SSL Labs <https://www.ssllabs.com/ssltest/>`__
-  `digicert SSL Tools <https://ssltools.digicert.com/>`__

