# Vagrant

We rely on Vagrant to create local VMs for your purposes. You can use those Vagrant boxes to develop your application, but also to make changes at our Puppet environment itself.


## OS Support

Right now we support Vagrant on Ubuntu Linux (LXC Provider), Windows 10 (VirtualBox Provider) and Mac OS (VirtualBox Provider).


### Mac OS

* VirtualBox
* Files reside on host and get mounted into VM trough NFS


### Ubuntu Linux

* LXC
* Files reside on host and get mounted into VM trough NFS

### Windows 10

* VirtualBox (Make sure using the latest stable version - at the time of writing tested with 5.0.x)
* File mount currently not supported (Use SSH deployment instead) 

## Requirements

* [VT-x enabled CPU](http://en.wikipedia.org/wiki/X86_virtualization#Intel-VT-x)
* working [VirtualBox](https://www.virtualbox.org/) (Mac OS/Windows 10) or [LXC](https://linuxcontainers.org/) (Ubuntu) installation
* [Vagrant](http://www.vagrantup.com/downloads.html)
* NFS server daemon (pre-installed on Mac OS X, "nfs-kernel-server" package on Ubuntu)
* (Ubuntu only) AppArmor configuration for LXC mounts in `/etc/apparmor.d/lxc/lxc-default`
```
profile lxc-container-default flags=(attach_disconnected,mediate_deleted) {
...
  mount options=(rw, bind),
...
}
```
* (Ubuntu only) additional LXC configuration `/etc/lxc/default.conf`
```
lxc.network.type = veth
lxc.network.link = lxcbr0
lxc.network.flags = up
```
* (Temporarily) manually implement the following change until it's merged into vagrant:
```
https://github.com/mitchellh/vagrant/pull/5986/files
```
* Vagrant Plugins
Vagrant plugins should be installed without sudo (Ubuntu only)
```
vagrant plugin install vagrant-hostmanager   # required to access VM trough name/aliases
vagrant plugin install vagrant-cachier
vagrant plugin install vagrant-lxc           # Ubuntu only
```
* [GIT](https://git-scm.com/)
* SSH Key loaded into ssh-agent (Windows 10: Pageant for PuTTY)
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
vagrant ssh-config # output valid SSH configuration
```


## Tips & tricks

 * Symlink your cache- and lock-folders into your guest's `/tmp/` folder after first provision to significantly inprove performance of the guest 
 * load your SSH key into ssh-agent (VM has to access different repositorys with your key)
 * use Vagrant commands like `vagrant up` to control your VM only
 * there is no centralized database management tool available. Read the [corresponding article](https://snowflakehosting.ch/#!services/database.md#Access) to know how to connect anyhow
 * Git bash for Windows provides agent forwarding support & doesn't need to run in administrator mode

## Fixes and Workarounds for known problems

 * Error during start because of NFS-Issues (e.g. Deleted Projects): empty the file `/etc/exports` on your host-machine.
 * cannot connect to VM: check your host's `/etc/hosts` for duplicated entries
 * MySQL-Error during first provisioning: just let vagrant finish and then do a `vagrant reload --provision`
 * If you are unable to install vagrant-hostmanager try installing zlib1g-dev first with
```
sudo apt-get install zlib1g-dev
```
