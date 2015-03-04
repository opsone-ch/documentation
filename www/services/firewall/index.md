# Firewall

## Default settings

## Custom rules trough service

## Custom rules

## Outgoing proxy

Direct outgoing HTTP and HTTPS requests are blocked for safety reason (do not load PHP shells etc).
But you can access the web over the pre-configured http/https proxy: proxy.snowflakehosting.ch

This proxy is configured for the whole server including php.
e.g. if you wget / curl an external site / file, the request is handled over the proxy:

```
wget www.google.com
--2015-02-27 10:28:47--  http://www.google.com/
Resolving proxy.snowflakehosting.ch (proxy.snowflakehosting.ch)... 91.199.98.56, 91.234.160.27
Connecting to proxy.snowflakehosting.ch (proxy.snowflakehosting.ch)|91.199.98.56|:80... connected.
Proxy request sent, awaiting response... 302 Found

```
** Hint: ** You do not have to configure the proxy in your application. It is autoconfigured.

