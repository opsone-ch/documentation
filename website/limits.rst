.. index::
   triple: Website; Limits; Request Limits
   :name: website-limits

======
Limits
======

The number of connections and requests are limited to ensure that a
single user (or bot) cannot overload the whole server.

Request Limits
==============

* 50 connections / address
* 50 requests / second / address
* 150 requests / second (burst)
* >150 requests / second / address (access limited)

With this configuration, a particular visitor can open up to 50
concurrent connections and issue up to 50 requests / second.

If the visitor issues more than 50 request / second, those requests are
delayed and other clients are served first.

If the visitor issues more than 150 request / second, those requests
will not processed anymore, but answered with the 503 status code.

Adjust limits
-------------

To adjust this limits for special applications such as API calls,
set a higher `load zone` in your
:ref:`website-advanced-nginx_website` nginx configuration:

::

    # connection limits (e.g. 75 connections)
    limit_conn addr 75;

    # limit requests / second: (small, medium, large)
    limit_req zone=medium burst=500;
    limit_req zone=large burst=1500;

.. tip:: To apply the changes reload the nginx configuration with the ``nginx-reload`` shortcut.

Zones
-----

-  small = 50 requests / second (burst: 150req/sec)
-  medium = 150 requests / second (burst: 500 req/sec)
-  large = 500 requests / second (burst: 1500 req/sec)

Note: the default zone is "small" and will fit most use cases

.. tip::

   For details, see the
   `nginx Module ngx\_http\_limit\_req\_module <http://nginx.org/en/docs/http/ngx_http_limit_req_module.html>`__
   documentation.

Limiting User Agents
====================

To avoid overloading caused by search site crawlers,
we introduced the ability to limit requests based on the user agent.
By default, we limit the ``bing`` bot to one request per second.

These defaults can be overridden in `Custom JSON` :ref:`customjson_website`, below is an example.

.. code-block:: json

   {
     "limit_useragents_rate": "20",
     "limit_useragents_condition": "~*(mean-bot|bing) $binary_remote_addr;"
   }

