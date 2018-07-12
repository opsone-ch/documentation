Client Configuration
====================

Our mailservers support IMAP, POP3, SMTP, ActiveSync, CalDAV, CardDAV and webmail access. You can find your webmail at webmail.example.com.

::

    # Typ           # Server hostname      # Port    # SSL       # Authentication
    IMAP            mail.example.com       993       SSL/TLS     Normal password
    POP3            mail.example.com       995       SSL/TLS     Normal password
    SMTP            mail.example.com       465       SSL/TLS     Normal password
    ActiveSync      mail.example.com       auto      auto        auto

.. note:: ActiveSync is not a complete Microsoft Exchange replacement. We recommend IMAP for most clients. ActiveSync can be useful for e.g. Android.

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