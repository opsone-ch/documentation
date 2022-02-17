.. index::
   triple: How-to; Getting Started with; Typo3
   :name: howto-typo3

==============================
Getting Started with TYPO3
==============================

TYPO3 is one of the biggest Open Source CMS currently on the market. To get more information about TYPO3, visit their `Website <https://typo3.org>`__

Create Environment
------------------

First you have to create a website on your server.
Our website module provides everything you need to manage, deploy and run your website.
Every Website is type and environment based, which means you have to select a particular type (e.g. `TYPO3 <../website/type.html#typo3-v11>`__) and `environment <../website/context.html>`__ (e.g. PROD).

1. Log in to `cockpit.opsone.ch <https://cockpit.opsone.ch>`__
2. Choose your server or create a new one
3. Go to websites, and create a new one
4. `Select website type <../website/type.html#typo3-v11>`__ TYPO3 and fill in all settings

.. tip:: Depending on what TYPO3 Version you choose, the correct core will be installed and available for use.

.. tip:: You don't need to remember your DB credentials. We always provide them as `environment variables <../website/envvar.html>`__.

According to those settings, our automation will setup the server/vhost as required.

Access with SSH
---------------

On the server you can work with SSH.
Due to security reasons, we allow key based logins only.

1. If you don't have an SSH key: `Create an SSH key pair <../howto/sshkey.html>`_
2. Add your SSH Public Key in the Cockpit: Either for the whole server or within the website.
3. Now you can log in via SSH. Username is your chosen website name, not your own username.

.. tip:: Wondering why your existing SSH key is not working? Maybe it does not meet our `minimum requirements <../howto/sshkey.html>`__.

Install TYPO3
-------------

You can download and unzip TYPO3 normally.
However, we recommend using our pre-installed TYPO3 core.
This allows you to profit from our Automatic TYPO3 Core Updates.

.. code-block:: shell

  # switch to your webroot
  $ cd ~/public

  # create symlinks for TYPO3
  $ ln -s /opt/typo3/TYPO3_11 typo3_src
  $ ln -s [path-to-webroot]/typo3_src/typo3 typo3
  $ ln -s [path-to-webroot]/typo3_src/index.php

  # Create FIRST_INSTALL file
  $ touch FIRST_INSTALL

You are now ready to finish the install in the web browser.
Note that the Database username ist the same as the Website Name and the Password can be found in the `cockpit <https://cockpit.opsone.ch>`__
Make sure to safely store your administrator credentials as you will need them to Log into the backend and make Changes in the TYPO3 Maintenance mode.

.. tip::

   Depending on the TYPO3 Version you choose, we set a different webroot. You can see the Details in the `Type Overview <../website/type.html>`__.
   For example: The webroot for TYPO3v11 is `public/`

.. warning::

   As some TYPO3 versions have reached their end of life already,
   compatibility settings are required within some of the applications.

Required Configuration for TYPO3 6
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* ``DB/Connections/Default/initCommands`` must be set to ``SET sql_mode = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';``
* PHP 5.6 does not have FreeType support included
* some (system) extensions like frontend do need a small adjustment (see `Ticket#83414 <https://forge.typo3.org/issues/83414#note-7>`__)

Required Configuration for TYPO3 7
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. warning::

   Install Tool is not usable to install new versions from scratch (see `Ticket#82023 <https://forge.typo3.org/issues/82023>`__)

* ``DB/Connections/Default/initCommands`` must be set to ``SET sql_mode = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';``
* Some extensions like the frontend sysext need a small adjustment (see `Ticket#83414 <https://forge.typo3.org/issues/83414#note-7>`__)