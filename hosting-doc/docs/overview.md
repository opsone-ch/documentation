# snowflake Hosting Generation 201501

https://code.snowflake.ch/wiki/Hosting/Puppet#Generationen


## Submodules

```
git subtree pull --prefix modules/apt https://github.com/puppetlabs/puppetlabs-apt.git master --squash
git subtree pull --prefix modules/apache https://github.com/puppetlabs/puppetlabs-apache.git master --squash
git subtree pull --prefix modules/postgresql https://github.com/puppetlabs/puppetlabs-postgresql.git master --squash
git subtree pull --prefix modules/puppetdb https://github.com/puppetlabs/puppetlabs-puppetdb.git master --squash
git subtree pull --prefix modules/inifile https://github.com/puppetlabs/puppetlabs-inifile.git master --squash
git subtree pull --prefix modules/concat https://github.com/puppetlabs/puppetlabs-concat.git master --squash
git subtree pull --prefix modules/nginx https://github.com/jfryman/puppet-nginx.git master --squash
git subtree pull --prefix modules/stdlib https://github.com/puppetlabs/puppetlabs-stdlib.git master --squash
git subtree pull --prefix modules/msmtp https://github.com/example42/puppet-msmtp.git master --squash
git subtree pull --prefix modules/puppi https://github.com/example42/puppi.git master --squash
git subtree pull --prefix modules/php https://github.com/jippi/puppet-php.git master --squash
git subtree pull --prefix modules/vcsrepo https://github.com/puppetlabs/puppetlabs-vcsrepo.git master --squash
git subtree pull --prefix modules/firewall https://github.com/puppetlabs/puppetlabs-firewall.git master --squash
git subtree pull --prefix modules/varnish https://github.com/camptocamp/puppet-varnish.git master --squash
git subtree pull --prefix modules/rabbitmq https://github.com/puppetlabs/puppetlabs-rabbitmq.git master --squash
git subtree pull --prefix modules/mailcatcher https://github.com/actionjack/puppet-mailcatcher.git master --squash
git subtree pull --prefix modules/ruby https://github.com/puppetlabs/puppetlabs-ruby.git master --squash
```


## Vagrant 

### Requirements

* SSH
* GIT
* LXC
* Vagrant
* Vagrant Plugins

```
vagrant plugin install vagrant-cachier
vagrant plugin install hostmanager
vagrant plugin install vagrant-lxc
```

### Usage

```
vagrant up --provider=lxc
vagrant provision
vagrant halt
vagrant destroy 
```

### Data

* see puppet-data/common.yaml

