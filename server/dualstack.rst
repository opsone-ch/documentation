Dualstack IPv4/IPv6
===================

All our servers and services are reachable by IPv4 and IPv6. We believe
strongly in the future of the IPv6 Internet and are Member of the `Swiss
IPv6 Council <http://www.swissipv6council.ch/>`__.

\*\* Hint: \*\* Please help us spreading IPv6 usage by adding those DNS
records. Its all you have to do manually, all other aspects of IPv4/IPv6
dualstack are covered by us.

Lookup Addresses
----------------

To enable IPv6 for your services you have to add the appropriate AAAA
Records in DNS, in addition the the existing A Record. You can lookup
both IP addresses with this command:

::

    $ facter ipaddress ipaddress6
    ipaddress => 185.17.68.153
    ipaddress6 => 2a04:503:0:1003::153

add DNS Records
---------------

Use the "ipaddress" Value as A Record and the "ipaddress6" Value as AAAA
Record:

::

    www.snowflakehosting.ch.    IN  A       185.17.68.153
    www.snowflakehosting.ch.    IN  AAAA    2a04:503:0:1003::153
