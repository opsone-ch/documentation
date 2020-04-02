.. index::
   single: Website
   :name: website

=======
Website
=======

To create a new website, there are only a few settings required:

* `name` will define the name used for system wide settings like users
  or databases (see :ref:`website-name`)
* `type` will define the preloaded settings for a certain application
  type (see :ref:`website-type`)
* `context` will define the context used within your application and
  is also used to set some default settings (see :ref:`website-context`)
* (optional) a `server name` when your website must listen to other
  hostnames than the default one

After creating, you can log into your newly created website by using
the websites name as SSH username (see :ref:`access-ssh`).

.. toctree::
   :caption: Settings
   :maxdepth: 2

   name
   type
   context
   limits
   envvar
   cron
   advanced/index

TLS Certificates
----------------

By adding a TLS certificate to your website, the following
configurations/features are applied to the vhost:

-  SPDY 3.1
-  TLS 1.0, 1.1, 1.2
-  SNI
-  HSTS
-  daily Expiration Date Check
-  daily `Qualys SSL Labs <https://www.ssllabs.com/>`__ API Check
-  global HTTP to HTTPS redirect

Let's Encrypt
^^^^^^^^^^^^^

We support free tls certificates by `Let's Encrypt <https://letsencrypt.org/>`__.
You can activate Letsencrypt for your website in the cockpit.
The certificates are automatically renewed 30 days before expiration.

Debug validation problems
~~~~~~~~~~~~~~~~~~~~~~~~~

In order to debug validation issues, we introduced the ``letsencrypt-renew`` shortcut which will trigger a run of our Let's Encrypt client, and let you see all debug output to identifiy possible problems.

- Make sure that all hosts added to ``Server name`` point to the correct server (A and AAAA DNS records).
- Let's Encrypt will try to reach your website at the endpoint ``/.well-known/acme-challenge/`` for validation purposes. Make sure that you do not overwrite this path within your `own nginx configuration <#custom-configuration>`__.
- You can check access to the validation directory by yourself by fetching the control file reachable at ``http://example.com/.well-known/acme-challenge/monitoring``

Renewal
~~~~~~~

Certificates from Let's Encrypt will be valid for 90 days. They are renewed automatically as soon as they expire in under 30 days. You can follow these checks and renewals by grep for ``letsencrypt`` in ``/var/log/syslog``.

Furthermore, we check all certificates from our monitoring and will contact you if there are certificates expiring in less than 21 days.

Export
~~~~~~

Existing Lets Encrypt certificates can be read with the `devop user <../server/access.html#generic-devop-user>`__.
This is useful if you want to temporarily use the old certificate on a new server (e.g. for a migration).

You can find your certificates under ``/etc/nginx/ssl``.

.. warning:: As soon as the certificates leave our servers, we no longer have control over them. Please be aware of this and be careful.

Order certificate
^^^^^^^^^^^^^^^^^

Requirements
^^^^^^^^^^^^

To validate domain ownership, our certificate issuer will send a E-Mail
to one of the following addresses:

-  webmaster@example.net
-  admin@example.net
-  administrator@example.net

Create certificate and key
^^^^^^^^^^^^^^^^^^^^^^^^^^

::

    $ openssl req -newkey rsa:4096 -x509 -nodes -days 3650 -out www.example.net.crt -keyout www.example.net.key
    Country Name (2 letter code) [AU]:CH
    State or Province Name (full name) [Some-State]:Luzern
    Locality Name (eg, city) []:Luzern
    Organization Name (eg, company) [Internet Widgits Pty Ltd]:example Ltd
    Organizational Unit Name (eg, section) []:
    Common Name (eg, YOUR name) []:www.example.net
    Email Address []:webmaster@example.net

Extract certificate signing request
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

    openssl x509 -x509toreq -signkey www.example.net.key -in www.example.net.crt

Submit this CSR to us for further processing, or order certificate by yourself from the issuer of your choice.

Configure website
^^^^^^^^^^^^^^^^^

-  SSL key: generated private key
-  SSL key: signed certificate, including appropriate intermediate
   certificates

Warning: Make sure the first ``Server name`` used is valid within your
certificate as we redirect all HTTP requests within this vHost to
``https://first-in-server_name``

HTTP redirect
^^^^^^^^^^^^^

