.. index::
   triple: How-to; Getting Started with; Typo3
   :name: howto-typo3

==============================
Getting Started with TYPO3
==============================

TYPO3 is an Open Source CMS written in PHP. To get more information, visit their `website <https://typo3.org>`__.

.. include:: ../shared/createenvironment.rst
#. `Select website type <../website/type.html#typo3-v11>`__ TYPO3 and fill in all settings

.. tip:: Depending on what TYPO3 Version you choose, the correct core will be installed and available for use.

.. tip:: You don't need to remember your DB credentials. We always provide them as `environment variables <../website/envvar.html>`__.

According to those settings, our automation will setup the server/vhost as required.

.. include:: ../shared/sshaccess.rst

Install TYPO3
-------------

We recommend that you install TYPO3 via composer to have full control over the update cycle. However, if you want to use the TYPO3 core provided by us, you are welcome to do so. We update the TYPO3 core shortly after the official release. Please note that we provide the core as is and do not perform any additional testing.

If you want to install TYPO3 via composer, follow the instructions provided by the `TYPO3 Documentation <https://docs.typo3.org/m/typo3/tutorial-getting-started/main/en-us/Installation/Install.html>`__.

To use the TYPO3 core we provide, follow the instructions below.

.. note:: 

   Check the different TYPO3 Types in our `Overview <../website/type.html>`__ to get the specific Version configurations and TYPO3 core directories.
   
   The webroot of your website may vary depending on what TYPO3 Version you select and can also be checked in the Type Overview linked above.

.. code-block:: shell

  # switch to your webroot
  $ cd ~/[webroot]

  # create symlinks for TYPO3
  $ ln -s /opt/typo3/[TYPO3-Version] typo3_src
  $ ln -s [path-to-webroot]/typo3_src/typo3 typo3
  $ ln -s [path-to-webroot]/typo3_src/index.php

  # Create FIRST_INSTALL file
  $ touch FIRST_INSTALL

You are now ready to finish the install in the web browser.
Note that the Database username ist the same as the Website Name and the Password can be found in the `cockpit <https://cockpit.opsone.ch>`__.
Make sure to safely store your administrator credentials as you will need them to Log into the backend and make Changes in the TYPO3 Maintenance mode.


.. warning::

   As some TYPO3 versions have reached their end of life already,
   compatibility settings are required within some of the applications.

   For TYPO3 v6: `Required custom configuration <https://docs.opsone.ch/managed-server-8/website/type.html#typo3-v6>`__.

   For TYPO3 v7: `Required custom configuration <https://docs.opsone.ch/managed-server-8/website/type.html#typo3-v7>`__.

