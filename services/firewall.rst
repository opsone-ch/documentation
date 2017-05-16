Firewall Service
================

.. note:: This site belongs to the IP firewall. There is also a web application firewall which is described within :doc:`website`

Default settings
----------------

By default, all incoming and outgoing traffic is blocked, expect the
following:

-  related or established connections
-  ICMP/ICMPv6
-  Traceroute
-  SSH

Custom rules trough service
---------------------------

Where applicable, all services add the approriate firewall rules
automatically, for example:

-  website module will allow HTTP/HTTPS
-  mysql type in database module will allow mysql from admin server

Custom rules
------------

You can also add custom rules.

Where applicable, both IPv4 and IPv6 Rules are added by default (For
example INPUT chains for a particular Port).

Warning: Try your best to avoid such custom rules. For outgoing
connections, use our Proxy Servers instead (see below)

Allow
~~~~~

::

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

Deny
~~~~

You can add custom rules to deny services, too:

::

    base::firewall::rules:
      "020 deny HTTP because we want to force a secure site with HTTPS only":
        "chain":  "INPUT"
        "port":   "80"
        "action": "reject"

Hint: HTTP(S) nginx rules are numbered 040 so you must use a lower
number for your rule to be processed before the default allow all from
nginx-configuration

Outgoing proxy
--------------

Outgoing requests of all kind are blocked due to safety reason.

Server within the snowflakehosting.ch Zone can use the provided Proxy to
Access external Resources:

::

    proxy.snowflakehosting.ch:80

This proxy is already configured trough global Environment Variables for
both System and Webserver.

Hint: Make sure to use curl within PHP which will respect those
Variables by default

Example usage
~~~~~~~~~~~~~

TYPO3
^^^^^

To configure the TYPO3 CMS to take advantage of the proxy, set the
following option in your LocalConfiguration.php or
AdditionalConfiguration.php:

::

    /*
     * Set http proxy if available 
     */

    if ($_SERVER['http_proxy'] && strlen($_SERVER['http_proxy']) > 1) {
        $GLOBALS['TYPO3_CONF_VARS']['SYS']['curlProxyServer'] = $_SERVER['http_proxy'];
        $GLOBALS['TYPO3_CONF_VARS']['HTTP']['proxy_host'] = parse_url($_SERVER['http_proxy'], PHP_URL_SCHEME).'://'.parse_url($_SERVER['http_proxy'], PHP_URL_HOST);
        $GLOBALS['TYPO3_CONF_VARS']['HTTP']['proxy_port'] = parse_url($_SERVER['http_proxy'], PHP_URL_PORT);
        $GLOBALS['TYPO3_CONF_VARS']['HTTP']['proxy_user'] = parse_url($_SERVER['http_proxy'], PHP_URL_USER);
        $GLOBALS['TYPO3_CONF_VARS']['HTTP']['proxy_password'] = parse_url($_SERVER['http_proxy'], PHP_URL_PASS);
    }

Please also remember to enable the usage of cURL in your conf vars sys
section:

::

    'curlUse' => '1'

Hint: don\`t forget to use the TYPO3 getURL() and other core functions
in your custom build extensions. Otherwise the proxy settings do not
work.

Magento
^^^^^^^

To configure Magneto to use the proxy, set the following options in your
downloader/lib/Mage/HTTP/Client/Curl.php file:

::

    protected function makeRequest($method, $uri, $params = array(), $isAuthorizationRequired = false, $https = true)
        {
            $uriModified = $this->getModifiedUri($uri, $https);
            $this->_ch = curl_init();
            $this->curlOption(CURLOPT_PROXY, "http://proxy.snowflakehosting.ch:80");
            $this->curlOption(CURLOPT_URL, $uriModified);
            $this->curlOption(CURLOPT_SSL_VERIFYPEER, false);
            $this->curlOption(CURLOPT_SSL_VERIFYHOST, 2);
            $this->getCurlMethodSettings($method, $params, $isAuthorizationRequired); 
           ...
        }

And if you use Zend, set the following options in:
lib/Zend/Http/Client/Adapter/Proxy.php

::

    class Zend_Http_Client_Adapter_Proxy extends Zend_Http_Client_Adapter_Socket
    {
        /**
         * Parameters array
         *
         * @var array
         */
        protected $config = array(
            'ssltransport'  => 'ssl',
            'sslcert'       => null,
            'sslpassphrase' => null,
            'sslusecontext' => false,
            'proxy_host'    => 'http://proxy.snowflakehosting.ch',
            'proxy_port'    => 80,
            'proxy_user'    => '',
            'proxy_pass'    => '',
            'proxy_auth'    => Zend_Http_Client::AUTH_BASIC,
            'persistent'    => false
        );
    ...
    }

Wordpress
^^^^^^^^^

To configure Wordpress to use the proxy, set the following options in
your wp-config.php file:

::

    define('WP_PROXY_HOST', 'proxy.snowflakehosting.ch');
    define('WP_PROXY_PORT', '80');
    define('WP_PROXY_BYPASS_HOSTS', 'localhost');

Debugging
---------

Logged in as user ``devop``, you can diagnose created rules and logs
trough the following means:

-  Firewall logs in ``/var/log/messages``
-  show created rules with ``sudo iptables -L`` / ``sudo ip6tables -L``
