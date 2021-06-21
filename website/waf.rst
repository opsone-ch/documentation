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

If a request was blocked by the web application firewall, the HTTP status 419
will be returned. To distinguish a 403 returned by the web application firewall
from a 403 returned due to missing access rights, we add a custom error text
to the web application firewall errors:

   Request has been blocked by the Web Application Firewall.

If available, note the debug infos sent to the client to identify the request
within the available log files:

nginx Error Log
---------------

For each blocked reqeust, there are informations available in the error log file.
Often, as in this example, it is the rule `949110`. But this rule implements only
a threshold for the anomaly score, and if this threshold is exceeded,
it blocks the request. To determine which rule triggered this
anomaly score threshold see the Audit Log in the next chapter.

::

    YYYY/MM/DD HH:MM:SS [error] 82748#0: *4827 [client 2a04:500::1] ModSecurity: Access denied with code 419 (phase 2). Matched "Operator `Ge' with parameter `5' against variable `TX:ANOMALY_SCORE' (Value: `5' ) [file "/etc/nginx/modsecurity/crs/rules/REQUEST-949-BLOCKING-EVALUATION.conf"] [line "79"] [id "949110"] [rev ""] [msg "Inbound Anomaly Score Exceeded (Total Score: 5)"] [data ""] [severity "2"] [ver ""] [maturity "0"] [accuracy "0"] [tag "application-multi"] [tag "language-multi"] [tag "platform-multi"] [tag "attack-generic"] [hostname "2a04:500::1"] [uri "/"] [unique_id "1c3a50612025bc2b8c14a0c42006c8d1"] [ref ""], client: 2a04:500::1, server: example.net, request: "GET /?union%20select=%22waf%20demo HTTP/2.0", host: "example.net"

.. tip:: For details, see the `ModSecurity documentation <https://github.com/SpiderLabs/ModSecurity/wiki>`__.

ModSecurity Audit Log
---------------------

More detailed informations including a full dump of the request and response
can be obtained from the audit log file. It is located in
``/var/log/nginx/modsecurity.log`` and readable by the :ref:`access_devop`.

.. tip:: For an easier representation and identification of the blocking WAF rules, the command ``modsecurity-logparser`` can be used as devop user (see :ref:`access_devop`).

To extend the above example, such a log entry would include a section H
(more about the sections could be found in the
`offical documentation <https://github.com/SpiderLabs/ModSecurity/wiki/Reference-Manual-(v2.x)#user-content-secauditlogparts>`__)
and would look similar to the following. The first line in this section
``ModSecurity: Warning. Matched "Operator `Rx'...``, is the rule that triggered
the Anomaly Score Threshold. Now that you know which rule, arguments, or values
caused your request to be blocked, you can modify the rule to allow your request
or modify your application accordingly.

::

   ... snip ...

   ---18UxSXmW---H--
   ModSecurity: Warning. Matched "Operator `Rx' with parameter `(?i:(?:[\"'`](?:;?\s*?(?:having|select|union)\b\s*?[^\s]|\s*?!\s*?[\"'`\w])|(?:c(?:onnection_id|urrent_user)|database)\s*?\([^\)]*?|u(?:nion(?:[\w(\s]*?select| select @)|ser\s*?\([^\)]*?)|s(?:chema\s* (165 characters omitted)' against variable `ARGS_NAMES:union select' (Value: `union select' ) [file "/etc/nginx/modsecurity/crs/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf"] [line "169"] [id "942190"] [rev ""] [msg "Detects MSSQL code execution and information gathering attempts"] [data "Matched Data: union select found within ARGS_NAMES:union select: union select"] [severity "2"] [ver "OWASP_CRS/3.2.0"] [maturity "0"] [accuracy "0"] [tag "application-multi"] [tag "language-multi"] [tag "platform-multi"] [tag "attack-sqli"] [tag "OWASP_CRS"] [tag "OWASP_CRS/WEB_ATTACK/SQL_INJECTION"] [tag "WASCTC/WASC-19"] [tag "OWASP_TOP_10/A1"] [tag "OWASP_AppSensor/CIE1"] [tag "PCI/6.5.2"] [hostname "2a04:503:0:1014::103"] [uri "/"] [unique_id "1c3a50612025bc2b8c14a0c42006c8d1"] [ref "o0,12v6,12t:urlDecodeUni"]
   ModSecurity: Access denied with code 200 (phase 2). Matched "Operator `Ge' with parameter `5' against variable `TX:ANOMALY_SCORE' (Value: `5' ) [file "/etc/nginx/modsecurity/crs/rules/REQUEST-949-BLOCKING-EVALUATION.conf"] [line "79"] [id "949110"] [rev ""] [msg "Inbound Anomaly Score Exceeded (Total Score: 5)"] [data ""] [severity "2"] [ver ""] [maturity "0"] [accuracy "0"] [tag "application-multi"] [tag "language-multi"] [tag "platform-multi"] [tag "attack-generic"] [hostname "2a04:503:0:1014::103"] [uri "/"] [unique_id "1c3a50612025bc2b8c14a0c42006c8d1"] [ref ""]

   ... snip ...


Custom Configuration
====================

The rules added by us and the core rules set are there for a reason and do comply with
the HTTP RFC. Even though, it can be required to adapt the rules instead of changing
your application.

We recommend making adjustments to these rules as precise as possible. For example,
instead of disabling a rule completely, disable checking of the argument that triggered
the rule for the URL on which it was triggered.

You can configure the rules in the :ref:`website-advanced-nginx_website` nginx configuration
in located ``~/cnf/nginx.conf``:

::

    # disable blocking triggered requests but still detect and log them
    modsecurity_rules 'SecRuleEngine DetectionOnly';

   # disable checking of a specific argument
   modsecurity_rules 'SecRule REQUEST_FILENAME "@beginsWith /bad/request" \
       "phase:2,nolog,pass,id:1,ctl:ruleRemoveTargetById=933160;ARGS:fields"';

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

