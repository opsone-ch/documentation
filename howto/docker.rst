.. index::
   triple: How-to; Getting Started with; Docker
   :name: howto-docker

===========================
Getting Started with Docker
===========================

Create Website
==============

To use a Docker based application, you have to create a website
on your server. The website will act as environment which will
hold your Docker configurations and also as reverse proxy in
front of your application.

#. Log in to `cockpit.opsone.ch <https://cockpit.opsone.ch>`__
#. Choose your server or create a new one
#. Go to websites, and create a new one
#. Select website type :ref:`website-type_docker` and configure `Proxy pass` to your Docker containers port

The ``Proxy pass`` value must also include the protocol such as http or https.
An example of a correct value: ``http://127.0.0.1:8080``

Access with SSH
===============

Once the new website was created sucessfulyl, you can log into the server
through SSH. For details, see :ref:`access-ssh`.

Run Docker Container
====================

.. code-block:: shell

   # run your docker container (nginx as example)
   $ docker run --detach --restart always --publish 127.0.0.1:8080:80 nginx

You can use any free port. In this example we expose our docker container at 127.0.0.1:8080.

.. tip::

   Always start your containers with ``--restart always`` to make sure they
   are up and running again after a :ref:`automatic <monitoring_reboot>`
   or :ref:`planned <maintenance_reboots>` reboot.

.. tip::

   For the container to be accessible from the outside via reverse proxy,
   the selected port must match the one configured in `Proxy pass`.

Expose Port Externally
=======================

In general, we do not recommend to expose Docker ports to the world for security
reasons, but use a proxy website in front instead.
Still, there are use cases which this is required tough:

* by default, exposed ports are bound to `127.0.0.1`
* bind your port to the desired interface explicitly: ``--publish 192.168.1.1:2222:22``
* allow external access to the port with a custom firewall rule (see :ref:`firewall_customrule`)

User Namespace Isolation
========================

For security reasons, we run Docker in a isolated namespace
(`Details within the Docker manual <https://docs.docker.com/engine/security/userns-remap/>`__).

* user and group IDs within the container are mapped to non-existing IDs on the host
* direct bind mounts are not allowed
* use volumes instead

.. tip::

   We know of certain setups where it is not possible to have userns remapping enabled.
   If you encounter this problem, please contact us and we will disable userns remap
   for your system after we checked your requirements.

