.. index::
   pair: Website; Context
   :name: website_context

Context
=======

You have to select one of those contexts for each website:

PROD
^^^^

-  for live sites
-  no access protection
-  phpinfo disabled (visible database credentials from environment variables)
-  E-Mails get sent to their designated recipient (PHP mail() only, see :ref:`howto-email` for details)

.. hint:: You can enable phpinfo by setting ``disable_functions=`` to a empty string in ``~/cnf/php.ini`` (don’t forget ``php-reload``). Important: phpinfo exposed many infos like environment variables such as database credentials. We recommend not to use phpinfo on a publicly accessible website. Please be careful and deactivate phpinfo afterwards.

STAGE
^^^^^

-  for stage / preview / testing access
-  password protected (see :ref:`website-advanced-previewuser`)
-  phpinfo enabled
-  E-Mails get saved as file into the ~/tmp/ directory (PHP mail() only, :ref:`howto-email` for details)

DEV
^^^

-  for development
-  password protected (see :ref:`website-advanced-previewuser`)
-  phpinfo enabled
-  Xdebug enabled, see :ref:`howto-phpdebugging` for details)
-  E-Mails get saved as file into the ~/tmp/ directory (PHP mail() only, :ref:`howto-email` for details)

