.. index::
   triple: How-to; Getting Started with; Docker
   :name: howto-docker

===========================
Getting Started with Docker
===========================

.. warning::

   WIP: This content was not yet adapted and checked for version 7,
   which we will do as soon as possible.
   If in doubt, please contact us for details regarding this topic.

Goal: Install Docker on the server and make a container available behind a reverse proxy.

Create Environment
------------------

First you have to create a website on your server.
A website acts as a reverse proxy and install Docker for you.
Every website is type and environment based which means you have to select a particular type (e.g. docker) and environment (e.g. PROD).

1. Log in to `cockpit.opsone.ch <https://cockpit.opsone.ch>`__
2. Choose your server or create a new one
3. Go to websites, and create a new one
4. `Select website type <../services/website.html#docker>`__ docker and fill in all settings

According those settings, our automation will setup the server/vhost as required.

Access with SSH
---------------

On the server you can work with SSH.
Due to security reasons, we allow key based logins only.

1. If you don't have an SSH key: `Create an SSH key pair <../server/ssh-keys.html>`__
2. Add your SSH Public Key in the Cockpit: Either for the whole server or within the website.
3. Now you can log in via SSH. Username is your chosen website name, not your own Username.

.. tip:: Wondering why your existing SSH key is not working? Maybe it does not meet our `minimum requirements <../server/ssh-keys.html>`_ 

Run a Docker Image
------------------

.. code-block:: shell

  # run your docker container (nginx as example)
  $ docker run --detach --restart always --publish 127.0.0.1:8080:80 nginx

You can use any free port. In this example we expose our docker container at 127.0.0.1.8080.

.. tip:: For the container to be accessible from the outside via reverse proxy, the selected port must match the one in the cockpit.
