RabbitMQ Service
================

Install RabbitMQ and enable messaging for your favorite applications.

Install
-------

To install a preconfigured RabbitMQ, add the service to your server:

::

    # additional Puppet Modules
    base::modules:
      - "rabbitmq"

User add
--------

Simply add a new user over hiera:

::

    # RabbitMQ Configuration
    base::rabbitmq::user:
      "username":
        "admin":    "true"
        "password": "haVah2vohQuoosait1Th"

Firewall rules
--------------

Don't forget to add firewall rules (see :doc:`firewall`) to access
RabbitMQ from your application. For example add:

::

    # allow Access to RabbitMQ from xy
    base::firewall::rules:
      "101 accept RabbitMQ from xy":
        "chain":   "INPUT"
        "port":    "5672"
        "source":  "91.234.160.xy"
        "source6": "2a04:503:0:105::1:xy"

