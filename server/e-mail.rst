E-Mail
======

On each server, a local Postfix instance is running to deliver mails to their destination.

SPF Record
----------

To explicitly allow your server to send mails from a particular domain,
you need to add an SPF record to your DNS zone:

::

    example.com.              3600     IN      TXT     "v=spf1 mx a:<fqdn-or-smarthost> -all"

.. note:: depending on your companys guideline, servers can send mails directly or through a designated smarthost

.. warning:: please make sure to include all other servers that should be able to send mails from your domain as well

Configuration
-------------

.. warning:: changing any values can led to unintended consequences. Please make sure to plan any changes carefully and ask us for advice if you're in doubt

mynetworks
~~~~~~~~~~

* list of trusted remote SMTP clients that have more privileges than strangers
* see the `Postfix documentation <http://www.postfix.org/postconf.5.html#mynetworks>`__ for details
* default: ``127.0.0.0/8 [::1]/128``

relayhost
~~~~~~~~~

* next-hop destination of non-local mail
* see the `Postfix documentation <http://www.postfix.org/postconf.5.html#relayhost>`__ for details
* default: empty

smtp_fallback_relay
~~~~~~~~~~~~~~~~~~~

* optional list of relay hosts for SMTP destinations that can't be found or that are unreachable
* see the `Postfix documentation <http://www.postfix.org/postconf.5.html#smtp_fallback_relay>`__ for details
* default: empty

inet_interfaces
~~~~~~~~~~~~~~~~~~~

* network interface addresses that this mail system receives mail on
* see the `Postfix documentation <http://www.postfix.org/postconf.5.html#inet_interfaces>`__ for details
* default: ``loopback-only`` (localhost Port 25)

message_size_limit
~~~~~~~~~~~~~~~~~~~

* the maximal size in bytes of a message, including envelope information
* see the `Postfix documentation <http://www.postfix.org/postconf.5.html#message_size_limit>`__ for details
* default: ``25600000`` (25MB)

monitoring
~~~~~~~~~~

* whether our external monitoring will check the condition of the mail service on this particular server
* default: true

smtpd_tls_cert_file
~~~~~~~~~~~~~~~~~~~

* path to a TLS certificate used for incoming SMTP connections
* default: empty

smtpd_tls_key_file
~~~~~~~~~~~~~~~~~~~

* path to a TLS key used for incoming SMTP connections
* default: empty

