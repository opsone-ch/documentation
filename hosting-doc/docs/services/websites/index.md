# Website

Our website module provides everything you need, to manage, deploy and run your website. It supports the following website types, helpers and additional services.

## Types

Use website types to create your suitable environment

####  typo3cms 
* MariaDB 10.x with database, user, grants and environment set
* PHP-FPM 5.6 
* nginx 1.6 with naxsi WAF (and TYPO3 white/blacklists)
* TYPO3 6.2 cloned into /var/lib/typo3/


```
website::sites: 
   "examplenet":
    "password":    "1234"
    "server_name": "typo3.example.net www.typo3.example.net"
    "env":         "PROD"
    "type":        "typo3cms"

```

####  magento 
* MariaDB 10.x autocreated and environment set
* PHP-FPM 5.6 with mcrypt module
* nginx 1.6 with naxsi WAF (and magento white/blacklists)


```
website::sites: 
   "magentoexample":
    "server_name": "magento.example.net"
    "env":         "PROD"
    "type":        "magento"
    "password":    "Aiw7vaakos04h7e"
```

#### wordpress
* MariaDB 10.x autocreated and environment set
* PHP-FPM 5.6 with mcrypt module
* nginx 1.6 with naxsi WAF (and wordpress white/blacklists)

```
website::sites: 
   "wordpressexample":
    "server_name": "wordpress.example.net"
    "env":         "PROD"
    "type":        "magento"
    "password":    "Aiw7vaakos04h7e"
```

#### php 
pure PHP e.g. for NoDB solutions

* use "dbtype": "mysql" to add a database
* PHP-FPM 5.6 
* nginx 1.6 with naxsi (and core rule set)

```
website::sites: 
   "phpexamplenet":
    "server_name": "php.example.net"
    "env":         "PROD"
    "type":        "php"
```

#### hhvm
Facebooks HHVM - BETA

* for high load sites (better performance then PHP-FPM)
* with fallback to PHP-FPM 
* needs intensive testing
* stack: nginx 1.6, MariaDB 10.0, PHP-FPM, HHVM)

```
website::sites: 
   "hhvmexamplenet":
    "server_name": "hhvm.example.net"
    "env":         "PROD"
    "type":        "php"
    "dbtype":      "mysql"
    "password":    "ohQueeghoh0bath"
```

#### html
pure HTML, just static content

* nginx 1.6 with naxsi (and core rule set)
* other types on request (node.js, ruby etc.)

```
website::sites: 
   "htmlexamplenet":
    "server_name": "html.example.net"
    "env":         "PROD"
    "type":        "html"

```

---


## Environments

You have to select one of those environments for each website:


#### PROD

* live sites only
* no access protection
* phpinfo disabled (otherwise database credentials in environment variables could get leaked)
* error log level "quiet"


#### STAGE 

* for stage / preview / testing access
* password protected (User "preview", password from htpasswd option)
* phpinfo enabled
* error log level "noisy"


#### DEV

* for development
* password protected (User "preview", password from htpasswd option)
* phpinfo enabled
* error log level "noisy"

#### User Handling

The preview user gets applied to all non PROD environments and is intended for
your own use, but also to allow access to other parties like your customer.

Furthermore, you can add additional users trough the "website::users"
configuration like this:

```
website::users:
  "alice":
    "preview": "$apr1$RXDs3l18$w0VJrVN5uoU6DMY.0xgTr/"
  "bob":
    "preview": "$apr1$RSDdas2323$23case23DCDMY.0xgTr/"
```

You can add users like this for yourself and your co-workers. If you work on
multiple websites, you dont have to look up the corresponding password all
the time but just use the global one.

Please keep in mind that this password gets often transfered over unencrypted
connections. As everywhere, we recommend to use a particular password for only
this purpose.

```
"devexamplenet":
    "password":    "1234"
    "server_name": "dev.example.net www.dev.example.net"
    "env":         "DEV"
    "htpasswd":    "iequ8eeL1Eish0F" 
    "type":        "typo3cms"
```


### Proxy

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
You do not have to configure the proxy in your application.


