.. index::
   triple: How-to; Getting Started with; Nuxt.js
   :name: howto-nuxt

============================
Getting Started with Nuxt.js
============================

Nuxt.js is a framework to build Vue.js applications. See their `website <https://nuxtjs.org>`__
for more informations.

Create Website
==============

With Nuxt.js being a framework based on Node.js, you have to create a :ref:`website-type_nodejs` website
on your server:

#. Log in to `cockpit.opsone.ch <https://cockpit.opsone.ch>`__
#. Choose your server or create a new one
#. Go to websites, and create a new one
#. Select website type :ref:`website-type_nodejs`

Access with SSH
===============

Once the new website was created sucessfulyl, you can log into the server
through SSH. For details, see :ref:`access-ssh`.

Installation
============

As the latest Node.js LTS version will be already installed through nvm by default,
we can go on directly to the Nuxt.js installation. Make sure to select ``npm``
as package manager which is installed by default already.

.. code-block:: shell

   $ npx create-nuxt-app opsone-demo

Configuration
=============

To make sure Nuxt.js works nicely within our environment, we have to configure
the following options.

Node.js Daemon
--------------

We have to configure the Node.js daemon to start Nuxt.js from within our
particular subfolder. To accomplish this, we have to create the
``~/cnf/nodejs-daemon`` file with the following content:

.. code-block::

   APPDIR=opsone-demo
   export PATH=${NODEJS_HOME}/${APPDIR}/node_modules/.bin/:$PATH
   DAEMON="nuxt"
   OPTIONS="start ${APPDIR}"

Nuxt.js Configuration
---------------------

As we prefere the use of unix sockets in favour of TCP ports, we have
to configure Nuxt.js to reflect this. Add the ``server.socket`` part to the
Nuxt.js configuration in ``~/opsone-demo/nuxt.config.js``:

.. code-block::

   export default {
     server: {
        socket: `${process.env.HOME}/cnf/nodejs.sock`
     },
     other: options
   }

Build
=====

To run our application, we have to build it first. You can either build the
created application right away, or add your desired changes first. Either way,
you have to build your application after any change.

.. code-block:: shell

   $ npm run --prefix opsone-demo build

Start and Access Application
============================

To reload our changes, use the ``nodejs-restart`` shortcut. If everything went
fine, you can now access your new Nuxt.js application at the hostname
configured in cockpit.

If you encounter any errors, check to logs within the ``~/log/`` folder,
especially to ``~/log/nodejs-daemon.log`` file. For more informations
about the available log files, see :ref:`howto-logfile`.

