.. index::
   triple: How-to; Getting Started with; Wordpress
   :name: howto-wordpress

==============================
Getting Started with WordPress
==============================

There are dozens of ways you can deploy WordPress.
The following way describes only one way.

.. include:: ../shared/createenvironment.rst
4. `Select website type <../website/type.html#wordpress>`__ wordpress and fill in all settings

.. tip:: You don't need to remember your DB credentials. We always provide them as `environment variables <../website/envvar.html>`__.

According to those settings, our automation will setup the server/vhost as required.

.. include:: ../shared/sshaccess.rst

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

