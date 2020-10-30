.. index::
   single: Diskspace
   :name: diskspace

=========
Diskspace
=========

We monitor the diskspace and inform you as soon you are using more diskspace than you have chosen in the cockpit.
You are most likely reading this page because you have received a diskspace notification.
Here you can find information about what this means.

Tools
=====

You can run these tools by login with the devop user (see :ref:`access_devop`).

* ``diskusage``: Starts `ncdu <https://en.wikipedia.org/wiki/Ncdu>`__, a disk space utility with which you can find large files or directories.
* ``df -h /``: The value in the used column must be below the value set in the cockpit.
* You can also see the consumption in percent on the SSH console (example: ``disk:110%``)

FAQ
===

Which data belong to my diskspace?
----------------------------------

All data stored on the disk.

* This includes all data you see with ``diskusage``. This contains your web project, your databases, your docker containers, the underlying Linux and all other data stored on the same disk.
* The daily snapshots are also counted among your diskspace. The snapshots are not displayed in ``diskusage``.

How much storage space do the daily snapshots use?
--------------------------------------------------

It is not possible to show how much disk space a single snapshot use,
which is due to the way how copy on write and deduplication in Btrfs works.
For the daily file system snapshots (see :ref:`backup`) only the changed data occupies storage.
Depending on the use of the server, the consumption therefore varies.

* However, you can calculate the consumption of all snapshots by subtracting the total of ``diskusage`` fom the used value of ``df -h /``.
* Assuming you change 1GB of data every day, the daily snapshots then need 1GB (1GB x 30 days = 30GB in a month).

I have deleted many files, but the discusage has not changed
------------------------------------------------------------

All files you have deleted are still referenced in the snapshots and therefore still occupy disk space.
By default, snapshots are kept for 30 days. So the diskusage of deleted files are taken in account in 30 days.

Can I delete snapshots?
-----------------------

No. In most cases it would not help much either.

The cleaned up or deleted files are in most cases older than 30 days and therefore referenced in all snapshots.
So we would have to delete all snapshots, which also affects the backup (see :ref:`backup`).
We recommend adjusting the diskspace in the cockpit and checking it again in 30 days.

Can I overbook the diskusage?
-----------------------------

We have reserves that serve as buffers. This prevents the server from overflowing if you reach your allowed diskusage.
However, these reserves are not intended for deliberate temporary use. Please increase the diskspace in the cockpit if you need more diskspace.

We therefore reserve the right to increase storage space automatically if the reserve is used up or if you not responding within the deadline to our diskspace notification.