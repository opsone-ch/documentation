# Website Service

Our website module provides everything you need, to manage, deploy and run your website. It is type and environment based which means you have to select a particular type (e.g. typo3cms) and environment (e.g. PROD). According those settings, our automation will setup the server/vhost as required. 


## Add website

Add a website with a configuration like this:

```
website::sites: 
   "username":
    "server_name": "example.net www.example.net"
    "env":         "PROD"
    "type":        "php"
```

 * username: Is used as system user name (SSH Login, CGI User) and database nam, if a database exist
 * server_name: add host names which this vhost will listen on. You have to define all names explicit, also with and/or without www.
 * env: One of DEV, STAGE or PROD (see [Environments](index.md#Environments) below)
 * type: software type of this particular website (see [Types](index.md#Types) below)

By adding a website, the following parts are created on the server:

 * system user
 * system group
 * home directory (/home/username/)
 * directory for temporary files (/home/username/tmp/)
 * directory for log files (/home/username/log/)
 * directory for additional configuration files (/home/username/cnf/)
 * directory for backups (used for database dumps, /home/username/backup/)
 * environment variables for bash and zsh (~/.profile and ~/.zprofile)
 * SSH authorised keys
 * webserver vhost configuration (for custom configurations, see [Custom configurations](index.md#Custom_configurations) below


## Types

You have to define one of the following types for each website:


#### typo3cms 

* nginx 1.6 with naxsi WAF, core rule set and TYPO3 white/blacklists
* PHP-FPM 5.6 
* MariaDB 10.x with database, user, and grants
* TYPO3 CMS 6.2 cloned into /var/lib/typo3/TYPO3_6-2/

```
website::sites: 
   "examplenet":
    "password":    "1234"
    "server_name": "typo3.example.net www.typo3.example.net"
    "env":         "PROD"
    "type":        "typo3cms"
```


####  magento 

* nginx 1.6 with naxsi WAF, core rule set and magento white/blacklists
* PHP-FPM 5.6 with mcrypt module
* MariaDB 10.x with database, user, and grants

```
website::sites: 
   "magentoexample":
    "server_name": "magento.example.net"
    "env":         "PROD"
    "type":        "magento"
    "password":    "Aiw7vaakos04h7e"
```


#### wordpress

* nginx 1.6 with naxsi WAF, core rule set and wordpress white/blacklists
* PHP-FPM 5.6 with mcrypt module
* MariaDB 10.x with database, user, and grants

```
website::sites: 
   "wordpressexample":
    "server_name": "wordpress.example.net"
    "env":         "PROD"
    "type":        "wordpress"
    "password":    "Aiw7vaakos04h7e"
```


#### php 

* nginx 1.6 with naxsi WAF and core rule set
* PHP-FPM 5.6 
* MariaDB 10.x with database, user, and grants (use "dbtype": "mysql", otherwise without database)

```
website::sites: 
   "phpexamplenet":
    "server_name": "php.example.net"
    "env":         "PROD"
    "type":        "php"
```


#### hhvm

* nginx 1.6 with naxsi WAF and core rule set
* HHVM with PHP-FPM 5.6 fallback
* MariaDB 10.x with database, user, and grants (use "dbtype": "mysql", otherwise without database)
* please contact us to evaluate the feasibility within your project

```
website::sites: 
   "hhvmexamplenet":
    "server_name": "hhvm.example.net"
    "env":         "PROD"
    "type":        "hhvm"
    "dbtype":      "mysql"
    "password":    "ohQueeghoh0bath"
```

#### html


* nginx 1.6 with naxsi and core rule set
* for static content only (this documentation is served trough the html type)

```
website::sites: 
   "htmlexamplenet":
    "server_name": "html.example.net"
    "env":         "PROD"
    "type":        "html"
```

** Hint: ** If you need a type not mentioned here yet, do not hesitate to contact us.


## Environments

You have to select one of those environments for each website:


#### PROD

* live sites only
* no access protection
* phpinfo disabled (otherwise database credentials in environment variables could get leaked)
* quiet error log level


#### STAGE 

* for stage / preview / testing access
* password protected (User "preview", password from "htpasswd" option)
* phpinfo enabled
* debug error log level


#### DEV

* for development
* password protected (User "preview", password from "htpasswd" option)
* phpinfo enabled
* debug error log level


#### User Handling

The preview user gets applied to all non PROD environments and is intended for your own use, but also to allow access to other parties like your customer. Use the "htpasswd" option to set a particular password to the preview user. You have to use a htpasswd encrypted value which you can generate like this:

```
htpasswd -n preview
```

Configuration example: 

```
"devexamplenet":
    "type":        "typo3cms"
    "env":         "DEV"
    "server_name": "dev.example.net www.dev.example.net"
    "password":    "1234"
    "htpasswd":    "$apr1$RSDdas2323$23case23DCDMY.0xgTr/"
```

Furthermore, you can add additional users trough the "website::users" configuration like this:

```
website::users:
  "alice":
    "preview": "$apr1$RXDs3l18$w0VJrVN5uoU6DMY.0xgTr/"
  "bob":
    "preview": "$apr1$RSDdas2323$23case23DCDMY.0xgTr/"
```

You can add such uers for yourself and your co-workers. If you work on multiple websites, you do not have to look up the corresponding password all the time but just use the global one.

** Note: ** Please keep in mind that this password gets often transfered over unencrypted connections. As always, we recommend to use a particular password for only this purpose.


### Environment Variables

For each website, the following environment variables are created by default, and are available within the shell and also the webserver.

 * SITE_ENV (DEV, STAGE or PROD)
 * DB_HOST (Database hostname, only if there is a database)
 * DB_NAME (Database name, only if there is a database)
 * DB_USERNAME (Database username, only if there is a database)
 * DB_PASSWORD (Database password, only if there is a database)


Hint: to use the .profile environmnet within a cronjob, prepend the following code to your command:
/bin/bash -c 'source $HOME/.profile; ~/original/command'


#### Example usage within PHP

As soon there is a database installed, the following variables are added to the environment and can be used from within your application. TYPO3 Example:
```
$typo_db_username = $_SERVER['DB_USERNAME'];
$typo_db_password = $_SERVER['DB_PASSWORD'];
$typo_db_host     = $_SERVER['DB_HOST'];
$typo_db          = $_SERVER['DB_NAME'];
```

Additionaly, you can use the "SITE_ENV" variable to set parameters according the current environment:
```
switch ($_SERVER['SITE_ENV']) {
    case 'dev':
        $recipient = 'dev@example.net';
        break;
    case 'stage':
        $recipient = 'dev@example.net';
        break;
    case 'live':
        $recipient = 'customer@example.com';
        break;
}
```

If you configure your application like this, you can copy all data between different servers or vhosts (DEV/STAGE/PROD) and all settings are applied as desired.


## Deploy and launch

In the following section, do you find some hints how to deploy your website from DEV to STAGE and STAGE to PROD without troubles and a happy end-user:


#### Prepare your DNS 

First of all: make sure your Nameservers / DNS records are prepared. 
And you have access to the DNS management system. 

** Warning: ** Please set the TTL to a "modern" and flexible value for every record. We recommend "300" (5 minutes). 

There is no reason anymore, to cache the records for a long time (e.g. one day). 
So please do not switch back to a high TTL after going live. DNS requests to the nameservers do not create much load.


#### DEV => STAGE

There are two ways to deploy your site from DEV to STAGE:

* copy files / database to the existing STAGE environment
* renaming DEV to STAGE and copy the files afterwards back to the new DEV


#### Stage => PROD

There are also two ways to deploy your site from STAGE to PROD.

* copy files / database to the existing STAGE environment
* renaming STAGE to PROD, removing the htpasswd entry, copy the files afterwards back to the new STAGE


#### Copy


##### Filesystem sync (local)
 
Sync your filesystem local with rsync:

* exclude unneeded directories (e.g.. typo3temp)
* man rsync for detailed information

```
rsync -avz --exclude=typo3temp source/ destination/
```

##### Filesystem sync (remote to local) 

Sync your filesystem with a remote server:

```
rsync -avz --delete --exclude=typo3temp  example@example01.snowflakehosting.ch:www/ /path/to/your/local/www/source/
```

do not forget your local .git repo

##### Database copy (local)

Analyse your databse first, and then copy your DB local to another database:

```
SELECT table_name AS "Tables", 
round(((data_length + index_length) / 1024 / 1024), 2) "Size in MB" 
FROM information_schema.TABLES 
WHERE table_schema = "[DBNAME HERE]"
ORDER BY (data_length + index_length) DESC;
```
if there are large caching tables, search indexes etc. ignore this tables:

* --ignore-table=database.table

(for every table!)

also use the singe-transaction option:

* --single-transaction


```
mysqldump --single-transaction --ignore-table=exampledatabase.cache_pages --ignore-table=exampledatabase.cache_hash -uexampledatabaseuser -ppassword exampledatabase | mysql -uexampledatabase2 -ppassword2 exampledatabase2

```

** Warning: ** Do not forget to recreate the ignored tables with your application. 
With TYPO3 you can use: install tool => DB compare


##### Database copy (remote to local)

```
ssh example@example01.snowflakehosting.ch mysqldump --single-transaction --ignore-table=exampledatabase.cache_pages --ignore-table=exampledatabase.cache_hash -uexampledatabaseuser -ppassword exampledatabase | mysql -uexampledatabase2 -ppassword2 exampledatabase2

```
	

#### Testing

Please always test the website extensively. You can simulate a "live" Website with a local hostfile entry to "overrule" your ISPs DNS server.

#### Reverse Proxy

If you want to be sure, that no requests are delivered from the old server / website until all cusotmers DNS caches are refreshed, add an reverse proxy and load the new site over this proxy.

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


## TLS Certificates

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
     * webmaster@example.net
     * admin@
     * administrator@


#### Create and sign the certificate

use the following command to create the private key and .crt over openssl (linux / mac):

```
 openssl req -newkey rsa:2048 -x509 -nodes -days 3650 -out www.example.net.crt -keyout www.example.net.key
```

you need to enter the following data:

```
Country Name (2 letter code) [AU]:CH
State or Province Name (full name) [Some-State]:Zurich
Locality Name (eg, city) []:Zurich
Organization Name (eg, company) [Internet Widgits Pty Ltd]:SYNA
Organizational Unit Name (eg, section) []:
Common Name (eg, YOUR name) []:www.example.net
Email Address []:webmaster@… 
```

after that, you need to sign the certificate from the authority.
so you need to generate a certifcate signing request (CSR):

```
openssl x509 -x509toreq -signkey www.example.net.key -in www.example.net.crt
```

Submit this CRS to our [Support](/support.md) if you like a certificate from us.
Or even use every authority you want..


#### Add to hiera

* ssl_key: generated private key
* ssl_cert: signed certificate with 2 intermediate certificates

** Note: ** please pay attention to the hiera format

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

#### Test

Test your certificate with

* https://www.ssllabs.com/ssltest/
* https://ssltools.websecurity.symantec.com/checker/views/certCheck.jsp


## Web Application Firewall

We use [Naxsi](https://github.com/nbs-system/naxsi) as additional protection against application level attacks such as cross site-scripting or SQL injections. We also block common vulnerabilities and zero day attacks, see our [status site](http://status.snowflake.ch/) for updates.

Warning: this is just a additional security measure. Regardless its existence, remember to keep your application, extensions and libraries secure and up to date


### Identify blocks

If a request is blocked, the server will issue a "403 forbidden" error. There are detailed informations available in the error log file:

```
2015/02/17 14:03:04 [error] 15296#0: *1855 NAXSI_FMT: ip=192.168.0.22&server=www.example.net&uri=/admin/&learning=0&vers=0.53-1&total_processed=1&total_blocked=1&block=1&cscore0=$XSS&score0=8&zone0=BODY|NAME&id0=1310&var_name0=login[username]&zone1=BODY|NAME&id1=1311&var_name1=login[username], client: 192.168.0.22, server: www.example.net, request: "POST /admin/ HTTP/1.1", host: "www.example.net", referrer: "http://www.example.net/admin/"
```

To learn more about the log syntax, vist the [Naxsi Documentation](https://github.com/nbs-system/naxsi/wiki).


### Manage false positives

If you are certain, that your request to the application is valid (and well coded), you can whitelist the affected rule(s) within the ~/cnf/nginx_waf.conf File:

```
BasicRule wl:1310,1311 "mz:$ARGS_VAR:tx_sfpevents_sfpevents[event]|NAME";
BasicRule wl:1310,1311 "mz:$ARGS_VAR:tx_sfpevents_sfpevents[controller]|NAME";
```

See the [Naxsi Documentation](https://github.com/nbs-system/naxsi/wiki/whitelists) for details.

Hint: to apply the changes reload the nginx configuration with the "nginx-reload" shortcut

Hint: if you need assistance, do not hesitate to [contact us](/support.md). We are happy to help out!

Hint: we strongly recommend to add the ~/cnf/ directory to the source code management of your choice


### Autocreate rules

With nx_util, you can parse & analyze naxsi log files. It will propose appropriate whitelist rules tailored to your application

Warning: Use on DEV/STAGE Environment only. Otherwise you will end up whitelisting actual attacks.

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
BasicRule wl:1311 "mz:$URL:/events/event/|$ARGS_VAR:tx_sfpevents_sfpevents[controller]|NAME";
# total_count:2 (33.33%), peer_count:1 (100.0%) | [, possible js
BasicRule wl:1310 "mz:$URL:/events/event/|$ARGS_VAR:tx_sfpevents_sfpevents[controller]|NAME";
# total_count:1 (16.67%), peer_count:1 (100.0%) | ], possible js
BasicRule wl:1311 "mz:$URL:/events/event/|$ARGS_VAR:tx_sfpevents_sfpevents[event]|NAME";
# total_count:1 (16.67%), peer_count:1 (100.0%) | [, possible js
BasicRule wl:1310 "mz:$URL:/events/event/|$ARGS_VAR:tx_sfpevents_sfpevents[event]|NAME";

```





## Request limits

### Limits

The number of connections and requests are limited for saftey reasons to the following values:

* 25 conn. / IP
* 5 req. / sec. / IP
* 15 req. / sec. (burst)
* \>15 req. / sec. (access limited)

This means, that an IP can open up to 25 connections and do 5 requests / second.

If the IP does more than 5 req. /sec. the requests are delayed and other clients are served first. ("leaky bucket method")

If the IP creates more than 15req. /sec the webserver responds with the 503 status code ("service unavailable")


### Adjust limits 

To adjust this limits (e.g. for special applications such as API calls, etc), set a higher "load zone" in your local configuration (~/cnf/nginx.conf):

```
# connection limits (e.g. 50 connections)
limit_conn addr 50;

# limit requests / second: (small, medium, large)
#limit_req zone=medium burst=50;
limit_req zone=large burst=150;
```

** Hint: ** to apply the changes reload the nginx configuration with the "nginx-reload" shortcut

### Zones

* small = 5req / sec (burst: 15req/sec)
* medium = 15 req / sec (burst: 50 req/sec)
* large = 50 req / sec (burst: 150 req/sec)

** Note: ** the default zone is "small" and should fit for the most websites / users


## DNS Settings

All our servers and services are reachable by both IPv4 and IPv6.

Note: Please remember to add both A/AAAA DNS Records test both Protocols

Check DNS Records:
```
dig A www.example.net
dig AAAA www.example.net
```

Check HTTP:
```
wget -4 www.example.net
wget -6 www.example.net
```

For more information about our Dualstack Infrastructure, see the  [Dualstack](/server/dualstack.md) Site.


## File and Directory Permissions

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

## Custom vhost configuration

There is the possibility to add specific configurations like redircts in the users cnf/ directory and versioning / deploy them on every projects environment.

** Warning: ** You have to reload nginx after changes with the "nginx-reload" shortcut


### ~/cnf/nginx.conf

Configure specific redirects, enable gzip and other stuff directly in the nginx.conf. This file is included within the server block.

```
if ($http_host = www.example.net) {
	rewrite (.*) http://www.example.com;
}
```

### ~/cnf/nginx_waf.conf

Configure WAF exeptions here, see [Web Application Firewall](#Web_Application_Firewall) for details.


## GeoIP Module

To use your GeoIP database with nginx, store the appropriate data files on your server and add the following configuration:

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


## More options

There are many more things to configure, for example

   * manage SSH access keys
   * add additional services (Varnish, Memcache, Redis, many more)


## Delete website

Warning: This feature is currently work in process. By now, please contact us to delete a site

As a security measure, you have to define explicit that you want to delete a website:

```
website::sites: 
   "examplenet":
    "ensure": "absent"
```

As soon as "ensure" is set to "absent", all configurations and data related to this site gets removed at once. After the next configuration run, you can remove the whole part from the website::sites hash.


## Full Configuration Example

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
    "htpasswd":    "$apr1$RSDdas2323$23case23DCDMY.0xgTr/"
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

