# Caching

Install and manage different caching applications. By now, the following backends are supported:

 * memcached
 * Varnish


## memcached

To install memcached, add `memcached`  to the `caching::backend` hash.

### Memory Ratio

By default, a `memory_ratio` of 8 is used, which means memcached will take up to 1/8 of this servers total memory.

Hint: See [Memory Ratio](/server/configuration.md#Memory_Ratio) for details about memory ratio calculation

### Full example

```
caching::backend:
  "memcached":
    "ensure":       "present"
    "memory_ratio": "8"
```


## Varnish

To install Varnish, add `varnish`  to the `caching::backend` hash.


### address/address6

By default, Varnish will listen on the eth1 interface. If Varnish has to bind to other addresses, use the `address` and `address6` parameter to specify them.


### port/port6

By default, Varnish will listen on port 80. If Varnish has to bind to another port, use the `port` and `port6` parameter to specify them.


### vcl_type

With `vcl_type`, you choose a tempalte which is used by Varnish as default VCL configuration. By now, the following types are available:

 * `default`: Varnish default configuration which does not very much but is perfetly suitable for your own, custom configuration trough `vcl_include`
 * `typo3`: Varnish configuration for the `varnish` TYPO3 extension (see [Github](https://github.com/snowflakech/typo3-varnish/blob/master/res/default-4.vcl))


### vcl_include

With `vcl_include`, you can define a full path to a additional configuration file. This file gets included into the Varnish default configuration.

Hint: Keep in mind to issue a `puppet-agent` run after changing the local Varnish configuration. Puppet will copy your local configuration file to a global location and ensure that Varnish is able to read it.


### Memory Ratio

By default, a `memory_ratio` of 2 is used, which means Varnish will take up to 50% of this servers total memory.

Hint: See [Memory Ratio](/server/configuration.md#Memory_Ratio) for details about memory ratio calculation


### Full example

```
caching::backend:
  "varnish":
    "ensure":       "present"
    "address":      "185.17.68.153"
    "port":         "80"
    "address6":     "2a04:503:0:1003::153"
    "port6":        "80"
    "vcl_type":     "default"
    "vcl_include":  "/home/user/cnf/varnish.vcl"
    "memory_ratio": "4"
```
