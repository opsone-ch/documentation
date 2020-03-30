Context Based E-Mail Handling
=============================

.. hint:: This info applies to PHP based installations who do not alter the `sendmail_path` setting only.

Depending on the selected context, e-mails get either sent to their designated recipient, or get saved into the users ``~/tmp/``
directory. This prevents you from accidental deliveries within non-PROD contexts.

Environments
------------

-  on websites with the "PROD" context setting, e-mails are delivered directly trough our SMTP cluster
-  on websites with the "STAGE" or "DEV" context setting, e-mails are saved as file into the ~/tmp/ directory

Analyze e-mails saved as file
-----------------------------

Within all "STAGE" and "DEV" contexts, e-mails are saved
as file into the ~/tmp/ directory. The file name used is
"mail.%Y-%m-%d\_%H-%M-%S..eml". You can access those e-mails trough
different means:

Shell
~~~~~

::

    $ cat ../tmp/mail.2015-06-26_10-11-06.ZuQ.eml 
    To: box@example.net
    Subject: test
    X-PHP-Originating-Script: 0:test.php

    Hi there, this is the content.

Hint: Instead of ``cat``, use other commands like ``less`` or ``vi`` to
analyze more complex e-mails

E-Mail client
~~~~~~~~~~~~~

To analyze more complex e-mails, or even check things like HTML
rendering, it is more feasible to open those e-mails within the client
application of your choice. You can either copy the file to your local
workstation, or just forward the whole e-mail to a given e-mail address.

Copy file
^^^^^^^^^

Copy the desired file(s) (e.g. ``mail.2015-06-26_10-11-06.ZuQ.eml``) to
your local workstation. Use your desired client such as Thunderbird to
open this file directly.

Forward e-mail
^^^^^^^^^^^^^^

To forward a saved e-mail 1:1 (To, Cc, and Bcc within the file are
evaluated), use the following command:

::

    $ cat ~/tmp/mail.2015-06-26_10-11-06.ZuQ.eml | mail -t

To forward a saved e-mail to another recipient, use the following
command:

::

    $ cat ~/tmp/mail.2015-06-26_10-11-06.ZuQ.eml | mail -ta To:box@example.net
