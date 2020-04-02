.. index::
   triple: How-to; Getting Started with; Wordpress
   :name: howto-wordpress

==============================
Getting Started with WordPress
==============================

There are dozens of ways you can deploy WordPress.
The following way describes only one way.

Create Environment
------------------

First you have to create a website on your server.
Our website module provides everything you need to manage, deploy and run your website.
Every Website is type and environment based, which means you have to select a particular type (e.g. `wordpress <../services/website.html#wordpress>`__) and `environment <../services/website.html#environments>`__ (e.g. PROD).

1. Log in to `cockpit.opsone.ch <https://cockpit.opsone.ch>`__
2. Choose your server or create a new one
3. Go to websites, and create a new one
4. `Select website type <../services/website.html#wordpress>`__ wordpress and fill in all settings

.. tip:: You don't need to remember your DB credentials. We always provide them as `environment variables <../services/website.html#default-environment-variables>`__.

According to those settings, our automation will setup the server/vhost as required.

Access with SSH
---------------

On the server you can work with SSH.
Due to security reasons, we allow key based logins only.

1. If you don't have an SSH key: `Create an SSH key pair <../server/ssh-keys.html>`_
2. Add your SSH Public Key in the Cockpit: Either for the whole server or within the website.
3. Now you can log in via SSH. Username is your chosen website name, not your own Username.

.. tip:: Wondering why your existing SSH key is not working? Maybe it does not meet our `minimum requirements <../server/ssh-keys.html>`__.

Install WordPress
-----------------

You can download and unzip WordPress normally.
However, we recommend using `WP-CLI <https://wp-cli.org/>`__ (already pre-installed).
This allows you to install WordPress with just four commands.

.. code-block:: shell

  # switch to your webroot
  $ cd ~/www

  # download wordpress
  $ wp core download

  # generate your config
  $ wp config create --dbname=$DB_NAME --dbuser=$DB_USERNAME --dbpass=$DB_PASSWORD

  # create your first user
  $ wp core install --url=example.com --title="Example Site" --admin_user=admin --admin_email=john@example.com

You are now ready to use your installation of WordPress.

