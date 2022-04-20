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
     - Documentation
     - Release notes
   * - Version 5
     - August 2015
     - June 2020 ⚠️
     - `Docs v5 <https://docs.opsone.ch/managed-server-5/>`_
     - none
   * - Version 6
     - Mai 2018
     - June 2022
     - `Docs v6 <https://docs.opsone.ch/managed-server-6/>`_
     - none
   * - Version 7
     - March 2020
     - June 2024
     - `Docs v7 <https://docs.opsone.ch/managed-server-7/>`_
     - `Notes v7 <https://opsone.ch/de/blog/managed-server-version-7-verfuegbar>`_
   * - Version 8
     - August 2021
     - June 2026
     - `Docs v8 <https://docs.opsone.ch/managed-server-8/>`_
     - `Notes v8 <https://opsone.ch/de/blog/managed-server-version-8-verfuegbar>`_
   * - Upcoming Version 9
     - ~Summer 2023
     - ~Summer 2028
     - 
     - 

Advantages of Managed Server versions
-------------------------------------

Managed Server versions allow us to introduce extensive breaking changes without compromising or negatively impacting the operation of existing Managed Servers.

A new managed version is released on average every 2 years and receives support for 5 years, which is technically equivalent to the corresponding Debian release.

Stability is important to us; therefore, the customer can decide when to change to a new Managed Server version. That is why we do not use in-place updates, which have an unpredictable impact on the operation of an application.

Managed Server migration
------------------------
We recommend switching to a new Managed Server version at the same time as you carry out maintenance work or deploy a new application release. This allows the correct function to be checked and new features of the new Managed Server version can be used immediately.

Even though, In-place updates of existing systems are not intended, migration of an existing application is simple. Files and database can be moved quickly and easily via SSH by copying directly from server to server. A corresponding deployment pipeline can further simplify the move.