.. index::
   triple: How-to; Log; File
   :name: howto-logfile

=================
Log File Analysis
=================

To analyze log files, we installed to :ref:`howto-logfile_goaccess`
and :ref:`howto-logfile_lnav` utilities:

* :ref:`howto-logfile_goaccess` is used to analyze webserver log files
* :ref:`howto-logfile_lnav` is used to analyze webserver as well as system log files

.. index::
   triple: How-to; Log; GoAccess
   :name: howto-logfile_goaccess

GoAccess
========

To analyze webserver log files, use ``goaccess``:

.. code-block:: bash

   goaccess ~/log/access.log

.. index::
   triple: How-to; Log; Log File Navigator
   :name: howto-logfile_lnav

Log File Navigator
==================

To analyze webserver as well as system log files, use ``lnav``:

.. code-block:: bash

   # all webserver log files
   lnav ~/log/

   # all system logs
   lnav /var/log/

   # system syslog (cron etc.)
   lnav /var/log/syslog

   # system daemon (PHP, Docker, Node etc.)
   lnav /var/log/daemon

   # system messags (firewall etc.)
   lnav /var/log/messages

.. tip::

   To access system log files within ``/var/log/``, use the :ref:`access_devop`.