By default, all HTTP requests within a given vHost are redirected to HTTPS keeping the hostname supplied by the client. If you want to change this behaviour somehow, for example by always redirect to the first hostname of the vhost, you can set ``http_redirect_dest`` to another value like ``https://$server_name$request_uri``.

Furthermore, its possible to set the redirect destination globally through ``website::http_redirect_dest`` which will be used on all HTTP redirects without a explicitly set ``http_redirect_dest``.


~/cnf/nginx-redirect.conf
~~~~~~~~~~~~~~~~~~~~~~~~~

Included within the server block of each HTTP to HTTPS redirect. You can use this file to configure specific redirect rules and settings.


Cipher Suite
^^^^^^^^^^^^

You can configure a desired cipher suite configuration trough `website::ssl_ciphers`:

.. code-block:: json

  {
    "website::ssl_ciphers": "desired-cipher-suites"
  }

.. warning:: We configure and update this value with sane defaults. Overwrite only when really required, and if you are aware of the consequences.


Diffie-Hellman parameters
^^^^^^^^^^^^^^^^^^^^^^^^^

Diffie-Hellman parameters are used for perfect forward secrecy. We supply default
Diffie-Hellman parameters and update them on a regular schedule. If you want to use
your own Diffie-Hellman parameters, you can generate them:

::

  openssl dhparam -out /tmp/dhparam.pem 4096

and configure them trough `website::ssl_dhparam`:

.. code-block:: json

  {
    "website::ssl_dhparam": "-----BEGIN DH PARAMETERS-----\nMIICCAKCAgEAoOePp+Uv2M34IA+basW9CBHp/jsZihB3FI8KVRLVFJPIUJ9Llm8F\n...\n-----END DH PARAMETERS-----"
  }

.. index::
   pair: Website; HSTS
   :name: website_hsts

HSTS Header
^^^^^^^^^^^

By default, we add a HTTP Strict Transport Security (HSTS) header to each TLS enabled website:

::

 Strict-Transport-Security max-age=63072000;

Use the `header_hsts` parameter to override the default HSTS header:

.. code-block:: json

  {
    "header_hsts": "max-age=3600; includeSubDomains; preload"
  }

.. hint:: See the OWASP `HTTP Strict Transport Security Cheat Sheet <https://www.owasp.org/index.php/HTTP_Strict_Transport_Security_Cheat_Sheet>`__ for details

Test
^^^^

We recommend the following online services for testing:

-  `Qualys SSL Labs <https://www.ssllabs.com/ssltest/>`__
-  `Symantec SSL
   Toolbox <https://ssltools.websecurity.symantec.com/checker/views/certCheck.jsp>`__

.. index::
   pair: Website; WAF; Web Application Firewall
   :name: website-waf

Web Application Firewall
------------------------

We use `ModSecurity <https://modsecurity.org>`__ as additional protection against application level attacks such as cross site-scripting or SQL injections.
By default, the core rules set will be loaded, and we block common vulnerabilities and zero day attacks by adding some more global rules.

.. warning:: this is just a additional security measure. Regardless its existence, remember to keep your application, extensions and libraries secure and up to date

.. hint:: keep up to date with changes by subscribing to our status uppdates at `opsstatus.ch <http://opsstatus.ch/>`__

Identify blocks
^^^^^^^^^^^^^^^

nginx error log
~~~~~~~~~~~~~~~

If a request is blocked, the server will issue a `403 forbidden` error. There are detailed informations available in the error log file:

::

    YYYY/MM/DD HH:MM:SS [error] 171896#0: *29428 [client 2a04:500::1] ModSecurity: Access denied with code 403 (phase 2). Matched "Operator `Ge' with parameter `5' against variable `TX:ANOMALY_SCORE' (Value: `5' ) [file "/etc/nginx/modsecurity/crs/rules/REQUEST-949-BLOCKING-EVALUATION.conf"] [line "80"] [id "949110"] [rev ""] [msg "Inbound Anomaly Score Exceeded (Total Score: 5)"] [data ""] [severity "2"] [ver ""] [maturity "0"] [accuracy "0"] [tag "application-multi"] [tag "language-multi"] [tag "platform-multi"] [tag "attack-generic"] [hostname "2a04:500::1"] [uri "/"] [unique_id "154850909196.529239"] [ref ""], client: 2a04:500::1, server: example.net, request: "GET /?union%20select=%22waf%20demo HTTP/2.0", host: "example.net"

