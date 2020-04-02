.. index::
   triple: Website; Custom Configuration; Node.js
   :name: website-advanced-node

=======
Node.js
=======

If you need Node.js available within your existing website which is based
on another type, you can enable node by setting ``nvm`` to ``true``
within the `Custom JSON` :ref:`customjson_website`:

.. code-block:: json

   {
     "nvm": true
   }

.. warning::

   Use only to enable node within another website type for actions like gulp.
   To run your own node based website, use the :ref:`website-type_nodejs` type.

By default, the latest Node.js LTS version will be installed,
however you can also install and select any other version:

::

    $ nvm ls-remote
    $ nvm install <version>

.. tip::

   See the `nvm readme <https://github.com/nvm-sh/nvm#usage>`__ for details.

