.. index::
   triple: Website; WAF; Web Application Firewall
   :name: website-waf

========================
Web Application Firewall
========================

We use `ModSecurity <https://modsecurity.org>`__ as additional protection against
application level attacks such as cross site-scripting and SQL injections.
By default, the core rules set will be loaded, and we block common vulnerabilities
and zero day attacks by adding some more global rules.

Identify Blocks
===============

When a request was blocked by the web application firewall, the HTTP status
will be returned. To distinguish a 403 returned by the web application
firewall from a 403 returned due to missing access rights, we add a custom
error text to the web application firewall errors:

   Request has been blocked by the Web Application Firewall.

If available, not the debug infos sent to the client to identify the request
within the available log files:

nginx Error Log
---------------

For each blocked reqeust, there are detailed informations available in the error log file

::

    YYYY/MM/DD HH:MM:SS [error] 171896#0: *29428 [client 2a04:500::1] ModSecurity: Access denied with code 403 (phase 2). Matched "Operator `Ge' with parameter `5' against variable `TX:ANOMALY_SCORE' (Value: `5' ) [file "/etc/nginx/modsecurity/crs/rules/REQUEST-949-BLOCKING-EVALUATION.conf"] [line "80"] [id "949110"] [rev ""] [msg "Inbound Anomaly Score Exceeded (Total Score: 5)"] [data ""] [severity "2"] [ver ""] [maturity "0"] [accuracy "0"] [tag "application-multi"] [tag "language-multi"] [tag "platform-multi"] [tag "attack-generic"] [hostname "2a04:500::1"] [uri "/"] [unique_id "154850909196.529239"] [ref ""], client: 2a04:500::1, server: example.net, request: "GET /?union%20select=%22waf%20demo HTTP/2.0", host: "example.net"

.. hint:: For details, see the `ModSecurity documentation <https://github.com/SpiderLabs/ModSecurity/wiki>`__.

ModSecurity Audit Log
---------------------

More detailed informations including a full dump of the request and response
can be obtained from the audit log file. It is located in
``/var/log/nginx/modsecurity.log`` and readable by the :ref:`access_devop`.

Custom Configuration
====================

The rules added by us and the core rules set are there for a reason and do comply with
the HTTP RFC. Even though, it can be required to adapt the rules instead of changing
your application.

You can configure the rules in the :ref:`website-advanced-nginx_website` nginx configuration
in located ``~/cnf/nginx.conf``:

::

    # disable blocking triggered requests but still detect and log them
    modsecurity_rules 'SecRuleEngine DetectionOnly';

    # disable certain rule
    modsecurity_rules 'SecRuleRemoveById 90001';

    # add custom rule
    modsecurity_rules 'SecRule "ARGS_NAMES|ARGS" "@contains blocked-value" "deny,msg:blocled,id:91001,chain"'

.. tip:: To apply the changes reload the nginx configuration with the ``nginx-reload`` shortcut.

.. tip:: For details, see the `ModSecurity documentation <https://github.com/SpiderLabs/ModSecurity/wiki>`__.

Disable Altogether
==================

If you cannot adapt the rules to your need, it is possible to disable the web application altogether
by enabling `Disable WAF` in the corresponing websites `Advanced` tab.

.. warning::

   We do not recommend to disable the web application firewall.

