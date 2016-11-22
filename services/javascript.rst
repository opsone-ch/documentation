Javascript
==========

Install and manage different javascript application. By now, the
following javascript "backends" are supported:

-  Nodejs

Nodejs
------

To install Node.js, add ``nodejs`` to the ``javascript::backend`` hash:

::

    javascript::backend:
      "nodejs":
        "ensure": "present"

To run your Node.js application in production, contact our
`support <../support.md>`__.

NPM
---

The Node.js services comes by default with the NPM. The following
packages are preinstalled:

-  grunt
-  grunt-cli
-  node

To install more packages locally use:

::

    npm install <package name>

For more information visit the offical `NPM
documentation <https://docs.npmjs.com/>`__.
