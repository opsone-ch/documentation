Networking Service
==================

Infrastructure
--------------

-  each server is connected to two top of the rack switches by 2x10G
-  connections are configured as redundant, active/active Layer 2 & 3
   Setup (MLAG/VARP)
-  we make heavy usage of VLANs to seperate customer segements
-  all our servers and services are reachable by IPv4 and IPv6. Details
   are available at the `Dualstack
   Documentation </server/dualstack.md>`__.

Configuration
-------------

-  all servers are setup with sane defaults, usually you dont have to
   worry about network configuration
-  for special cases, you can add the following settings

::

    # Network Configuration
    networking::interfaces:
      "eth0":
        "address":           "99"
        "address_prefix_v4": "192.168.0"
        "netmask_v4":        "255.255.255.0"
        "gateway_v4":        "192.168.0.1"
        "address_prefix_v6": "2001:db8::"
        "netmask_v6":        "64"
        "gateway_v6":        "2001:db8::1"

-  this will led to the following Network Configuration

::

    auto eth0
        iface eth0 inet static
        address 192.168.0.99
        netmask 255.255.255.0
        gateway 192.168.0.1

        iface   eth0 inet6 static
        address 2001:db8::99
        netmask 64
        gateway 2001:db8::1

-  usually, you only have to configure the "address" parameter. All
   other settings should get the appropriate value trough inheritance
-  by replacing eth0 with ethX, you can add additional interfaces in the
   same or other subnets
-  as both IPv4 and IPv6 is configured manually, we disable IPv6
   autoconf and router advertisement
