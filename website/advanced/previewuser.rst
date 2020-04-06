.. index::
   triple: Website; Advanced; Preview User
   :name: website-advanced-previewuser

============
Preview User
============

On all non PROD contexts, we configure basic authentication in front
of your website. This will ensure that there is no content leaked
into the world coming from one of your internal websites.

Default User
============

The default username is called `preview`. You can set the desired
password in the `Preview password` field by either:

* generate a new, random password through the `Generate` button
* hash your desired password through with the `htpasswd` utility

Change Username
===============

Per Website
-----------

You can change the default username `preview` to a value of your own
by setting the ``preview_username`` string within the
`Custom JSON` :ref:`customjson_website`:

.. code-block:: json

   {
     "preview_username": "mypreviewusername"
   }

Globally
--------

To change the default username for all websites on a given server,
you can override the value ``website::preview_username`` within the
`Custom JSON` :ref:`customjson_server`:

.. code-block:: json

   {
     "website::preview_username": "myglobalpreviewusername"
   }

Additional Users
================

To add additional users for all websites on a given server,
you can set the ``website::users`` hash within the
`Custom JSON` :ref:`customjson_server`:

.. code-block:: json

  {
    "website::users": {
      "alice": {
        "preview": "$apr1$RXDs3l18$w0VJrVN5uoU6DMY.0xgTr/"
      },
      "bob": {
        "preview": "$apr1$RSDdas2323$23case23DCDMY.0xgTr/"
      }
    }
  }

.. tip::

   Add such additional users for yourself and your co-workers. You can use
   your own login on every website then.

Disable Authentication
======================

You can disable the authentication altogether by de-selecting `Enable preview auth`
on the websites `Advanced` tab.

.. warning::

   After deselecting preview auth, the website will be reachable from everywhere.
   Make sure you do not leak private informations. Often, there are better suited
   alternatives like open access for certain ip address ranges only.

