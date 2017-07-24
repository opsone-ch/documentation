Globalrepo Service
==================

The globalrepo service is used, to checkout any refresh Git repository into a folder.

Options
-------

source
~~~~~~

* Repository source address, e.g. `git@git.example.net:myproject.git`
* you can add a hash of multiple sources and select the appropriate one through the `remote` parameter
* this is the only mandatory parameter

path
~~~~

* local path where the data ends up on the server
* default: `/opt/global/<name>`

ensure
~~~~~~

* `present` to enable this configuration
* `absent` to disable and remove this configuration and folder
* default: `present`

provider
~~~~~~~~

* provider used to fetch repository, see `module description of the vcsrepo Puppet module <https://github.com/puppetlabs/puppetlabs-vcsrepo#module-description>`__
* default: `git`

.. hint:: git is the only vcs provider officially supported by Puppet

remote
~~~~~~

* used git remote
* default: `origin`

revision
~~~~~~~~

* desired revision (branch, tag, commit-id)
* default: `master`

ssh_private_key
~~~~~~~~~~~~~~~

* SSH private key used to fetch a private repository
* default: empty

.. hint:: use `cat /tmp/private_key | sed -e ':a;N;$!ba;s/\n/\\n/g` to convert key into a single line with escaped linebreaks

exec_after
~~~~~~~~~~

* command executed after update, e.g. `composer update`
* default: empty


Minimal configuration
---------------------

::

    globalrepo::repo:
      "myproject":
        "source": "git@git.example.net:myproject.git"

Full example
------------

::

    globalrepo::repo:
      "myproject":
        "source":
          "origin":        "git@git.example.net:myproject.git"
          "upstream":      "git@git.example.com:myproject.git"
          "mirror":        "git@git.example.org:myproject.git"
        "path":            "/opt/global/myproject"
        "ensure":          "present"
        "provider"         "git"
        "remote":          "origin"
        "revision":        "master"
        "ssh_private_key": "ssh-private-key"
        "exec_after":      "composer update"

