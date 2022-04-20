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

.. index::
   triple: Website; Monitoring; SLA
   :name: website-monitoring_sla

* `Enable Monitoring`: When enabled, our automatic monitoring system
  will check the websites HTTP status 24/7. Without a SLA, manual
  notifications are available during office hours only.
* `SLA`: When enabled, we are notified 24/7 about any outages and
  will take appropriate measures to mitigate. We recommend this option
  for all production environments.