.. hint:: for details, see the `ModSecurity documentation <https://github.com/SpiderLabs/ModSecurity/wiki>`__

modsecurity audit log
~~~~~~~~~~~~~~~~~~~~~

More detailed informations including a full dump of the request and response can be obtained from the audit log file.
You'll find this at ``/var/log/nginx/modsecurity.log``.

.. hint:: you cannot read ``/var/log/`` from within the web applications context for security reasons, please use the generic ``devop`` account to take a look at them

custom WAF configuration
^^^^^^^^^^^^^^^^^^^^^^^^

The rules added from the core rules set and the custom rules added by us are there for a reason.
If you trigger a false positive, you should think about changing your application first of all.
As this is not always possible or feasible, you can disable certain rules or even the whole WAF
through the local nginx configuration located in ``~/cnf/nginx.conf``:

::

    # disable blocking triggered requests but still detect and log them
    modsecurity_rules 'SecRuleEngine DetectionOnly';

    # disable WAF alltogether
    modsecurity_rules 'SecRuleEngine Off';

    # disable certain rule
    modsecurity_rules 'SecRuleRemoveById 90001';

    # add custom rule
    modsecurity_rules 'SecRule "ARGS_NAMES|ARGS" "@contains blocked-value" "deny,msg:blocled,id:91001,chain"'

.. hint:: to apply the changes reload the nginx configuration with the ``nginx-reload`` shortcut

.. hint:: for details, see the `ModSecurity documentation <https://github.com/SpiderLabs/ModSecurity/wiki>`__

Custom configuration
--------------------

node
^^^^

.. warning:: use only to enable node within another website type for actions like gulp. To run your own node based website, use the `nodejs`_ type

To execute custom node commands (for example gulp), add nvm (Node Version Manager) to any website by setting
the following custom JSON:

.. code-block:: json

    {
      "nvm": true
    }

By default, the latest node lts version will be installed, however you can also install and select any other version.

::

    $ nvm ls-remote
    $ nvm install <version>

.. hint:: see the `nvm readme <https://github.com/creationix/nvm#usage>`__ for details

security configuration
^^^^^^^^^^^^^^^^^^^^^^

Access to certain private files and directories like ``.git`` is forbidden by including the global ``/etc/nginx/custom/security.conf`` file within the vhost configuration.

This file also contains the following security headers:

* ``add_header X-Frame-Options "SAMEORIGIN" always;``
* ``add_header X-Content-Type-Options "nosniff" always;``
* ``add_header X-XSS-Protection "1; mode=block always";``
* ``add_header Referrer-Policy "strict-origin-when-cross-origin" always;``

You can disable this include by setting ``security_conf`` to ``false`` within the custom JSON configuration. If you disable this, we recommend to copy the content into your own nginx.conf and adjust it to your own needs (you can view the content with the devop user). Please be aware of any ramifications, and do not disable this
settings unless you absolutely know what you're doing.

.. warning:: make sure to deny access to private files and directories manually, or include our global security locations from ``/etc/nginx/custom/security.conf`` within your own configuration.

.. index::
   triple: Website; Listen; Port
   :name: website_listen

Listen
------

By default, nginx will bind to the primary IP address of the eth0
interface and the 80/443 port. You can specify listen options explicitly
per website, for example within setups where Varnish is used and the
nginx vhost does not have to listen on external interfaces.

.. code-block:: json

  {
    "website::sites": {
      "username": {
        "env": "PROD",
        "type": "php",
        "listen_ip": "127.0.0.1",
        "listen_port": "8080",
        "listen_options": "option_value",
        "ipv6_listen_ip": "::1",
        "ipv6_listen_port": "8080",
        "ipv6_listen_options": "option_value"
      }
    }
  }

.. hint:: If you set ``listen_options`` and ``ipv6_listen_options`` to ``default_server``, the corresponding web page becomes the default server and listens to every server name.

Monitoring
----------

All sites with ``"env": "PROD"`` are monitored 24/7 by default. If you
have some sites with frequent outages (e.g. for development purposes),
which have to have ``"env": "PROD"`` for other reasons, or sites which
are not reachable from everywhere due to security reasons, please
deactivate monitoring by setting ``"monitoring": "false"`` in custom JSON:

.. code-block:: json

    {
      "monitoring": false
    }

