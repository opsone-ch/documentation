Monitoring
==========

Availability (external)
-----------------------

We closely monitor all aspects of your server. According to your service level, our on call organisation
will take appropriate actions if required.

Availability (internal)
-----------------------

Monit, nginx and PHP FPM (if installed) status pages are available at ``http://localhost:2813/``:

* ``http://localhost:2813/monit/``: Monit service manager displaying status of all locally monitored processes
* ``http://localhost:2813/nginx/``: nginx `stub status <http://nginx.org/en/docs/http/ngx_http_stub_status_module.html>`__ output
* ``http://localhost:2813/fpm-<poolname>/``: PHP FPM per pool status page

.. hint:: this status vhost is running on localhost only. Expose port 2813 through SSH to access locally: ``ssh <hostname> -L 2813:localhost:2813``

Reboot
------

A automatic reboot is initiated to solve certain high usage scenarios:

* 5 minute average load higher than CPU count * 10 for 5 minutes
* memory usage higher than 95% for 5 minutes

.. hint:: always make sure that any required services will be up and running automatically

Utilization
-----------

collectd
~~~~~~~~

System statistics are collected every 10 seconds by collectd and written to RRD files in
`/var/lib/collectd`. For performance reasons, we don't create graphs by default, therefore you have
to download and render them with a tool of your choice by yourself.

Please select a rendering-tool from `list of frontends <https://collectd.org/wiki/index.php/List_of_front-ends>`__
within the collectd wiki. We use `collectd-web <https://github.com/httpdss/collectd-web>`__ for our own analyses.


Examine with `collectd-web`
^^^^^^^^^^^^^^^^^^^^^^^^^^^

* installation

::

  sudo apt-get install librrds-perl libjson-perl libhtml-parser-perl
  git clone https://github.com/httpdss/collectd-web.git
  echo 'datadir: "/tmp/rrd"' | sudo tee /etc/collectd/collection.conf

* fetch data and render graphs

::

  rsync -avz <server>:/var/lib/collectd/rrd/ /tmp/rrd/
  cd /path/to/collectd-web
  python runserver.py

* then open `collectd-web` at ``http://127.0.0.1:8888/``

