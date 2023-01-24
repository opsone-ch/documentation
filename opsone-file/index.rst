**************************
Ops One File Specification
**************************

The ``opsone.yaml`` is a file defining the configuration of an App you want to deploy to the Ops One Apps Platform.
Below you will find the current specification and an example.

Filename
~~~~~~~~

The filename of the Ops One file file must be ``opsone.yaml`` (not ``opsone.yml``) and must be located in the root directory of your git repository.

Examples
~~~~~~~~

Below you will find a minimum and a full example.

Minimum Example
---------------

.. code-block:: yaml

  version: 1
  hostnames:
    - "website01.example.com"

In the minimum example you only need to define the ``version`` and your ``hostnames``.

Full Example
------------

.. code-block:: yaml

  version: 1
  hostnames:
    - "website01.example.com"
    - "website02.example.com"
  environment:
    TEST1: "XYZ"
    TEST2: "XYZ"
  volumes:
    - "/web/user-uploads"
    - "/path/to/another/directory"
  redirects:
    - from: /exact-location/from-path
      to: /exact-location/to-path
      permanent: true
    - from: /exact-location/from-path
      to: https://website01.example.com/to-domain
    - from: /exact-location-with-trailing-slash/
      to: https://website01.example.com/with-trailing-slash/
    - regex: ^https:\/\/website02\.example\.com.*
      to: https://website01.example.com
    - regex: .*this-anywhere.*
      to: https://website01.example.com/regex-anywhere/
  basic_auth:
    user: "YOUR-USERNAME"
    pass: "YOUR-PASSWORD"
  modsecurity: true
  varnish: true

This is the full example of a ``opsone.yaml`` file.
It shows which keys are available and how they can be used.
Copy only the keys you need to your ``opsone.yaml`` file.

See the sections below for more information.

Components
~~~~~~~~~~

Below you will find a description of the different components.

Version
-------

The ``version`` key defines the version of the ``opsone.yaml`` file.

.. code-block:: yaml

  version: 1

Currently only version ``1`` is supported.

Hostnames
---------

The ``hostnames`` key is a list of hostnames you want to use for your App.

.. code-block:: yaml

  hostnames:
    - "website01.example.com"
    - "website02.example.com"

Your App will be available under all hostnames you define here.
Please ensure that your hostname resolves to the IP address of the Ops One Apps Platform.

Environment
-----------

The ``environment`` key is a list of environment variables you want to use for your App.

.. code-block:: yaml

  environment:
    TEST1: "XYZ"
    TEST2: "XYZ"

Environment variables are available in your App as environment variables.

Volumes
-------

The ``volumes`` key is a list of volumes you want to use for your App.

.. code-block:: yaml

  volumes:
    - "/web/user-uploads"
    - "/path/to/another/directory"

Files created within your app are not persisted.
To persist files, you must define a volume.

Basic Auth
----------

The ``basic_auth`` key is a dictionary of basic auth credentials you want to use for your App.

.. code-block:: yaml

  basic_auth:
    user: "YOUR-USERNAME"
    pass: "YOUR-PASSWORD"

Basic auth credentials are used to protect your App with a username and password.

Redirects
---------

The ``redirects`` key is a list of dictionaries defining redirects for your App.

.. code-block:: yaml

  redirects:
    - from: /exact-location/from-path
      to: /exact-location/to-path
      permanent: true
    - from: /exact-location/from-path
      to: https://website01.example.com/to-domain
    - from: /exact-location-with-trailing-slash/
      to: https://website01.example.com/with-trailing-slash/
    - regex: ^https:\/\/website02\.example\.com.*
      to: https://website01.example.com
    - regex: .*this-anywhere.*
      to: https://website01.example.com/regex-anywhere/

* The ``from`` key defines the location to redirect from (``regex`` for regular expressions)
* The ``to`` key defines the location to redirect to

You can also define a ``permanent`` key to define a `301-redirect <https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/301>`__ ,
instead of a `302-redirect <https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/302>`__.

Additional Services
-------------------

.. code-block:: yaml

  modsecurity: true
  varnish: true

The ``modsecurity`` and ``varnish`` keys are booleans to enable additional services for your App.