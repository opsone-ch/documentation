.. index::
   triple: How-to; Getting Started with; Varnish
   :name: howto-varnish

============================
Getting Started with Varnish
============================

The following how-to describes a simple standard setup.

.. tip:: Please note that Varnish requires additional configuration depending on the CMS. If in doubt, contact us and we will try to help to select the best approach.

Install Varnish
---------------

In this example we use the `minimal example <../varnish.html#minimal-example>`__ which installs Varnish with default settings.
We install Varnish with the following `Custom JSON` :ref:`customjson_server`.

.. code-block:: json

   {
     "varnish::ensure": "present"
   }

Backend
-------

A backend server (also known as origin) is the server providing the content Varnish will cache.
In this how-to we assume that you already have a website set up that acts as a backend.

To ensure that Varnish can use your website as backend, we change the following settings:

- We disable Auto SSL and preview auth. We add this later on the frontproxy.
- We bind the website to localhost and port 8080. `This makes the website accessible to Varnish <../varnish.html#backend-host-backend-port>`__.

For this we set the following configuration within the `Custom JSON` :ref:`customjson_website`:

.. code-block:: json

   {
    "listen_ip": "127.0.0.1",
    "listen_port": "8080",
    "ipv6_listen_ip": "::1",
    "ipv6_listen_port": "8080"
   }

Frontproxy
----------

The version cached by Varnish is automatically `made available on localhost on port 8022 <../varnish.html#port-port6>`__.
For this to be publicly available, we need to create a new website that acts as a frontproxy.

Create a new Website with the following settings:

- Type: Proxy
- Hostnames: Same as for the backend
- Proxy Pass: ``http://127.0.0.1:8022``
- Optional: Enable Auto SSL

Caching
-------

Varnish decides what needs to be cached `based on HTTP headers <https://varnish-cache.org/docs/6.1/users-guide/increasing-your-hitrate.html#the-role-of-http-headers>`__.
It's worth taking a closer look to make sure that caching really works with your setup.
Some CMS systems have their own manuals and extensions, which make the use of varnish easier.