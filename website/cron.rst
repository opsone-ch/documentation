.. index::
   triple: Website; Cron; Cronjobs
   :name: website-cron

====
Cron
====

.. index::
   triple: Website; Cron; Custom Cronjob
   :name: website-cron_custom

Custom Cronjobs
===============

To configure your own jobs, use teh ``crontab -e`` command. We provide
a template including all required configuration which will be loaded
by default.

.. index::
   triple: Website; Cron; Type Related Cronjob
   :name: website-cron_type

Type Related Cronjobs
=====================

Application specific cronjobs are predefined when you use the according
type (see your type in :ref:`website-type_application`).

To disable the type related cronjob, set ``type_cronjob`` to ``false``
within the `Custom JSON` :ref:`customjson_website`:

.. code-block:: json

   {
     "type_cronjob": false
   }

The default interval for type related cronjobs is set to 15 minutes.
To adjust this value you can set ``type_cronjob_interval`` to a
different value within the `Custom JSON` :ref:`customjson_website`:

.. code-block:: json

   {
     "type_cronjob_interval": 5
   }

Or global within the `Custom JSON` :ref:`customjson_server`:

.. code-block:: json

   {
     "website::type_cronjob_interval": 5
   }