# Vagrant for Web Developers

## Overview

** Note: ** This Repository is intended as template. You can either just start a Vagrant Machine from here or copy the appropriate Files into your desired Project.

** Warning: ** Please be aware that currently snowflake Vagrant Support is considered as beta, there might be some drawbacks.

---

## Requirements

* VTx enabled CPU
    * NOTE: Supported on all snowflake Hardware
* Vagrant
    * http://www.vagrantup.com/downloads.html
* Vagrant Plugins
    * NOTE: Add the Vagrant Plugins with these 2 shell commands
    
```
vagrant plugin install vagrant-cachier
vagrant plugin install vagrant-hostmanager
```
* VirtualBox
    * https://www.virtualbox.org/wiki/Downloads
    * IMPORTANT: Currently only Version 4.3.12 is working http://download.virtualbox.org/virtualbox/4.3.12/VirtualBox-4.3.12-93733-Win.exe
* GIT
    * http://git-scm.com/download/win
    * set "Configuring the line ending conversions" to "Checkout as-is, commit Unix-style endings"
    * NOTE: Already installed and configured on snowflake Hardware
    * IMPORTANT: Version 1.7.11 is required due to server dependencies
* SSH
    * a OpenSSH formatted private Key is required in the .ssh Subdirectory at your Windows Home Folder
    * if your current Key is PuTTY formatted (\*.ppk), convert it with PuTTY Key Generator
* Access to the Puppet Modules Repository
    * ssh://git@gate.snowflake.ch/h/puppet-modules.git

---

## Usage

* clone ssh://git@gate.snowflake.ch/h/vagrant-webdev.git somewhere to your local machine
* check Values in Vagrantfile, especially the name and aliases. All other values should be fine
    * NOTE: Name of your Vagrantbox which should be unique, for example the customer name. Aliases represents the Domains which are automatically added to your host file in order to access your Vagrantbox
* use GIT Bash for all Shell related Actions
 * SSH Key (OpenSSH formatted) has to be in C:\Users\<name>\.ssh\

```
eval $(ssh-agent)
ssh-add
```
* common Actions
    * NOTE: Can be used anywhere in your Vagrantbox folder

```
vagrant up			# start virtual Machine
vagrant provision		# update Debian Packages and Puppet Modules
vagrant ssh -- -l webdev	# connect as Webserver-User
vagrant halt			# stop virtual Machine
vagrant destroy 		# delete virtual Machine
```

## Own Projects
To use Vagrant in your own Project you have to copy and adjust

* Vagrantfile
* .gitignore
* vagrant/puppet-data/common.yaml
* vagrant/puppet-data/hiera.yaml
* vagrant/puppet-data/default.pp
* vagrant/update-puppet.sh

---

## Dos and Don'ts
* Don't start your virtual machine in the VirtualBox GUI. Use *vagrant up* instead
* Don't forget to add your ssh key

---

## FAQ
* What are the DB credentials?
	* DB_NAME: webdev
    * DB_HOST: localhost
    * DB_USERNAME: webdev
    * DB_PASSWORD: sfpdev0
* Can I connect to de VirtualBox via Putty?
    * currently not
* How can I access phpMyAdmin?
    * Just use www.example.com/phpmyadmin on your local domain

---
	
## Known problems
* sometimes, Debian Packes and Puppet Modules are missing after firt run due to dependencies on other Modules which are loaded later on. Just use *vagrant provision* to run the update a second time. 
