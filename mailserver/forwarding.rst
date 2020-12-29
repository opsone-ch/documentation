Forwarding
==========

As Admin
--------

E-mail forwarding is not always that easy. SPF records can be broken,
and if an email is lost, it is not easy to debug where it got lost.
We therefore recommend not to use e-mail forwarding whenever possible.
If you still need a forwarding there are the following possibilities.

You can create Sieve filters as an administrator or domain administrator.
Forwardings created by Sieve filters are ARC-signed and the ``envelope-from`` header is rewritten accordingly.
This way, there are fewer problems with SPF.

1. Navigate to ``/mailbox``, then ``Filter``
2. Add a new filter with the following content:

::

  redirect "a@example.com";
  discard;

.. note:: For creating a forwarding you can also create an alias. However, the ``envelope-from`` header will be kept, which may cause problems with SPF. In our case, Postfix  `cannot perform SRS <https://github.com/mailcow/mailcow-dockerized/issues/2418>`__.

As Mailbox User
---------------

As a mailbox user you can create a forwarding within your webmail.
Technically, this also use sieve filters.

With SOGo:

1. Navigate to ``/SOGo``, then open settings
2. Click on ``Mail``, then ``Forward``
3. Create your forwarding here

With Roundcube:

1. Navigate to Roundcube, then open settings
2. Click on ``Filter``
3. Create your forwarding rule here