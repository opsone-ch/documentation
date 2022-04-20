.. index::
   twin: Managed Server
   :name: managed_server

Managed Server
===============================

You are looking at the general documentation of our `Managed Server <https://opsone.ch/de/plattform/managed-server>`_. Switch to other versions by using the Switch to selector at the bottom of the navigation.

Roadmap
----------------------

To ensure the highest possible stability, we rely on server versions for our Managed Servers.

.. list-table::

   * - Managed Server
     - Release Date
     - :doc:`end_of_life`
     - Release notes
   * - Upcoming Version 9
     - ~Summer 2023
     - ~Summer 2028
     - 
   * - `Version 8 </managed-server-8/>`_
     - August 2021
     - ✅ June 2026
     - `Release notes v8 <https://opsone.ch/de/blog/managed-server-version-8-verfuegbar>`_
   * - `Version 7 </managed-server-7/>`_
     - March 2020
     - ✅ June 2024
     - `Release notes v7 <https://opsone.ch/de/blog/managed-server-version-7-verfuegbar>`_
   * - `Version 6 </managed-server-6/>`_
     - Mai 2018
     - ⚠️ June 2022
     - none
   * - `Version 5 </managed-server-5/>`_
     - August 2015
     - ⛔️ June 2020
     - none

Advantages of Managed Server versions
-------------------------------------

Managed Server versions allow us to introduce extensive breaking changes without compromising or negatively impacting the operation of existing Managed Servers.

A new managed version is released on average every 2 years and receives support for 5 years, which is technically equivalent to the corresponding Debian release.

Stability is important to us; therefore, the customer can decide when to change to a new Managed Server version. That is why we do not use in-place updates, which have an unpredictable impact on the operation of an application.

Managed Server migration
------------------------
We recommend switching to a new Managed Server version at the same time as you carry out maintenance work or deploy a new application release. This allows the correct function to be checked and new features of the new Managed Server version can be used immediately.

Even though, In-place updates of existing systems are not intended, migration of an existing application is simple. Files and database can be moved quickly and easily via SSH by copying directly from server to server. A corresponding deployment pipeline can further simplify the move.