### Variables and usage

The definied websites are automatically setup with a practically environment. We create the following files / configurations regarding to your types and includes servcies:

##### .profile

The .profile file in the user home directory contains

* the users database credentials
* the users environment (DEV, STAGE, PROD)
* other stuff related / used by the installed services

This allows you / the user to access e.g. your MySQL database without entering the database credentials.
Simply type "mysql" in your shell and here we go!
It also provides the credentials for cronjobs etc.

sample .profile file:

```
export DB_USERNAME=examplenet
export DB_PASSWORD=xxx
export DB_HOST=localhost
export DB_NAME=examplenet
export SITE_ENV=live
```

to use the .profile in your cronjobs, simply set the following before your original stuff.

```
/bin/bash -c 'source $HOME/.profile; original cron;'
```
##### php environments

If there is a database installed, the credentials and environment are stored in the php environment.
To configure e.g. TYPO3 to use this settings, edit the localconf.php with the following:

```
$typo_db_username = $_SERVER['DB_USERNAME'];
$typo_db_password = $_SERVER['DB_PASSWORD'];
$typo_db_host     = $_SERVER['DB_HOST'];
$typo_db          = $_SERVER['DB_NAME'];
```

There is also the oppunity to access the "used environment" over SITE_ENV and configure the installation regarding to the used environement.
This example shows how you set the $recipient regarding to your env:
```
switch ($_SERVER['SITE_ENV']) {
    case 'dev':
        $recipient = 'entwicklung@snowflake.ch';
        break;
    case 'stage':
        $recipient = 'entwicklung@snowflake.ch';
        break;
    case 'live':
        $recipient = 'customer@example.com';
        break;
}
```

#### Deployment magic!

Sounds good, but why should I use it? 

The main reason to use this automatic created environment: deployment support.

1. add the configuration to your application
2. copy the installation with your favorite tool / script to e.g. from DEV to STAGE.
3. as you recognized right, you do not have to change your database credentials. 

There is also the possiblilty to change the hiera data "DEV => STAGE => PROD" and password and the website is still running without changing 
the applications database configuration.

You can also use it on your [Vagrant box](development/vagrant) locally.

---

## Deploy and launch

In the following section, will you find some hints to deploy your website from stage to prod without any troubles and a happy end-user:

#### Prepare your DNS 

First of all: your DNS / Nameservers should be prepared. 

Make sure, you have access to the DNS management system. 
Please always set the TTL to a "modern" value for every record which is affected. We recommend "300" (5 minutes). 

There is no reason anymore, to set high TTLs. So please do not switch back to a high TTL after going live. 
DNS requests to the nameservers do not create much load.

#### Stage > PROD

swithc the ENV entry or copy

#### Testing

always test the website extensively. You can simulate a "live" Website with a local hostfile entry to "overrule" your ISPs DNS server.

#### Reverse Proxy

If you want to be sure, that no requests are delivered from the old server / website until all cusotmers DNS are refreshed, add an reverse proxy and load the new site over this proxy.

This setup results in a new website which is immediately live and the end user always see the new site. Independently of that his DNS is up2date.

If your old site is using Apache, add this VirtualHost:


```
<VirtualHost 91.199.old.ip:80>
  ServerName example.com
  ServerAlias www.example.com
  ErrorLog "/path/to/log/error.log"
  CustomLog "/path/to/log/access.log" combined

	ProxyRequests		Off
	ProxyPreserveHost	On
	ProxyPass		/ http://91.199.new.ip/
</VirtualHost>

``` 

## Certificates (TLS)

#### Overview

Create a TLS/SSL certificate for your website and add it over hiera.
This automatically enables:


* SPDY 3.1
* TLS 1.0, 1.1, 1.2
* SNI
* HSTS
* Monitoring for the certificate
* Grade A at ssllabs.com

and it also creates the following redirect from http to https:

```
    rewrite ^ https://$server_name$request_uri? permanent;
```

you still want to use http separately? 
There is no reason.


We have 3 supported types of certificates:

* Basic
* Wildcard
* Extended validation

