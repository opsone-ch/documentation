*******
Node.js
*******

We support `Node.js <https://nodejs.org/>`__ with support for the package managers `npm <https://www.npmjs.com/>`__ and `Yarn <https://yarnpkg.com/>`__.

Node Version
~~~~~~~~~~~~

Per default, we use the latest long term version (LTS) of Node.js.
If you want to use a different version, you can specify it in your ``package.json``.
We recommend to use the same version as your local development environment and not older than the latest LTS version.

.. code-block:: json

    {
      "engines" : {
        "node" : "<15.0.0"
      }
    }

Package Manager
~~~~~~~~~~~~~~~

During the build process, both package mangers are available.

If a ``yarn.lock`` file exists, we will use Yarn, otherwise npm is used.
If you want to use a specific version of one of them, you can specify it in your ``package.json`` file.

.. code-block:: json

    {
      "engines" : {
        "node" : "<15.0.0",
        "npm" : "<7.0.0",
        "yarn" : "<1.22.0"
      }
    }

