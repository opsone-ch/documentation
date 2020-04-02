.. index::
   triple: Website; Custom PHP Configuration; php.ini
   :name: website-advanced-php

===
PHP
===

* you can set custom PHP configurations trough the ``~/cnf/php.ini`` file
* see the `PHP Documentation <http://php.net/manual/en/configuration.file.per-user.php>`__ for details.

.. tip:: Reload PHP after changes by using the ``php-reload`` shortcut.

Examples
========

::

    memory_limit = 1G
    extension = ldap.so

.. tip:: list available extensions in ``/opt/php/php72/lib/php/extensions/no-debug-non-zts-20170718/``

