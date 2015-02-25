# website


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


## Types

* Use Website types to create your suitable environment
   * typo3cms
      * MariaDB 10.x autocreated and environment set 
      * PHP-FPM 5.6 
      * nginx 1.6 with naxsi WAF (and TYPO3 white/blacklists)
      * TYPO3 6.2 cloned into /var/lib/typo3/
   * magento
      * MariaDB 10.x autocreated and environment set
      * PHP-FPM 5.6 with mcrypt module
      * nginx 1.6 with naxsi WAF (and magento white/blacklists)
   * wordpress
      * MariaDB 10.x autocreated and environment set
      * PHP-FPM 5.6 with mcrypt module
      * nginx 1.6 with naxsi WAF (and wordpress white/blacklists)
   * php (pure PHP e.g. for NoDB solutions)
      * use "dbtype": "mysql" to add a database
      * PHP-FPM 5.6 
      * nginx 1.6 with naxsi (and core rule set)
   * hhvm (Facebooks HHVM - BETA)
      * for high load sites (better performance then PHP-FPM)
      * with fallback to PHP-FPM 
      * needs intensive testing
      * stack: nginx 1.6, MariaDB 10.0, PHP-FPM, HHVM)
   * html (pure HTML, just static content) 
      * nginx 1.6 with naxsi (and core rule set)
   * other types on request (node.js, ruby etc.)

## TLS

* Add a TLS / SSL certificate over hiera and enable SPDY (automatically)
   * ssl_key: generated private key
   * ssl_cert: signed certificate with 2 intermediate certificates
   * please pay attention to the hiera format

## Environments

* There are 3 kinds of environments available: 
   * PROD
      * live sites only!
      * no htpasswd protection
      * error log level "quiet"
   * STAGE 
      * for stage / preview / testing access
      * htpasswd protected (htpasswd option with crypted string in hiera necessary)
      * phpinfo enabled
      * error log level "noisy"
   * DEV
      * for development
      * htpasswd protected (htpasswd option with crypted string in hiera necessary)
      * phpinfo enabled
      * error log level "noisy"

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