#### Requirements 

* Valid eMail account to validate the domain ownership:
     * webmaster@domain.ch
     * admin@
     * administrator@


#### Create and sign the certificate

use the following command to create the private key and .crt over openssl (linux / mac):

```
 openssl req -newkey rsa:2048 -x509 -nodes -days 3650 -out www.domain.ch.crt -keyout www.domain.ch.key
```

you need to enter the following data:

```
Country Name (2 letter code) [AU]:CH
State or Province Name (full name) [Some-State]:Zurich
Locality Name (eg, city) []:Zurich
Organization Name (eg, company) [Internet Widgits Pty Ltd]:SYNA
Organizational Unit Name (eg, section) []:
Common Name (eg, YOUR name) []:www.domain.ch
Email Address []:webmaster@… 
```

after that, you need to sign the certificate from the authority.
so you need to generate a certifcate signing request (CSR):

```
 openssl x509 -x509toreq -signkey www.domain.ch.key -in www.domain.ch.crt
```

Submit this CRS to our [Support](../support/) if you like a certificate from us.
Or even use every authority you want..


#### Add to hiera

* ssl_key: generated private key
* ssl_cert: signed certificate with 2 intermediate certificates

 please pay attention to the hiera format

```
website::sites: 
   "magentoexample":
    "server_name": "magento.example.net"
    "env":         "PROD"
    "type":        "magento"
    "password":    "Aiw7vaakos04h7e"
    "ssl_key": |
     -----BEGIN PRIVATE KEY-----
     MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDRHc47/0zg+cAg
     MkHKY1U7TOFChPawiNmU94MYjOTzK/Lc4C2op1sDCAP4Ow+qx7BK8NLJkHUPyOXU
     zjTTTUN/dGoElGz4gFaCCkMhk8hRZEs8jTwAm8tq4ruUVk9DIgQ9K/potm5kzT/T
     KyW85hETMLi+tRw9Kbn/j4QljWmqcd4mPWyaMT1o4lDTszq7NCHGch+dxa4FJYib
     z05C6+BVpw9w+BWFERlbgG5hvMMXtxexlju24e2fJV/TPCVbgDk/ecFDhupRMdj9
     ZKrlPcUZNReWxgX+ZGT8YfWI2tYfW9+H6iVvcwV2gftiDp4+N4r4Ae52cMFxcKBR
     5fn4i8hbAgMBAAECggEAYv66MBr3GRYChvtju9z0b2NAzE3HvuC6KFRYAlpI1Hl8
     umWCF/JKGpBD2NKU4yMvaPrCvtsdH8DaVLjdtx4/kunYepyNTcLrsRoMl6uvTCCv
     oVW3Dw6x6MK3TEzjrwM+gHr+S235qsyjp2MotVkwwiXxf46bdLT5MWuOgnyEhkQQ
     cmv6qDmjgDP5vH5r4riAlPKMq+jGtLc/2QWs22UxQS0/a7n0pks472AonLI8r1M8
     sYcCAC6uEvxRZdVcJOlRK78dPI3NLxFhSbvv/GcVOypyhvQ3uVYV71xA/AgcpBLd
     Fc2FULRCCU/UEjmo62uYNkG09lCchBwK8BLYYWrCoQKBgQDqL5Eo9oLMTuzysu8I
     vemXODOTfxQb1OTH1dyA4kSAtmNF2IO5rNnvVsS5YlbSjZMEXRMYTSflp7L7ae2l
     XLqjhijdB6l5cdgsPyHD2phYOvJzWMuzjkCtIjm5QfdMfsUZnBSPbwaRF1zWxbVn
     mHlWi3Zcu8U65l9gsJviZelqqwKBgQDkmG4W1SEySON4i44JwzsmXQHP1d8KHES1
     hB1IETNYV2HzIAWnnX/fqPwqyahzegKTGut9U7kJ8QHsHvz56nHdiQ8zw4BZxQPw
     j4Pms1IpzpO48yf4swskqwgkk5W6wTHCD/Q48tqFtAMPwC/D88F966ipc6lyldsJ
     UXvLeeMZEQKBgGTHYZWaOAGKOYfcHufJKnwMEI350wKDJI0m6ISCWu51DtWg7lb6
     HrNTyMbqnehwSoNHNo9vrKq0914gYMeX1y3F71HnGTSNHHU2Gea57HOTsoCXBtpX
     blfTcbnavHyr1VBHDcYIBnBr+GTooj9Zq2XmEGKp35+QQh1PA1ZzevaPAoGASdop
     Lv06VVmRC9/iSqslT/aaYEATZ9vMIuyE3USZVwAcKAT/brCGoIaiuVwfLPeNH2OC
     EyJaVKjlWxiD2GXy1YSzQaD2tYneBPkIvx7N+62+sfD0x/doMTeEUPTRWd2SqsSm
     vUNQcAPBPXR0uhTlPT5GZkB0zQ03D6KgoRNG2FECgYEAgXPJjIsqhcC0PNEuRgdC
     9pZq+Prvp4TniVwQKyPniw/FjAplI4uN/+1fiYPexaLzINnXUuvOTYPABec3T2DZ
     GV0lffmdZ+CleU1Xi5DjLGn8m0Gdy6mecE2Le9/Q13o3owF9rm0Drhqqd8T6vVt3
     hiw7C+lCp2XheqP+QchwxiY=
     -----END PRIVATE KEY-----
    "ssl_cert": |
     -----BEGIN CERTIFICATE-----
     MIIEATCCAumgAwIBAgIJAMdVCMOVZl30MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYD
     VQQGEwJDSDEPMA0GA1UECAwGWnVyaWNoMQ8wDQYDVQQHDAZadXJpY2gxIzAhBgNV
     BAoMGnNub3dmbGFrZSBwcm9kdWN0aW9ucyBHbWJIMRowGAYDVQQDDBF0eXBvMy5l
     eGFtcGxlLm5ldDEkMCIGCSqGSIb3DQEJARYVd2VibWFzdGVyQGV4YW1wbGUubmV0
     MB4XDTE1MDIxMjEyMDU1MloXDTI1MDIwOTEyMDU1MlowgZYxCzAJBgNVBAYTAkNI
     MQ8wDQYDVQQIDAZadXJpY2gxDzANBgNVBAcMBlp1cmljaDEjMCEGA1UECgwac25v
     d2ZsYWtlIHByb2R1Y3Rpb25zIEdtYkgxGjAYBgNVBAMMEXR5cG8zLmV4YW1wbGUu
     bmV0MSQwIgYJKoZIhvcNAQkBFhV3ZWJtYXN0ZXJAZXhhbXBsZS5uZXQwggEiMA0G
     CSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDRHc47/0zg+cAgMkHKY1U7TOFChPaw
     iNmU94MYjOTzK/Lc4C2op1sDCAP4Ow+qx7BK8NLJkHUPyOXUzjTTTUN/dGoElGz4
     gFaCCkMhk8hRZEs8jTwAm8tq4ruUVk9DIgQ9K/potm5kzT/TKyW85hETMLi+tRw9
     Kbn/j4QljWmqcd4mPWyaMT1o4lDTszq7NCHGch+dxa4FJYibz05C6+BVpw9w+BWF
     ERlbgG5hvMMXtxexlju24e2fJV/TPCVbgDk/ecFDhupRMdj9ZKrlPcUZNReWxgX+
     ZGT8YfWI2tYfW9+H6iVvcwV2gftiDp4+N4r4Ae52cMFxcKBR5fn4i8hbAgMBAAGj
     UDBOMB0GA1UdDgQWBBSSJyPyLa8CNKMDR3BAOcuuzzEqlTAfBgNVHSMEGDAWgBSS
     JyPyLa8CNKMDR3BAOcuuzzEqlTAMBgNVHRMEBTADAQH/MA0GCSqGSIb3DQEBCwUA
     A4IBAQAMKv2Kdw2LkskJm/GAkEsavoYf6qAPruwcsp8cx+7doXOpptZ/w+m8NK8i
     6ffi65wQ4TGlFxEvXM1Ts4S1xF/+6JVnnp8RVGvfgDL7xi6juMqbtM5yBxjHKO6W
     AuxOmwPcd6cO5qL+MCSgIe13bn/V4bw/JLv9LONuwXHJuv0FEoazbSyB6uTwYf2D
     pWHEkXvkz5A1hqu3y2jFq2cQffoO31GGx29U3uSl+Esp5bL/J0bQd3TUbwvu6FY1
     NgUR7Mx1t/4/uk9FRl87d2rRslc5VyvD5v7MFE6jYJap74j5BrrfUUTNbzVXdPCS
     v8jOaIjDp5AMoZxbPMlv/5Tk85uF
```

