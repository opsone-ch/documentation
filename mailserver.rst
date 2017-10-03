Mail Server
===========

We offer a mail server based on Postfix, Dovecot and SOGo Groupware. Our mail server is 24x7 monitored and regularly backed up.

Add a new customer
------------------

A new domain and mailbox can simply added with a webui. All you ned is a administrator user for mailcow and the possibility to edit your dns settings (for mx-record).

Add new domain
~~~~~~~~~~~~~~

1. open mail.example.com and login to Mailcow as administrator
2. klick on ``Configuration (top right) -> Mailboxes -> Add domain`` and fill in your new domain name
3. restart SOGo after adding a new domain, klick on ``Restart SOGo`` in the upper right corner

.. image:: ../_static/create_domain.gif
   :width: 907px
   :height: 573px
   :scale: 100 %
   :alt: add new domain
   :align: left

Add new mailboxes
~~~~~~~~~~~~~~~~~

1. open mail.example.com and login to Mailcow as administrator
2. klick on ``Configuration (top right) -> Mailboxes -> Mailboxes (tab) -> Add mailbox`` and fill in your desired Username, Full name and Password.

.. image:: ../_static/create_mailbox.gif
   :width: 907px
   :height: 573px
   :scale: 100 %
   :alt: add new mailbox
   :align: left

The new user can now login via webmail.example.com.

DNS configuration
-----------------

The following DNS entries for your customer domain are required.

::

    # Name              Type       Value
    @                   IN MX 10   mail.example.com

- The mx-record is necessary so that the server can also receive email.

The following DNS entries are highly recommended.

::

    # Name              Type       Value
    @                   IN TXT     "v=spf1 a mx ptr -all"

- Good secured mail services will discard mails sent from hosts which are not particularly allowed to, eventhough the default behaviour is to accept every mail. To explicitly allow our mailserver to send mails from your domain you need to add an SPF record to your DNS zone. Please make sure to include all other servers that should be able to send mails from your domain

The following DNS entries are recommended.

::

    # Name              Type       Value
    dkim._domainkey     IN TXT     "v=DKIM1; k=rsa; t=s; s=email; p=DKIM YOUROWNKEY"

DKIM is an email authentication method designed to detect email spoofing. You can generate a public key in the web interface from mailcow. Use the following settings.

::

    Domain: example.com
    Selector: dkim
    DKIM key length: 2048 bits

.. image:: ../_static/create_dkim.gif
   :width: 907px
   :height: 573px
   :scale: 100 %
   :alt: create dkim key
   :align: left

Client configuration
--------------------

Our mailservice support IMAP, POP3, SMTP and ActiveSync and has also a Webmail.

::

    # Typ           # Server hostname      # Port    # SSL       # Authentication
    IMAP            mail.example.com       993       SSL/TLS     Normal password
    POP3            mail.example.com       995       SSL/TLS     Normal password
    SMTP            mail.example.com       465       SSL/TLS     Normal password
    ActiveSync      mail.example.com       auto      auto        auto

Webmail: webmail.example.com

Thunderbird
~~~~~~~~~~~

For Mozilla Thunderbird use the following configuration.

.. image:: ../_static/thunderbird_configuration.png
   :width: 892px
   :height: 484px
   :scale: 100 %
   :alt: mozilla thunderbird configuration
   :align: left

Microsoft Outlook
~~~~~~~~~~~~~~~~~

For Microsoft Outlook use the following configuration.

.. image:: ../_static/outlook_configuration.png
   :width: 817px
   :height: 490px
   :scale: 100 %
   :alt: outlook configuration
   :align: left

Backup
------

The entire server will backed up one a day. The backup is stored safe in a different location.

Emails
~~~~~~

Current e-mails and folders can be viewed under ``/var/lib/docker/volumes/mailcowdockerized_vmail-vol-1/_data/``.
Each email is stored in a single file and can be drag & drop as required. This also applies to all folders.

Backups are managed with the BackupPC tool.
If you want to restore backups on your own, we can set up an account for you.

Contacts and calendars
~~~~~~~~~~~~~~~~~~~~~~

Under ``/user/mailcow/backup`` there is a current database dump.
This is overwritten every evening at 9 p. m. and then copied also to our backup server.

The database dump is compressed with lzop and can be decompressed with ``lzop -d mailcow.sql.lzo``.

Other options
-------------

Subaddressing
~~~~~~~~~~~~~

Mialcow support email tagging trough a plus indicator. The user `john@example.com` will also receiver email for `john+facebook@example.com` or `john+support@example.com` or so on. Thins option can be configured in the Mailcow user-settings.

1. open mail.example.com and login to mailcow with your mailbox user (not as administrator)
2. her you can set "Set handling for tagged mail" to "In Subfolder" or "In subject"

* In subfolder: a new subfolder named after the tag will be created below INBOX ("INBOX/facebook").
* In subject: the tags name will be prepended to the mails subject, example: "[facebook] mail subject".

Filter rules
~~~~~~~~~~~~

Server side filter rules for your mailbox can found in the SOGo settings.

1. open webmail.example.com an login to SOGo with your mailbox user
2. klick the sittings-ico to the right of your name
3. configure your filter under "E-Mail > Filter"

Please note: Active filter must be checked with a green pick. Also save your settings with the save-icon top right.

Create domain administrators
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You can create a separate domain administrator account for each domain.

1. open mail.example.com and login to Mailcow as administrator
2. klick on ``access`` and scroll down
3. klick on ``Add domain administrator`` and fill in your information.
