.. index::
   twin: Server; SSH Client Configuration
   :name: server-ssh

========================
SSH client configuration
========================

You can add custom SSH client configurations to ``/etc/ssh/ssh_config``
by setting the ``ssh::config`` hash within the `Custom JSON` :ref:`customjson_server`:

.. code-block:: json

   {
     "ssh::config": {
       "Host": "git",
       "HostName": "code.example.com",
       "User": "git"
     }
   }

.. Hint::

   use ``man ssh_config`` (`online version <http://man.openbsd.org/ssh_config>`_) for available configuration options

