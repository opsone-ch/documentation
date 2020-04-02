.. index::
   pair: Website; Context
   :name: website-context

=======
Context
=======

You have to select one of those contexts for each website:

PROD
====

The `PROD` context is meant for live websites. Its default presets are:

* access protection disabled
* phpinfo disabled (visible database credentials from environment variables)
* E-Mails are sent to their designated recipient (PHP ``mail()`` only, see :ref:`howto-email` for details)
* ``WEBSITE_CONTEXT`` environment variable set to ``PROD`` (see :ref:`website-envvar`)

STAGE
=====

The `STAGE` context is meant for test websites. Its default presets are:

* access protection enabled (see :ref:`website-advanced-previewuser`)
* phpinfo enabled
* E-Mails are saved as file into the ``~/tmp/`` directory (PHP ``mail()`` only, :ref:`howto-email` for details)
* ``WEBSITE_CONTEXT`` environment variable set to ``STAGE`` (see :ref:`website-envvar`)

DEV
===

The `DEV` context is meant for developing websites. Its default presets are:

* access protection enabled (see :ref:`website-advanced-previewuser`)
* phpinfo enabled
* Xdebug enabled (see :ref:`howto-phpdebugging` for details)
* E-Mails are saved as file into the ``~/tmp/`` directory (PHP ``mail()`` only, :ref:`howto-email` for details)
* ``WEBSITE_CONTEXT`` environment variable set to ``DEV`` (see :ref:`website-envvar`)

