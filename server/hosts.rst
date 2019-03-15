Hosts File
==========

You can add entries to the servers hosts file for testing or other
purposes (e.g. TYPO3 page not found handling, APIs) like this:

.. code-block:: json

  {
    "hosts::entries": {
      "192.168.1.1": "remote-server-name",
      "127.0.0.1": "www.example.net"
    }
  }
