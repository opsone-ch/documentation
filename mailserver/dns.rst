DNS
===

Minimal DNS configuration
-------------------------

::

    # Name                Type        Value
    @                     IN MX 10    mail.example.com
    @                     IN TXT      v=spf1 mx -all

.. note:: Good secured mail services will discard mails sent from hosts which are not particularly allowed to, eventhough the default behaviour is to accept every mail. To explicitly allow our mailserver to send mails from your domain you need to add an SPF record to your DNS zone

.. warning:: Please make sure to include all other servers that should be able to send mails from your domain.

SRV Records
-----------

Some e-mail clients can use SRV records to automatically detect settings.

::

    # Name              Type       Value
    _imap._tcp          IN SRV     0 1 143   mail.example.org.
    _imaps._tcp         IN SRV     0 1 993   mail.example.org.
    _submission._tcp    IN SRV     0 1 587   mail.example.org.
    _smtps._tcp         IN SRV     0 1 465   mail.example.org.
    _autodiscover._tcp  IN SRV     0 1 443   mail.example.org.
    _carddavs._tcp      IN SRV     0 1 443   mail.example.org.
    _carddavs._tcp      IN TXT     "path=/SOGo/dav/"
    _caldavs._tcp       IN SRV     0 1 443   mail.example.org.
    _caldavs._tcp       IN TXT     "path=/SOGo/dav/"

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

Add created public key to the `dkim._domiankey` DNS record:

::

    # Name              Type       Value
    dkim._domainkey     IN TXT     v=DKIM1; k=rsa; t=s; s=email; p=DKIM YOUROWNKEY