.. index::
   triple: Website; Security; security.conf
   :name: website-security

======================
Security Configuration
======================

Access to certain private files and directories is forbidden and
the following security headers are added by default:

* ``X-Frame-Options``: ``SAMEORIGIN``
* ``X-Content-Type-Options``: ``nosniff``
* ``X-XSS-Protection``: ``1; mode=block``
* ``Referrer-Policy``: ``strict-origin-when-cross-origin``

This is a reasonable default configuration for most applications. If you have
other needs, see the possible options below.

.. tip::

   You can include the default security configuration from
   ``/etc/nginx/custom/security-<website-name>.conf`` into your own nginx
   locations.

X-Frame-Options Header
======================

The ``X-Frame-Options`` header is set to ``SAMEORIGIN`` by default.
To adjust it, set the ``security_header_xframe`` option within the
`Custom JSON` :ref:`customjson_website`:

.. code-block:: json

   {
     "security_header_xframe": "your-desired-value-for-the-x-frame-options-header"
   }

X-Content-Type-Options Header
=============================

The ``X-Content-Type-Options`` header is set to ``nosniff`` by default.
To adjust it, set the ``security_header_content_type`` option within the
`Custom JSON` :ref:`customjson_website`:

.. code-block:: json

   {
     "security_header_content_type": "your-desired-value-for-the-x-content-type-options-header"
   }

X-XSS-Protection Header
=======================

The ``X-XSS-Protection`` header is set to ``"1; mode=block`` by default.
To adjust it, set the ``security_header_xss_prot`` option within the
`Custom JSON` :ref:`customjson_website`:

.. code-block:: json

   {
     "security_header_xss_prot": "your-desired-value-for-the-x-xss-protection-header"
   }

Referrer-Policy
===============

The ``Referrer-Policy`` header is set to ``strict-origin-when-cross-origin`` by default.
To adjust it, set the ``security_header_refpolicy`` option within the
`Custom JSON` :ref:`customjson_website`:

.. code-block:: json

   {
     "security_header_refpolicy": "your-desired-value-for-the-referrer-policy-header"
   }


Disable
=======

To disable the full security configuration altogether, set ``security_conf``
to ``false`` within the `Custom JSON` :ref:`customjson_website`:

.. code-block:: json

   {
     "security_conf": false
   }

.. warning::

   Please be aware of any ramifications, and do not disable this settings unless
   you absolutely know what you're doing. Especially make sure that no private
   files can be accessed.

