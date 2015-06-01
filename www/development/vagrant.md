# Vagrant

We rely on Vagrant to create local VMs for your purposes. You can use those Vagrant boxes to develop your application, but also to make changes at our Puppet environment itself.


## OS Support

Right now we support Vagrant on Ubuntu Linux (LXC Provider) and Mac OS (VirtualBox Provider). While our configuration could work with VirtualBox on Windows as well, it is currently not supported.


### Mac OS

* VirtualBox
* Files reside on host and get mounted into VM trough NFS


### Ubuntu Linux

* LXC
* Files reside on host and get mounted into VM trough NFS


## Requirements

* working [VirtualBox](https://www.virtualbox.org/) (Mac OS) or [LXC](https://linuxcontainers.org/) (Ubuntu) installation
* [Vagrant](http://www.vagrantup.com/downloads.html)
* Vagrant Plugins
```
vagrant plugin install vagrant-hostmanager   # required to access VM trough name/aliases
vagrant plugin install vagrant-cachier
vagrant plugin install vagrant-lxc           # Ubuntu only
```
* [GIT](https://git-scm.com/)
* SSH Key loaded into ssh-agent
* Access to snowflake Puppet repositories

Hint: As long as our Puppet modules are not published under an open source license, [send us](/support.md) your SSH public key. We will add those to the required GIT repositories and provide you the relevant informations
 

## Setup project

To add a Vagrant box to your project, copy the following files from the `puppet-modules` repository into your project repository:

* `Vagrantfile`
* `cnf/vagrant-puppet.yaml`

Ajust the values in `cnf/vagrant-puppet.yaml` to your needs, especially:

* `vagrantconf:name`: VM hostname
* `vagrantconf:domain`: VM domainname
* `vagrantconf:aliases`: VM aliases, use those to access your project with differnt (sub-) domains

Warning: Do not override the other settings within `vagrantconf` unless you know what you are doing


## Vagrant commands

```
vagrant up         # start VM
vagrant provision  # update Debian packages and Puppet modules
vagrant ssh        # connect trough SSH
vagrant halt       # stop VM
vagrant destroy    # delete VM
```


## Tips & tricks

 * load your SSH key into ssh-agent (VM has to access different repositorys with your key)
 * use Vagrant commands like `vagrant up` to control your VM only

