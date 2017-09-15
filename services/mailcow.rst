mailcow
=======

Mailcow installation are maintained by us.

DNS entries
-----------

The following DNS entries are required.

::

    # Name              Type       Value
    mail                IN A       1.2.3.4
    mail                IN AAAA    123:123:123:123
    webmail             IN A       1.2.3.4
    webmail             IN AAAA    123:123:123:123
    autodiscover        IN CNAME   mail.example.tld
    autoconfig          IN CNAME   mail.example.tld
    @                   IN MX 10   mail.example.tld

SPF Record
~~~~~~~~~~

Good secured mail services will discard mails sent from hosts which are
not particularly allowed to, eventhough the default behaviour is to
accept every mail. To explicitly allow our mailcow instance to send mails from
your domain you need to add an SPF record to your DNS zone.

::

    @                   IN TXT     "v=spf1 a mx ptr ~all"

.. warning:: Please make sure to include all other servers that should be able to send mails from your domain

DKIM
~~~~

DKIM is an email authentication method designed to detect email spoofing.

::

    dkim._domainkey     IN TXT     "v=DKIM1; k=rsa; t=s; s=email; p=YOURKEY"

Web interface
-------------

All relevant settings can be made in the Mailcow web interface. The web interface can be found at your ``mail.``-subdomain.

Add Domain and Mailboxes
~~~~~~~~~~~~~~~~~~~~~~~~

New domains and mailboxes can be addes under ``Configuration -> Mailboxes``.

Important: You will need to restart SOGo after adding a new domain!

Client configuration
--------------------

E-mail clients with autoconfig support find the settings automatically (example: Mozilla Thunderbird).

::

    # Typ     # Server hostname      # Port    # SSL       # Authentication
    IMAP      mail.yourdomain.tld    993       SSL/TLS     Normal password
    POP3      mail.yourdomain.tld    995       SSL/TLS     Normal password
    SMTP      mail.yourdomain.tld    465       SSL/TLS     Normal password
