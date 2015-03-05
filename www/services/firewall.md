# Firewall Service

Note: This site belongs to the IP firewall. There is also a web application firewall which is described within the [website service](/services/website.md#Web_Application_Firewall)


## Default settings

By default, all incoming and outgoing traffic is blocked, expect the following:

 * related or established connections
 * ICMP/ICMPv6
 * Traceroute
 * SSH


## Custom rules trough service

Where applicable, all services add the approriate firewall rules automatically, for example:

 * website module will allow HTTP/HTTPS
 * mysql type in database module will allow mysql from admin server


## Custom rules

You can also add custom rules like this:

```
base::firewall::rules:
  "020 accept Puppet to puppetmaster":
    "port":         "8140"
    "destination":  "192.168.0.22"
    "destination6": "2001:db8::22"
  "021 accept HTTP to Package Server":
    "port":         "80"
    "destination":  "192.168.0.21"
  "040 accept incoming HTTP":
    "chain":        "INPUT"
    "port":         "80"
```

Where applicable, both IPv4 and IPv6 Rules are added by default (For example INPUT chains for a particular Port).

Warning: Try your best to avoid such custom rules. For outgoing connections, use our Proxy Servers instead (see below)


## Outgoing proxy

Outgoing requests of all kind are blocked due to safety reason.

Server within the snowflakehosting.ch Zone can use the provided Proxy to Access external Resources:

```
proxy.snowflakehosting.ch:80
```

This proxy is already configured trough global Environment Variables for both System and Webserver.

Hint: Make sure to use curl within PHP which will respect those Variables by default

