Solr
====

Install and manage Apache Solr instances for different use cases.

Solr 6 for TYPO3
----------------

To install Solr 6 for TYPO3, use the ``solr::webappv6`` configuration.

Configuration
^^^^^^^^^^^^^

ensure
""""""

* `present` enable Solr instance
* `absent` disable Solr instance and remove all its data and configuration
* default: `present`

solrVersion
"""""""""""

Version of Apache Solr to be installed.

* default: `6.6.1`

extVersion
""""""""""

Version of `TYPO3 Solr <https://github.com/TYPO3-Solr/ext-solr/tags>`__ to be installed.

* default: `7.0.1`

port
""""

By default, Solr will listen on port 8983. If you have multiple instances, or want to use a different
port for other reasons, use the ``port`` parameter to specify the corresponding TCP port.

.. hint:: Solr will listen on the localhost interface only. If you need to expose Solr for external access, please use a website service (proxy type), and make sure access is allowed only by basic or ip address auth

memory_ratio
""""""""""""

By default, a ``memory_ratio`` of 4 is used, which means Solr will
take up to 25% of this servers total memory.

.. hint:: see :doc:`../server/configuration` for details about memory ratio calculation

monitoring
""""""""""

* `true` monitor Solr instance locally (Monit) and externally (HTTP check to Solr status)
* `false` do not monitor Solr instance at all
* default: `true`

Full example
""""""""""""

.. code-block:: json

    {
      "solr::webappv6": {
        "<name>": {
          "ensure": "present",
          "solrVersion": "6.6.1",
          "extVersion": "7.0.1",
          "port": "8983",
          "memory_ratio": "4",
          "monitoring": true
        }
      }
    }

Solr Admin
^^^^^^^^^^

The Solr admin interface is reachable on `http://localhost:port`. To access Solr externally, please use a website service (proxy type), and make sure access is allowed only by basic or ip address auth. If the webapplication using Solr is installed on the same server, best practice is to let Solr run on localhost only and access Solr admin for management purposes by forwarding the corresponding port through SSH.

Add core
""""""""

To add new core for a certain site or language, use the following URL:

`http://localhost:8983/solr/admin/cores?action=CREATE&name=<core-name>&configSet=<version>&schema=<language>/schema.xml`

* name: name of the new core
* configSet: desired template as provided within the `Resources/Private/Solr/configsets/` folder in TYPO3 Solr, e.g. `ext_solr_7_0_0`
* schema: `<language>/schema.xml` as provided within the `Resources/Private/Solr/configsets/<version>/conf/` folder in TYPO3 Solr, e.g. `german/schema.xml`

For details, please consult the `TYPO3 Solr Documentation <https://docs.typo3.org/typo3cms/extensions/solr/>`__.

Solr 7 for TYPO3
----------------

To install Solr 7 for TYPO3, use the ``solr::webappv7`` configuration.

Configuration
^^^^^^^^^^^^^

ensure
""""""

* `present` enable Solr instance
* `absent` disable Solr instance and remove all its data and configuration
* default: `present`

solrVersion
"""""""""""

Version of Apache Solr to be installed.

* default: `7.6.0`

extVersion
""""""""""

Version of `TYPO3 Solr <https://github.com/TYPO3-Solr/ext-solr/tags>`__ to be installed.

* default: `8.1.2`

port
""""

By default, Solr will listen on port 8983. If you have multiple instances, or want to use a different
port for other reasons, use the ``port`` parameter to specify the corresponding TCP port.

.. hint:: Solr will listen on the localhost interface only. If you need to expose Solr for external access, please use a website service (proxy type), and make sure access is allowed only by basic or ip address auth

memory_ratio
""""""""""""

By default, a ``memory_ratio`` of 4 is used, which means Solr will
take up to 25% of this servers total memory.

.. hint:: see :doc:`../server/configuration` for details about memory ratio calculation

monitoring
""""""""""

* `true` monitor Solr instance locally (Monit) and externally (HTTP check to Solr status)
* `false` do not monitor Solr instance at all
* default: `true`

Full example
""""""""""""

.. code-block:: json

    {
      "solr::webappv7": {
        "<name>": {
          "ensure": "present",
          "solrVersion": "7.6.0",
          "extVersion": "8.1.2",
          "port": "8983",
          "memory_ratio": "4",
          "monitoring": true
        }
      }
    }

Solr Admin
^^^^^^^^^^

The Solr admin interface is reachable on `http://localhost:port`. To access Solr externally, please use a website service (proxy type), and make sure access is allowed only by basic or ip address auth. If the webapplication using Solr is installed on the same server, best practice is to let Solr run on localhost only and access Solr admin for management purposes by forwarding the corresponding port through SSH.

Add core
""""""""

To add new core for a certain site or language, use the following URL:

`http://localhost:8983/solr/admin/cores?action=CREATE&name=<core-name>&configSet=<version>&schema=<language>/schema.xml`

* name: name of the new core
* configSet: desired template as provided within the `Resources/Private/Solr/configsets/` folder in TYPO3 Solr, e.g. `ext_solr_7_0_0`
* schema: `<language>/schema.xml` as provided within the `Resources/Private/Solr/configsets/<version>/conf/` folder in TYPO3 Solr, e.g. `german/schema.xml`

For details, please consult the `TYPO3 Solr Documentation <https://docs.typo3.org/typo3cms/extensions/solr/>`__.

