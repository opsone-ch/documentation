.. index::
   pair: Backup; Snapshot
   :name: backup

======
Backup
======

* all our servers do their own, snapshot based backup once a day
* the full disk including all snapshots is mirrored to another location once a day
* the number of backups and their size is not limited, however the diskspace used
  for all your files and backups is taken into account to charge your storage

Configuration
=============

* a snapshot is created once a day and kept for 30 days

.. tip::

   As of now, we do not document the required configurations settings to change this
   values. Please contact us if you have other needs.

Restore
=======

* all available snapshots are mounted ready-only in ``/snapshots/``
* for easy access, we symlink the home of each user for each snapshot
  within the users ``~/backup/`` directory
* you can access them directly according your system permissions


