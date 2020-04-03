.. index::
   single: Website
   :name: website

=======
Website
=======

To create a new website, there are only a few settings required:

* `name` will define the name used for system wide settings like users
  or databases (see :ref:`website-name`)
* `type` will define the preloaded settings for a certain application
  type (see :ref:`website-type`)
* `context` will define the context used within your application and
  is also used to set some default settings (see :ref:`website-context`)
* (optional) a `server name` when your website must listen to other
  hostnames than the default one

After creating, you can log into your newly created website by using
the websites name as SSH username (see :ref:`access-ssh`).

This and all other options are outlined within this chapter:

.. toctree::
   :maxdepth: 2

   name
   labels
   type
   context
   ssl
   waf
   security
   limits
   envvar
   cron
   monitoring
   advanced/index

