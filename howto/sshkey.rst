.. index::
   triple: How-to; SSH; Key Generate
   :name: howto-sshkey

================
SSH Key Handling
================

.. index::
   triple: How-to; SSH; Windows
   :name: howto-sshkey_windows

Windows
=======

Download and install the Putty Installer from the official `download page <http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html>`__.

Create SSH Key Pair
-------------------

* start puttygen
* select `ED25519` and press the `Generate` button
* alternatively you can select `SSH-2 RSA` and increase the `Number of bits in a generated key` field to `4096`
* follow the instructions and generate randomness by moving the mouse over the requested area
* change the `Key comment` to your e-mail address
* enter a secure `Key passphrase` (for security reasons, never create keys without passphrase!)
* press the `Save public key` and `Save private key` button

.. warning::

   As the name tells, the public key is used to identify you on a remote system,
   and you use the private key on your local machine to identify yourself against the desired
   server. Make sure your private key does not leave your computer.

SSH Agent (Pageant)
-------------------

Putty comes with a SSH agent named pageant. It comes bundled with the
putty installer or you can find it on the putty download page. After you
started Pageant, it will hide itselve in the systray. To add your key,
open the Pageant dialog by right clicking on the systray icon. Please
refere to the `Pageant
documentation <http://the.earth.li/~sgtatham/putty/0.58/htmldoc/Chapter9.html#pageant>`__
for more information.

Agent Forwarding
----------------

For several actions like checking out a git repository or copying a site
form stage to prod you need to forward your SSH Agent. First you have to
browse to ``Connection->SSH->Auth`` on the left-hand side, then you have
to enable the ``Allow agent forwarding`` checkbox.

.. warning::

   "Agent forwarding should be enabled with caution. Users with
   the ability to bypass file permissions on the remote host (for the
   agent's UNIX-domain socket) can access the local agent through the
   forwarded connection. An attacker cannot obtain key material from the
   agent, however they can perform operations on the keys that enable them
   to authenticate using the identities loaded into the agent." (openssh
   manual)

.. index::
   triple: How-to; SSH; MacOS
   :name: howto-sshkey_macos

.. index::
   triple: How-to; SSH; Linux
   :name: howto-sshkey_linux

Mac, Linux
==========

Create an SSH key pair
----------------------

Make sure the openssh-client package is installed and issue this command in your favorite shell:

.. code-block:: bash

   ssh-keygen -t ed25519 -a 100 -C '<e-mail@address>'

 .. warning::

   Do not create keys without passphrase. If you do so, everyone with access to the key file will gain access to the server immediatelly!

Agent Forwarding
----------------

For several actions like checking out a git repository or copying a site
form stage to prod you need to forward your SSH Agent. Use the command
``ssh -F`` or the SSH config directive ``ForwardAgent yes`` to forward
your SSH Agent.

SSH agent
---------

Since you encrypted your key with a secure passphrase, you have to enter
this passphrase every time you attempt to connect to an SSH Server in
order to decrypt your private key.

An SSH agent caches your decrypted keys and provides them to SSH client
programs. Thus the passphrase must only provided once, when adding your
private key to the agent's cache.

.. tip::

   Usually you would start your agent upon login, and let it run
   until you logout. There are many diffrent agents, and they are typically
   well integrated to your OS, SHELL or Desktop Environment. Please refer
   to the documentation of your favorite agent.

.. warning::

   Please use the -c flag to prevent key hijacking. This flag
   ''indicates that added identities should be subject to confirmation
   before being used for authentication''. That means, you have to confirm
   all uses of your key, espessially when you are logged in to a server
   (with enabled AgentForwarding) and another user tries to steal your
   identity. Please refere to the documentation of your favorite agent on
   how to prevent key hijacking.

   Confirmation is performed by the SSH\_ASKPASS program mentioned below.
   Successful confirmation is signaled by a zero exit status from the
   SSH\_ASKPASS program, rather than text entered into the requester.

