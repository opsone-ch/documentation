# Deploy Applications 

To deploy your application to your DEV, STAGE, PROD environment, follow the following docs.
If you like to "Go Live" with your STAGE environment - please continue [here](deployment.md#Go_Live).

Hint: we're happy to support you with an automatic deployment process. Feel free to contact us!

## Deploy to your server 

First of all, make sure that you've configured and installed your favorite services. (e.g. website, tomcat, caching etc)
In the following documentation we're talking about [website](../services/website.md) deployments.

Warning: Always make sure, that you're using an appropriate username. Don't use confusing names like "examplestage" for PROD envs etc.

### Deploy your files

#### Git

We recommend to use Git to deploy your website to your server. Feel free to clone your repository - your server is prepared:

* access to github.com is allowed (use firewall rules for other repos)
* git is installed

Hint: We're also able to host a Git environment for you or even offer consulting to introduce Git in you company / agency. (contact us for more information)

If you don't use git, there is the possiblity to copy the files over the "oldschool" way with rsync:

#### Copy files

Login into the old website / environment and issue this command:

```
rsync -avz --exclude=typo3temp ~/ newuser@server:~/
```

This will copy the complete home directory to the remote users home. 


Hint: use appropriate exclude patterns to ignore all not required files

Hint: depending on the nature of your version control, you can skip all or most of this manual copy, but just checkout your project into the new website

Note: we use always SSH to copy files, even on the same server. This ensures that all files and directories belong to the appropriate user

### Deploy your database

#### Copy database

Login into the old environment and issue this command:

```
mysqldump --single-transaction --ignore-table=exampledatabase.cache_pages --ignore-table=exampledatabase.cache_hash -uexampledatabaseuser -ppassword exampledatabase | ssh newuser@server mysql -unewdatabase -ppassword newdatabase
```

Hint: Skip big and not required tables with the "--ignore-table" parameter


##### Identify big tables

```
SELECT table_name AS "tables", 
round(((data_length + index_length) / 1024 / 1024), 2) "Size in MB" 
FROM information_schema.TABLES 
WHERE table_schema = "<dbname>"
ORDER BY (data_length + index_length) DESC;
```

Warning: You have to create those ignored tables manually on the new website afterwards.


## Deploy between environments

If you've your site ready on the "DEV" or "STAGE" environment, there are two options to switch / deploy between different environments:

* switch environment on an existing website in your [configuration](../server/configuration.md)
* create a new website with the desired environment setting, copy files (and database)

### Switch environment

With this option, you just change the environment for a particular website, for example from STAGE to PROD. If the former environment is still required, you have to add a new website and copy all data back, we recommend to use the second method by default.

* rename "env" value from "DEV" or "STAGE" to "PROD"
* remove "htpasswd" value which is not required anymore

Warning: dont use confusing names like "examplestage" and set the env to "PROD"


### New website, copy data (recommended)

With this option, you just add another website with the desired environment and copy all files (and database) into the new website. Please see [deploy to your server](../development/deployment.md#Deploy_to_your_server)

## Go Live

### Testing

First of all, make sure everything is in place as desired. Always simulate productive calls to the application by adding all involved host names to your local hosts file. If you expect heavy usage, carry out load tests beforehand.

Hint: We are happy to assist you with architecture, sizing and load tests


### DNS Records

Note: set a low TTL value in DNS beforehand. We recommend to use "300" always


#### Lookup addresses

Connect to your server and note both IPv4 and IPv6 address:

```
$ facter ipaddress ipaddress6
ipaddress => 192.168.0.99
ipaddress6 => 2001:db8::99
```

#### Add records

Add DNS records within the DNS server of your choice.

```
example.net.     A       192.168.0.99
example.net.     AAAA    2001:db8::99
www.example.net. A       192.168.0.99
www.example.net. AAAA    2001:db8::99
```

Note: always add both A/AAAA DNS Records. Even if you have no IPv6 connectivity yet, others will, and IPv6 usage will spread

Hint: for more information about our dualstack infrastructure, see the  [Dualstack](/server/dualstack.md) Site.


#### Check records

Right after you changed the records, you should query your dns server and compare the returned values against those from your lookup before:

```
dig A www.example.net @nameserver
dig AAAA www.example.net @nameserver
```

#### Check HTTP

At last, check HTTP access for both IPv4 and IPv6 protocol to make sure everything went fine:

```
wget -4 www.example.net
wget -6 www.example.net
```


### Reverse Proxy

If you want to make sure, that the old server/website wont deliver any requests anymore at all, add a reverse proxy on the old server which redirects all traffic to the new server. With this setup, you can switch servers without the uncertainties of the global DNS System.

If your old site is using Apache, add this virtual host:

```
<VirtualHost 192.168.0.22:80>
  ServerName        example.net
  ServerAlias       www.example.net
  ErrorLog          /path/to/error.log
  CustomLog         /path/to/access.log combined
  ProxyRequests     Off
  ProxyPreserveHost On
  ProxyPass         / http://new.host.name/
</VirtualHost>
```
