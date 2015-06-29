# Server Configuration

## Hiera Backend

By now, our servers are configured trough a YAML based [Hiera](https://docs.puppetlabs.com/hiera/1/) backend for Puppet. Depending on your access rights you are able to modify the whole configuration or only parts of the hierarchy such as domains or single servers.

Hierarchy:

 * common.yaml
  * common values used on all servers
  * here, you add values like global SSH keys or firewall rules
 * domain/common.yaml
  * common values used on all servers in this domain
  * here, you add domain specific values like dns resolver for a particular subnet
 * domain/fqdn.yaml
  * values used on this explicit server
  * here, you add server specific values such as websites


### Access

We will provide you access to the appropriate GIT repository to alter your configuration. Depending on your role you can add global or domain/server specific configurations.

Hint: This is a temporary solution only (see below).


### Outlook

We are working hard on a new, HTTP/REST based backend for Hiera. You will be able to alter server specific configurations such as websites trough this new API. In a first step, the API will be backed by the great [Swagger UI](http://petstore.swagger.io/), later on we will develop our own management interfaces which interacts with this API.


## Memory Ratio

To configure certain, memory-aware services, suche as memcached or Varnish, we use the so called `memory_ratio` parameter to calculate the amount of memory for a given service.

As basis, we take 80% of the servers total memory. This amount is then distributed trough the `memory_ratio` for a specific service.


### Examples

#### single Tomcat instance

 * Server with 4GB Memory
 * Tomcat Service, no others
 * Tomcat `memory_ratio` is `1` by default
 * Result: 4GB Memory * 80% = 3.2GB / 1 (ratio) = 3.2GB Memory for Tomcat

#### Tomcat instance among others

 * Server with 4GB Memory
 * Website Service, Tomcat Service
 * Tomcat `memory_ratio` manually set to `3`
 * Result: 4GB Memory * 80% = 3.2GB / 3 (ratio) = 1.07GB Memory for Tomcat
 
