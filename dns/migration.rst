Migration
=========

Recommended steps for a DNS migration.

Glossary
--------

* **Domain Registrar:** The organisation you bought your domain from
* **Domain Registry:** The organisation that manages the TLD
* **TLD:** Top-level-domain for example ``.ch``, ``.com``, ``.org`` etc.
* **DNS Provider:** The organisation that host your name servers
* **DNSSEC:** A security protocol for DNS
* **TTL:** The time a DNS record is cached by a DNS resolver or client

Migrate to Ops One DNS
----------------------

.. note:: DNS changes take time to propagate. Always plan enough time.

1. Check whether you have all the necessary accesses. You need at least access to the domain registrar and the Cockpit. And, depending on the case, also to the old DNS provider.
2. Create a new DNS zone in the `Cockpit <https://cockpit.opsone.ch/>`__ and create all necessary DNS records.
3. Check with the registrar or your current DNS provider to see if you have DNSSEC enabled. If so, deactivate DNSSEC at the domain registrar. After changing DNSSEC, you should wait 24 hours.
4. Change the name servers at the domain registrar to the name servers of Ops One.
5. After 24 hours, you can reactivate DNSSEC at the registrar. If we are your domain registrar, this happens automatically after a few days, you don't have to do anything in this case.

Waiting times
~~~~~~~~~~~~~

Name servers and DNSSEC records usually have a high TTL.
You have no control over this, this is under the control of the domain registry.
You can check how high the TTL is or wait at least 24 hours to be on the safe side.
Also note that some DNS resolvers can cache longer than intended.

Example TTL of the nameservers for example.com:

.. code-block:: shell

  # name servers of the domain registry
  $ dig +short com. ns
  a.gtld-servers.net.
  b.gtld-servers.net.
  c.gtld-servers.net.

  # check TTL (ns)
  $ dig @a.gtld-servers.net. example.com. ns
  example.com.		172800	IN	NS	a.iana-servers.net.
  example.com.		172800	IN	NS	b.iana-servers.net.

Example TTL of the DNSSEC records for example.com:

.. code-block:: shell

  # name servers of the domain registry
  $ dig +short com. ns
  a.gtld-servers.net.
  b.gtld-servers.net.
  c.gtld-servers.net.

  # check TTL (ds)
  $ dig @a.gtld-servers.net. example.com. ds
  example.com.		86400	IN	DS	31589 8 1 3490A6806D47F17A34C29E2CE80E8A999FFBE4BE
  example.com.		86400	IN	DS	31589 8 2 CDE0D742D6998AA554A92D890F8184C698CFAC8A26FA59875A990C03 E576343C
  example.com.		86400	IN	DS	43547 8 1 B6225AB2CC613E0DCA7962BDC2342EA4F1B56083
  example.com.		86400	IN	DS	43547 8 2 615A64233543F66F44D68933625B17497C89A70E858ED76A2145997E DF96A918
  example.com.		86400	IN	DS	31406 8 1 189968811E6EBA862DD6C209F75623D8D9ED9142
  example.com.		86400	IN	DS	31406 8 2 F78CF3344F72137235098ECBBD08947C2C9001C7F6A085A17F518B5D 8F6B916D