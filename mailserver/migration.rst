Migration
=========

Necessary steps for a mailserver migration:

1. Change the TTL of the existing MX record to 5 minutes or less.
2. `Create all new mailboxes. <webui.html>`__
3. `Change MX record to new one. <dns.html>`__
4. Migrate your emails manually with IMAP or with a `Sync Job <webui.html#sync-jobs>`__.

.. note:: Depending on how high the old TTL entry was, we recommend waiting one day between steps one and three.

.. warning:: Local delivery: E-mails from the mail server to another domain, which are also created on the same mail server, are delivered locally. Even if the mail server is not yet in use by the recipient.
