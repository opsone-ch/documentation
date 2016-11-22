Tomcat Service
==============

Install and manage your favorite Java web application.

Plain Tomcat
------------

To install a preconfigured Tomcat and run your own .war file, install
Tomcat with:

::

    # additional Puppet Modules
    base::modules:
      - "tomcat"

Apache Solr
-----------

To install a preconfigured `Apache
Solr <http://lucene.apache.org/solr/>`__ service, use one of the
following preconfigured packages.

Based on:

-  Apache Solr 4
-  Tomcat 8

TYPO3
^^^^^

::

    # additional Puppet Modules
    base::modules:
      - "solr"

    # Solr Configuration
    solr::webappv4:
      "solr-example-net":
        "password":    "oiphiengukei4paMahch0thoo"
        "solrVersion": "4.8.1"
        "extVersion":  "3.0.0"

This will install Solr 4.8 configured for the usage of with the
inofficial TYPO3 Solr extension.

Magento
^^^^^^^

::

    # additional Puppet Modules
    base::modules:
      - "solr"

    solr::instance::magento:
      "solr-example-ch":
        "password":    "pai3xohw0ieGhieSheuge3oaf"
        "solrVersion": "4.8.1"
        "extVersion":  "1.0.0"

Access
^^^^^^

After adding the Solr configuration and instance to your hiera .yaml
file and run puppet, your Solr instance admin webinterface is accessible
through the web:

-  URL https://yourhostxy.snowflakehosting.ch:8443/solr-example-net/

To add new cores, simply click on add core and:

-  Name: solr-example-net
-  instanceDir: typo3cores (or magento)
-  dataDir: data/live-example-1.0-de\_CH
-  config: solrconfig.xml
-  /schema.xml

Memory usage / ratio
--------------------

We auto-configure Tomcat to use up to 80% of the available server
memory. Assuming that there is only 1 services running on the server.

Hint: See `Memory Ratio </server/configuration.md#Memory_Ratio>`__ for
details about memory ratio calculation
