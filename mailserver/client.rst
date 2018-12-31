Client Configuration
====================

Our mailservers support IMAP, POP3, SMTP, ActiveSync, CalDAV, CardDAV and webmail access. You can find your webmail at webmail.example.com.

::

    # Typ           # Server hostname      # Port    # Encryption  # Authentication
    IMAP            mail.example.com       143       STARTTLS      Normal password / Plain
    IMAPS           mail.example.com       993       SSL           Normal password / Plain
    POP3            mail.example.com       110       STARTTLS      Normal password / Plain
    POP3S           mail.example.com       995       SSL           Normal password / Plain
    SMTP            mail.example.com       587       STARTTLS      Normal password / Plain
    SMTPS           mail.example.com       465       SSL/TLS       Normal password / Plain
    ActiveSync      mail.example.com       auto      auto          auto

.. note:: ActiveSync is not a complete Microsoft Exchange replacement. We recommend IMAP for most clients. ActiveSync can be useful for e.g. Android.

If your email client asks you for ``IMAP Path Prefix``, you can leave this value empty. All relevant folders are located directly in the root directory of the mailbox.

Mozilla Thunderbird
-------------------

.. image:: ../_static/thunderbird_configuration.png
   :width: 100%
   :alt: mozilla thunderbird configuration
   :align: left

Microsoft Outlook
-----------------

.. image:: ../_static/outlook_configuration.png
   :width: 100%
   :alt: outlook configuration
   :align: left

macOS Apple Mail
----------------

Email, contacts and calendar can be configured automatically by installing a profile.

1. Open mail.example.com and log in with your mailbox credentials (not with your admin account)
2. Click on "Show configuration guides for email clients and smartphones" and then choose "macOS"
3. There you can download a mobileconfig profile to setup your client