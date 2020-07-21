.. index::
   single: Solr
   :name: solr

====
Solr
====

Solr is fully configured through the `Custom JSON` :ref:`customjson_server`.
You can define your instances through the ``solr::instances`` key.

Instance Name
=============

* the name is taken out of the ``solr::instances`` hash name (see examples below)
* a-z and 0-9 are allowed as instance name
* your solr instance is then available under ``solr-<name>.<fqdn>`` (example according to `minimal example <#minimal-example>`__: solr-yourname.server01.example.com)

Instance Options
================

version
-------

* desired Solr version
* Docker Hub image
* tested versions

  * ``typo3solr/ext-solr:10.0.1``
  * ``solr:8.5.0``

.. warning::

   Even if you can use other versions available as Docker image as well,
   we did test the images mentioned above only, and cannot guarantee anything
   for other versions. Please contact us if you plan to use other versions.

.. hint::

   For TYPO3 Solr, you'll find more informations in the
   `TYPO3 Solr Documentation <https://docs.typo3.org/p/apache-solr-for-typo3/solr/master/en-us/Index.html>`__.

htpasswd
--------

* htpasswd hash for basic auth
* username is ``solr-<name>``

ensure
------

* ``present`` if this Solr instance should be installed
* ``absent`` if this Solr instance should get removed
* default: ``present``

server_name
-----------

* server name under which this installation is available
* default: ``solr-<name>.<fqdn>``

ssl_acme
--------

* wheter a automatic certificate from Let's Encrypt is assigned
* default: ``true``

ssl_cert
--------

* variable to add your own SSL certificate
* default: empty

ssl_key
--------

* variable to add your own SSL key
* default: empty

monitoring
----------

* wheter this Solr instance is monitored through us
* default: ``true``

Minimal Example
===============


Configuration through `Custom JSON` :ref:`customjson_server`.

.. code-block:: json

   {
     "solr::instances": {
       "yourname": {
         "version": "typo3solr/ext-solr:10.0.1",
         "htpasswd": "$apr1$LIto7/SK$AMosnNDL63JV.3LAuCk0n1"
       }
     }
   }


Full Example
============

Configuration through `Custom JSON` :ref:`customjson_server`.

.. code-block:: json

   {
     "solr::instances": {
       "yourname": {
         "ensure": "present",
         "version": "typo3solr/ext-solr:10.0.1",
         "htpasswd": "$apr1$LIto7/SK$AMosnNDL63JV.3LAuCk0n1",
         "server_name": "my-solr-core.example.net",
         "ssl_acme": false,
         "ssl_cert": "your-own-ssl-certificate",
         "ssl_key": "your-own-ssl-key",
         "monitoring": false
       }
     }
   }

