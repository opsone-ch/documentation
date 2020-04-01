Hosts File
==========

To add your own entries to the servers hosts file, use the
``hosts::entries`` hash within the `Custom JSON` :ref:`customjson_server`:

.. code-block:: json

   {
     "hosts::entries": {
       "192.168.1.1": "remote-server.example.com",
       "127.0.0.1": "www.example.net"
     }
   }

