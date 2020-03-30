.. index::
   pair: Server; Custom JSON
.. _server-customjson:

===========
Custom JSON
===========

In our management interface `Cockpit`, only the most used configurations are implemented graphically.
For other, seldom used settings we used so called `Custom JSON` fields.

There are two differente `Custom JSON` fields available depending on the layer of your desired configuration.

.. hint::
  Please make sure that you use the provided configurations on the approrpiate layer which we indicate in each example.

Server Level
============

The server level `Custom JSON` is located on the servers `System` tab. It is used to influence the servers configurations,
for example to

* configure firewall rules (see :ref:`server-firewall`)
* configure the local mail server (see :ref:`server-postfix`)
* add own CA certificates to the servers trust store (see :ref:`server-ca_certificates`)

You can add entries to the servers hosts file for testing or other
purposes (e.g. TYPO3 page not found handling, APIs) like this:

Website Level
=============

The website level `Custom JSON` is located on the particular websites `Advanced` tab. It is used to influence the websites configurations,
for example to

* change the default HSTS header sent (see :ref:`website-hsts`)
* set custom environment variables (see :ref:`website-envvar`)
* let the website listen on a specific port or interface (see :ref:`website-listen`)

