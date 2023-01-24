*******************
ModSecurity (Alpha)
*******************

You can use `ModSecurity <https://github.com/SpiderLabs/ModSecurity>`__ to protect your application from common web attacks.
It can be used to protect your application from a wide range of attacks,
including SQL injection, cross-site scripting, and cross-site request forgery.

Enable ModSecurity in your ``opsone.yaml``:

.. code-block:: yaml

    version: 1
    modsecurity: true