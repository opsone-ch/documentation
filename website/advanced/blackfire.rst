.. index::
   triple: Website; Debugging; Blackfire
   :name: website-advanced-blackfire

=========
Blackfire
=========

Blackfire.io makes it possible to write performance tests, automate test scenarios,
and drill down to the finest details whenever performance issues arise.

For more informations, head over to the `Blackfire website <https://blackfire.io>`__.

.. warning::

   Blackfire is a SaaS offering. Please bear in mind, that some of your application
   data will be transfered to and analyzed by Blackfire servers. Make sure that this
   is in compliance to your legal requirements.

Requirements
============

* Blackfire account
* Credentials (Blackfire Account `Settings > Credentials <https://blackfire.io/my/settings/credentials>`__)

  * Client ID
  * Client Token
  * Server ID
  * Server Token

Server Configuration
====================

To install and configure the Blackfire agent on your server, add the following configuration
to the `Custom JSON` :ref:`customjson_server`:

.. code-block:: json

   {
     "blackfire::server_id": "<your-server-id>",
     "blackfire::server_token": "<your-server-token>"
   }

Website Configuration
=====================

To install and configure the Blackfire agent on your website, add the following configuration
to the `Custom JSON` :ref:`customjson_website`:

.. code-block:: json

   {
     "blackfire_client_id": "<your-client-id>",
     "blackfire_client_token": "<your-client-token>"
   }

.. warning::

   By now, Blackfire is availalbe for CLI and PHP workloads. Please contact us for other use cases.

