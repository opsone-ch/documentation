WebUI
=====

Administrator Access
--------------------

There is an administrator user which can be used under ``mail.example.com``.
But you are free to create as many additional administrators as you like.

We recommend so set 2FA for all administrator accounts.

Domain Administrators
---------------------

You can create a separate domain administrator to delegate access for certain domains:

1. open ``mail.example.com`` and login as administrator
2. select ``access`` and scroll down
3. select ``Add domain administrator``

Add Domain
----------

1. navigate to ``Configuration (top right)`` -> ``Mailboxes`` -> ``Add domain`` and fill in your domain name
2. add the new domain with ``Add domain`` (a SOGo restart is necessary if you use SOGo as webmail)

.. image:: ../_static/create_domain.gif
   :width: 100%
   :alt: add new domain
   :align: left

Add Mailbox
-----------

1. navigate to ``Configuration`` (top right) -> ``Mailboxes`` -> ``Mailboxes`` (tab) -> ``Add mailbox`` and fill in your desired username and password
2. save your settings with the ``Add``-Button

.. image:: ../_static/create_mailbox.gif
   :width: 100%
   :alt: add new mailbox
   :align: left

The new user can now

* login to webmail (SOGo or Roundcube, you find a link to your webmail on ``mail.example.com``)
* login to ``mail.example.com`` to adjust certain settings (Spam filter, Sync jobs)
* access his mails in a mailclient like thunderbird or outlook with `IMAP/SMTP <client.html>`__

Sync Jobs
---------

You can import your old email with a Sync Job.

1. Navigate to ``Configuration`` (top right) -> ``Mailboxes`` -> ``Mailboxes`` (tab) -> ``Sync Jobs``
2. Create a new sync job with your settings
3. A sync job remains until you delete it. Remember to delete the sync job if you no longer need it.