---

## Web Application Firewall (WAF)

#### Naxsi

Our WAF is based on the opensource, high performance WAF for Nginx called "Naxsi".
It protects your webapplication from XSS & SQL Injection attacks. 
And also blocks common vulnerabilities & zero day attacks as far as possibly (visit status.snowflake.ch for more information)

** Warning: ** the WAF is just a security feature. Please remember to code secure and keep your application and the used 3rd party extensions up 2 date!

#### 403 forbidden / Firewall blocks / false positives

If a request to your application is blocked by naxsi, you will see a "403 forbidden" error.
There is also a detailed log/error.log entry provided - e.g. the following:

```
2015/02/17 14:03:04 [error] 15296#0: *1855 NAXSI_FMT: ip=91.199.98.29&server=www.domain.ch&uri=/admin/&learning=0&vers=0.53-1&total_processed=1&total_blocked=1&block=1&cscore0=$XSS&score0=8&zone0=BODY|NAME&id0=1310&var_name0=login[username]&zone1=BODY|NAME&id1=1311&var_name1=login[username], client: 91.199.98.29, server: www.domain.ch, request: "POST /admin/ HTTP/1.1", host: "www.domain.ch", referrer: "http://www.domain.ch/admin/"
```
To learn more about the log syntax, vist the [Naxsi wiki](https://github.com/nbs-system/naxsi/wiki)

#### mange false positives

If you are sure, that your request to the application is valid (and well coded..) you can whitelist the "false positive". 
Normaly we recommend to test an application on the stage environment and analyze afterwards the error.log with the nx_util:

##### nx_util

```
/usr/local/bin/nx_util.py -lo error.log  

Deleting old database :naxsi_sig
List of imported files :['error.log']
Importing file error.log
	Successful events :6
	Filtered out events :0
	Non-naxsi lines :0
	Malformed/incomplete lines 5
End of db commit... 
Count (lines) success:6
########### Optimized Rules Suggestion ##################
# total_count:2 (33.33%), peer_count:1 (100.0%) | ], possible js
BasicRule wl:1311 "mz:$URL:/snowflake-komponenten/events/event/|$ARGS_VAR:tx_sfpevents_sfpevents[controller]|NAME";
# total_count:2 (33.33%), peer_count:1 (100.0%) | [, possible js
BasicRule wl:1310 "mz:$URL:/snowflake-komponenten/events/event/|$ARGS_VAR:tx_sfpevents_sfpevents[controller]|NAME";
# total_count:1 (16.67%), peer_count:1 (100.0%) | ], possible js
BasicRule wl:1311 "mz:$URL:/snowflake-komponenten/events/event/|$ARGS_VAR:tx_sfpevents_sfpevents[event]|NAME";
# total_count:1 (16.67%), peer_count:1 (100.0%) | [, possible js
BasicRule wl:1310 "mz:$URL:/snowflake-komponenten/events/event/|$ARGS_VAR:tx_sfpevents_sfpevents[event]|NAME";

```


This tool processes your .log files and generates "whitelist rule suggestions". 
Please pay attention to the "suggestions" part and do not copy/paste "blindly" the whitelists!

##### apply whitelists

If you are sure, that your whitelists are correct, can you add the whitelists at:
    
```
cnf/nginx_waf.conf
```

and reload your webserver with:

```
nginx-reload
```

If you are not sure, that your whitelists are correct. Please contact our [Support](../support/). We are happy to help you out!

##### optimize your whitelists

Please remember, that you can "beautify" the whitelists. The generated whitelists above, would result in the following rules:

```
BasicRule wl:1310,1311 "mz:$ARGS_VAR:tx_sfpevents_sfpevents[event]|NAME";
BasicRule wl:1310,1311 "mz:$ARGS_VAR:tx_sfpevents_sfpevents[controller]|NAME";
```

If you like to understand the naxsi whitelist syntax, please visit the [maintainers github wiki](https://github.com/nbs-system/naxsi/wiki/whitelists)

##### Version control

We strongly recommend the versioning of the cnf/ directory in your (git) project. 
So you can easily track your changes and deploy the WAF rules always with your project to DEV / STAGE / PROD.

## IPV6 enabled / DNS

Every hosting is "IPV6 enabled". Please remember to add the DNS IPV6 AAAA records and testing them:

```
wget -4 www.snowflake.ch
wget -6 www.snowflake.ch

dig A www.snowflake.ch @ns.snowflakehosting.ch
dig AAAA www.snowflake.ch @ns.snowflakehosting.ch
```

more information about our [IPV6 Dualstack Infrastructure](../server/dualstack)


## Permissions

* Goals
    * Users cannot access each others Directory Structure
    * PHP is executed with User privileges
    * Webserver (User www-data) can access static Files for each User
* User and Groups
    * for every Website, a User and Group with the same Name is created
    * the www-data User is Member from every Group
* File Owner and Permissions
    * Owner of all Files and Folders in /home/<user>/ is the corresponding User and Group
    * Permissions should be 0640 (0750) for public readable static Files such as Images or CSS
    * to enhance Security, Files and Directories can be owned by root:<usergroup> as long as PHP Processes dont need write access to them.

----

## Custom configs

There is the possibility to add specific configurations like redircts in the users cnf/ directory and versioning / deploy them on every projects environment.
Do not forget to reload nginx after changes:

```
nginx-reload
```

#### cnf/nginx.conf

Configure specific redirects, enable gzip and other stuff directly in the nginx.conf.
This file is included in the server block. e.g.

```
if ($http_host = www.domain.ch) {
	rewrite (.*) http://www.domain.com;
}
```

#### cnf/nginx_waf.conf

[Configure naxsi whitelists](#web-application-firewall-waf)

## GeoIP Module

To use your GeoIP database with nginx, store your .dat files on the server and include the module with hiera:

```
# GeoIP Settings for nginx
nginx::http_cfg_append:
  - "geoip_country	/home/user/geoip/GeoIPv6.dat"
  - "geoip_city	/home/user/geoip/GeoLiteCityv6.dat"

# GeoIP related environment variables
environment::variables:
  "GEOIP_ADDR":         "$remote_addr"
  "GEOIP_ADDR":         "$remote_addr"
  "GEOIP_COUNTRY_CODE": "$geoip_country_code"
  "GEOIP_COUNTRY_NAME": "$geoip_country_name"
  "GEOIP_REGION":       "$geoip_region"
  "GEOIP_REGION_NAME":  "$geoip_region_name"
  "GEOIP_CITY":         "$geoip_city"
  "GEOIP_AREA_CODE":    "$geoip_area_code"
  "GEOIP_LATITUDE":     "$geoip_latitude"
  "GEOIP_LONGITUDE":    "$geoip_longitude"
  "GEOIP_POSTAL_CODE":  "$geoip_postal_code"
```


## Other settings and options

* There are many things you can configure over hiera (Load modules, set options etc.)
   * manage SSH Keys
   * add modules (e.g. Varnish, Memcache, Redis)
   * set firewall rules 



## Hiera Example

```
website::sites: 
   "examplenet":
    "password":    "1234"
    "server_name": "typo3.example.net www.typo3.example.net"
    "env":         "PROD"
    "type":        "typo3cms"
   "devexamplenet":
    "password":    "1234"
    "server_name": "dev.example.net www.dev.example.net"
    "env":         "DEV"
    "htpasswd":    "iequ8eeL1Eish0F"
    "type":        "typo3cms"
   "phpexamplenet":
    "server_name": "php.example.net"
    "env":         "PROD"
    "type":        "php"
   "hhvmexamplenet":
    "server_name": "hhvm.example.net"
    "env":         "PROD"
    "type":        "php"
    "dbtype":      "mysql"
    "password":    "ohQueeghoh0bath"
   "htmlexamplenet":
    "server_name": "html.example.net"
    "env":         "PROD"
    "type":        "html"
   "magentoexample":
    "server_name": "magento.example.net"
    "env":         "PROD"
    "type":        "magento"
    "password":    "Aiw7vaakos04h7e"
    "ssl_key": |
     -----BEGIN PRIVATE KEY-----
     MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDRHc47/0zg+cAg
     MkHKY1U7TOFChPawiNmU94MYjOTzK/Lc4C2op1sDCAP4Ow+qx7BK8NLJkHUPyOXU
     zjTTTUN/dGoElGz4gFaCCkMhk8hRZEs8jTwAm8tq4ruUVk9DIgQ9K/potm5kzT/T
     KyW85hETMLi+tRw9Kbn/j4QljWmqcd4mPWyaMT1o4lDTszq7NCHGch+dxa4FJYib
     z05C6+BVpw9w+BWFERlbgG5hvMMXtxexlju24e2fJV/TPCVbgDk/ecFDhupRMdj9
     ZKrlPcUZNReWxgX+ZGT8YfWI2tYfW9+H6iVvcwV2gftiDp4+N4r4Ae52cMFxcKBR
     5fn4i8hbAgMBAAECggEAYv66MBr3GRYChvtju9z0b2NAzE3HvuC6KFRYAlpI1Hl8
     umWCF/JKGpBD2NKU4yMvaPrCvtsdH8DaVLjdtx4/kunYepyNTcLrsRoMl6uvTCCv
     oVW3Dw6x6MK3TEzjrwM+gHr+S235qsyjp2MotVkwwiXxf46bdLT5MWuOgnyEhkQQ
     cmv6qDmjgDP5vH5r4riAlPKMq+jGtLc/2QWs22UxQS0/a7n0pks472AonLI8r1M8
     sYcCAC6uEvxRZdVcJOlRK78dPI3NLxFhSbvv/GcVOypyhvQ3uVYV71xA/AgcpBLd
     Fc2FULRCCU/UEjmo62uYNkG09lCchBwK8BLYYWrCoQKBgQDqL5Eo9oLMTuzysu8I
     vemXODOTfxQb1OTH1dyA4kSAtmNF2IO5rNnvVsS5YlbSjZMEXRMYTSflp7L7ae2l
     XLqjhijdB6l5cdgsPyHD2phYOvJzWMuzjkCtIjm5QfdMfsUZnBSPbwaRF1zWxbVn
     mHlWi3Zcu8U65l9gsJviZelqqwKBgQDkmG4W1SEySON4i44JwzsmXQHP1d8KHES1
     hB1IETNYV2HzIAWnnX/fqPwqyahzegKTGut9U7kJ8QHsHvz56nHdiQ8zw4BZxQPw
     j4Pms1IpzpO48yf4swskqwgkk5W6wTHCD/Q48tqFtAMPwC/D88F966ipc6lyldsJ
     UXvLeeMZEQKBgGTHYZWaOAGKOYfcHufJKnwMEI350wKDJI0m6ISCWu51DtWg7lb6
     HrNTyMbqnehwSoNHNo9vrKq0914gYMeX1y3F71HnGTSNHHU2Gea57HOTsoCXBtpX
     blfTcbnavHyr1VBHDcYIBnBr+GTooj9Zq2XmEGKp35+QQh1PA1ZzevaPAoGASdop
     Lv06VVmRC9/iSqslT/aaYEATZ9vMIuyE3USZVwAcKAT/brCGoIaiuVwfLPeNH2OC
     EyJaVKjlWxiD2GXy1YSzQaD2tYneBPkIvx7N+62+sfD0x/doMTeEUPTRWd2SqsSm
     vUNQcAPBPXR0uhTlPT5GZkB0zQ03D6KgoRNG2FECgYEAgXPJjIsqhcC0PNEuRgdC
     9pZq+Prvp4TniVwQKyPniw/FjAplI4uN/+1fiYPexaLzINnXUuvOTYPABec3T2DZ
     GV0lffmdZ+CleU1Xi5DjLGn8m0Gdy6mecE2Le9/Q13o3owF9rm0Drhqqd8T6vVt3
     hiw7C+lCp2XheqP+QchwxiY=
     -----END PRIVATE KEY-----
    "ssl_cert": |
     -----BEGIN CERTIFICATE-----
     MIIEATCCAumgAwIBAgIJAMdVCMOVZl30MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYD
     VQQGEwJDSDEPMA0GA1UECAwGWnVyaWNoMQ8wDQYDVQQHDAZadXJpY2gxIzAhBgNV
     BAoMGnNub3dmbGFrZSBwcm9kdWN0aW9ucyBHbWJIMRowGAYDVQQDDBF0eXBvMy5l
     eGFtcGxlLm5ldDEkMCIGCSqGSIb3DQEJARYVd2VibWFzdGVyQGV4YW1wbGUubmV0
     MB4XDTE1MDIxMjEyMDU1MloXDTI1MDIwOTEyMDU1MlowgZYxCzAJBgNVBAYTAkNI
     MQ8wDQYDVQQIDAZadXJpY2gxDzANBgNVBAcMBlp1cmljaDEjMCEGA1UECgwac25v
     d2ZsYWtlIHByb2R1Y3Rpb25zIEdtYkgxGjAYBgNVBAMMEXR5cG8zLmV4YW1wbGUu
     bmV0MSQwIgYJKoZIhvcNAQkBFhV3ZWJtYXN0ZXJAZXhhbXBsZS5uZXQwggEiMA0G
     CSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDRHc47/0zg+cAgMkHKY1U7TOFChPaw
     iNmU94MYjOTzK/Lc4C2op1sDCAP4Ow+qx7BK8NLJkHUPyOXUzjTTTUN/dGoElGz4
     gFaCCkMhk8hRZEs8jTwAm8tq4ruUVk9DIgQ9K/potm5kzT/TKyW85hETMLi+tRw9
     Kbn/j4QljWmqcd4mPWyaMT1o4lDTszq7NCHGch+dxa4FJYibz05C6+BVpw9w+BWF
     ERlbgG5hvMMXtxexlju24e2fJV/TPCVbgDk/ecFDhupRMdj9ZKrlPcUZNReWxgX+
     ZGT8YfWI2tYfW9+H6iVvcwV2gftiDp4+N4r4Ae52cMFxcKBR5fn4i8hbAgMBAAGj
     UDBOMB0GA1UdDgQWBBSSJyPyLa8CNKMDR3BAOcuuzzEqlTAfBgNVHSMEGDAWgBSS
     JyPyLa8CNKMDR3BAOcuuzzEqlTAMBgNVHRMEBTADAQH/MA0GCSqGSIb3DQEBCwUA
     A4IBAQAMKv2Kdw2LkskJm/GAkEsavoYf6qAPruwcsp8cx+7doXOpptZ/w+m8NK8i
     6ffi65wQ4TGlFxEvXM1Ts4S1xF/+6JVnnp8RVGvfgDL7xi6juMqbtM5yBxjHKO6W
     AuxOmwPcd6cO5qL+MCSgIe13bn/V4bw/JLv9LONuwXHJuv0FEoazbSyB6uTwYf2D
     pWHEkXvkz5A1hqu3y2jFq2cQffoO31GGx29U3uSl+Esp5bL/J0bQd3TUbwvu6FY1
     NgUR7Mx1t/4/uk9FRl87d2rRslc5VyvD5v7MFE6jYJap74j5BrrfUUTNbzVXdPCS
     v8jOaIjDp5AMoZxbPMlv/5Tk85uF
     -----END CERTIFICATE-----

```

