Firewall
========

.. note:: this site belongs to the IP/network firewall. There is also a web application firewall within the :doc:`website` service

Default settings
----------------

By default, all incoming and outgoing traffic is blocked, expect:

- related or established connections
- ICMP/ICMPv6
- Traceroute
- SSH
- outgoing connections to the following common services
    - HTTP(S): TCP Ports 80, 443
    - SMTP(S): TCP Ports 25, 587, 465
    - POP3(S): TCP Ports 110, 995
    - IMAP(S): TCP Ports 143, 993

.. note:: depending on your companys guideline, outgoing connections might not be allowed by default

Disable common outgoing services
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To enhance the security level of your server, disable outgoing connections to common services by adding the following custom JSON configuration:

::

    {
      "base::firewall::allow_outgoing_ports": false
    }

Custom rules trough service
---------------------------

Where applicable, all services will add the firewall rules required automatically, for example:

- website module will allow incoming HTTP(S)
- ftp module will allow incoming FTP

Custom rules
------------

Where applicable, both IPv4 and IPv6 Rules are added by default (for example INPUT chains for a particular port).

Configuration
^^^^^^^^^^^^^

.. hint:: this service as based on the official Puppet firewall module. For further configuration details, see the `firewall documentation <https://github.com/puppetlabs/puppetlabs-firewall#firewall>`__ on Github

chain
"""""

* `INPUT` for incoming rules
* `OUTPUT` for outgoing rules

action
""""""

* `accept`: The packet is accepted.
* `reject`: The packet is rejected with a suitable ICMP response.
* `drop`: The packet is dropped.

source
""""""

IPv4 source address or network. Examples:

* `192.168.0.1`
* `192.168.0.0/24`

source6
"""""""

IPv6 source address or network. Examples:

* `2001:db8::1`
* `2001:db8::/32`

destination
"""""""""""

IPv4 destination address or network. Examples:

* `192.168.0.1`
* `192.168.0.0/24`

destination6
""""""""""""

IPv6 destination address or network. Examples:

* `2001:db8::1`
* `2001:db8::/32`

sport
"""""

Source port number.

dport
"""""

Destination port number.

Examples
^^^^^^^^

Allow outgoing
""""""""""""""

::

    {
      "base::firewall::rules": {
        "021 accept outgoing smtp to mailrelay": {
          "action": "accept",
          "chain": "OUTPUT",
          "destination": "192.168.0.1",
          "destination6": "2001:db8::1",
          "dport": "25"
        }
      }
    }

Deny incoming
"""""""""""""

You can add custom rules to deny services, too:

::

    {
      "base::firewall::rules": {
        "020 deny HTTP from evil network":
          "action": "reject",
          "chain": "INPUT",
          "source" "192.168.0.0/24",
          "source6": "2001:db8::/32",
          "dport": "80"
        }
      }
    }

Debugging
---------

Logged in as user ``devop``, you can diagnose created rules and logs
trough the following means:

-  Firewall logs in ``/var/log/messages``
-  show created rules with ``sudo iptables -L`` / ``sudo ip6tables -L``
