.. index::
   pair: Website; Monitoring
   :name: website-monitoring

====================
Monitoring (Website)
====================

.. tip::

   This page covers all aspects regarding the monitoring of a individual
   website. For informations about monitoring on the server level, see
   :ref:`monitoring`.

You can enable the monitoring of individual websites individually on
all sites bearing the `PROD` :ref:`website-context`. The configuration
is available on the desired websites `Monitoring` tab.

At the moment, the following options are available:

* `Host`: hostname used to check your website, either
  `[AUTO_FIRST_HOST]` to let the system determine the first host
  name configured in `Server name`, or a certain host name of your
  website.
* `Path`: path used to check your website. At the moment, only ``/``
  is available.
* `Oncall`: When enabled, we are notified 24/7 about any outages and
  will take appropriate measures to mitigate.

