.. index::
   triple: Website; Security; security.conf
   :name: website-security

======================
Security Configuration
======================

Access to certain private files and directories like ``.git`` is forbidden
by including the global ``/etc/nginx/custom/security.conf`` file within the
websites configuration.

This file also contains the following security headers:

* ``add_header X-Frame-Options "SAMEORIGIN" always;``
* ``add_header X-Content-Type-Options "nosniff" always;``
* ``add_header X-XSS-Protection "1; mode=block always";``
* ``add_header Referrer-Policy "strict-origin-when-cross-origin" always;``

You can disable this include by setting ``security_conf`` to ``false`` within the
custom JSON configuration. If you disable this, we recommend to copy the content
into your own nginx.conf and adjust it to your own needs (you can view the content
with the :ref:`access_devop`).

Please be aware of any ramifications, and do not disable this settings unless you
absolutely know what you're doing.

.. warning::

   Make sure to deny access to private files and directories manually, or include
   our global security locations from ``/etc/nginx/custom/security.conf`` within
   your own configuration.

