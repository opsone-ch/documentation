.. index::
   pair: How-to; FAQ
   :name: howto-faq

===
FAQ
===

Which log files are available
-----------------------------

Within a website, the following log files are available

-  ``~/log/access.log``
-  each request to the website is logged here
-  ``~/log/error.log``
-  errors within the webserver
-  for example files which are not found
-  ``~/log/php-error.log``
-  errors within PHP
-  for example memory limits
-  ``~/log/php-mail.log``
-  log for mails sent by PHP
-  ``~/log/php-slow.log``
-  PHP requests which took longer than 10 seconds to process

Monitor log files
-----------------

-  ``tail <filename`` to get the last 10 lines
-  ``tail -f <filename>`` to get a steady output (finish with Ctrl + C)
-  ``cat <filename>`` to get the whole file in one part
-  ``less <filename>`` to get the whole file in a search- and scrollable
   fashion

Show MySQL processes
--------------------

-  open ``mysql``
-  issue the ``SHOW PROCESSLIST;`` command

HTTP status codes
-----------------

-  403 forbidden
-  WAF block or access denied due to ip address/user restriction
-  see the webserver error log for details
-  500 internal server error
-  Backend error, for example within PHP
-  check the application error log file (in case of PHP:
   ``~/log/php-error.log``)

Hint: For details, see the full `List of HTTP status
codes <https://en.wikipedia.org/wiki/List_of_HTTP_status_codes>`__ on
Wikipedia.

Sent mails are lost
-------------------

-  check the application level log file (in case of PHP:
   ``~/log/php-mail.log``)
-  check the system level log file (``/var/log/mail.info``, access
   trough Log Server only)

