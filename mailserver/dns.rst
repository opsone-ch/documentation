DNS
===

Minimal DNS configuration
-------------------------

::

    # Name                Type        Value
    @                     IN MX 10    mail.example.com
    @                     IN TXT      v=spf1 mx -all

To explicitly allow our mailserver to send mails from your domain we recomment to add an SPF record to your DNS zone.

.. warning:: Please make sure to include all other servers that should be able to send mails from your domain.

DKIM
----

DKIM is an email authentication method designed to detect email spoofing. While it is not required to add those records, we recommend to do so.

Generate a new key for this domain through the webinterface. Use the following settings:

::

    Domain: example.com
    Selector: dkim
    DKIM key length: 2048 bits

.. image:: ../_static/create_dkim.gif
   :width: 100%
   :alt: create dkim key
   :align: left

Add created public key as TXT record under ``dkim._domiankey``:

::

    # Name              Type       Value
    dkim._domainkey     IN TXT     v=DKIM1; k=rsa; t=s; s=email; p=DKIM YOUROWNKEY