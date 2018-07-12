FAQ
===

Storage location
----------------

Current e-mails and folders can be viewed under ``/var/lib/docker/volumes/mailcowdockerized_vmail-vol-1/_data/``.
Each email is stored in a single file and can be drag & drop as required. This also applies to all folders.

Configuration, contacts and calendars are stored within a MySQL database, which is dumped to ``/home/mailcowproxy/backup/`` daily.

Subaddressing
-------------

Email subaddressing trough the plus indicator is supported: The user `john@example.com` will also receive email for `john+newsletter@example.com`, `john+support@example.com` and so on. This option can be configured within the user settings.

1. open mail.example.com and login with your mailbox user (not as administrator)
2. set "Set handling for tagged mail" to "In Subfolder" or "In subject"

* In subfolder: a new subfolder named after the tag will be created below INBOX ("INBOX/newsletter").
* In subject: the tags name will be prepended to the mails subject, example: "[newsletter] mail subject".

Filter Rules
------------

Server side filter rules for your mailbox can be configured within SOGo settings:

1. open webmail.example.com an login to SOGo with your mailbox user
2. configure your filters in "Settings > E-Mail > Filter"

.. note:: Active filters must be checked with a green pick. Modifications must be saved with the save icon

Spam to Inbox
-------------

Spam end up in junk folder by default. You can change this behavior.

Create a filter in SOGo with the following options.

::

    For incoming messages that match all of the following rules:
    Header X-Spam-Flag contains YES

    Perform these actions:
    Flag the message with Junk
    File the message in INBOX
    Stop pricessing filter rules
