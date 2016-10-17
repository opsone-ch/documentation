# Access

The following ways are provided to access your server and files.

## SSH

Warning: due to security reasons, we allow key based logins only

Your server is accessible trough SSH by default. We allow only key based logins as non privileged user (no root Login).


### Generic `devop` user

On all servers, a user named `devop` is created by default. This user is required to execute the `puppet-agent` shortcut as long as there are no other services/users configured. Furthermore, this user belongs to the `adm` group which enable access to all system log files in `/var/log/`.


### Shortcuts and sudo configuration

Depending on the installed services, the following shortcuts might be available to execute certain commands with root privileges:

* `puppet-agent`: trigger puppet agent run
* `nginx-reload`: reload nginx webserver
* `nginx-restart`: restart nginx webserver
* `fpm-reload`: reload PHP-FPM daemon
* `fpm-restart`: restart PHP-FPM daemon
* `uwsgi-reload`: reload uwsgi daemon
* `uwsgi-restart`: restart uwsgi daemon
* `varnish-reload`: reload Varnish daemon
* `varnish-restart`: restart Varnish daemon
* `nodejs-restart`: restart current nodejs daemon
* `nodejs-start`: start current nodejs daemon
* `nodejs-stop`: stop current nodejs daemon
* `tomcat8-reload`: reload Tomcat daemon
* `tomcat8-restart`: restart Tomcat daemon
* `docker-restart`: restart Docker daemon
* `elastic-start`: start elasticsearch daemon
* `elastic-stop`: stop elasticsearch daemon
* `elastic-restart`: restart elasticsearch daemon
* `elastic-force-reload`: force-reload elasticsearch daemon


### Key Handling

You can add global keys to your server like this:

```
ssh::keys:
  "enduser":
    "contact@example.net":
      "key": "ssh-rsa AAAAB....."
```

Please use a valid contact address, so we are able to get in touch if something comes up.

Additionaly, you can add custom environment variables to those keys. They get applied on every SSH login:

```
ssh::keys:
  "enduser":
    "contact@example.net":
      "environment":
        "EDITOR":              "/usr/bin/vi"
        "GIT_AUTHOR_NAME":     "Bob"
        "GIT_AUTHOR_EMAIL":    "bob@example.net"
        "GIT_COMMITTER_NAME":  "Bob"
        "GIT_COMMITTER_EMAIL": "bob@example.net"
      "key": "ssh-rsa AAAAB....."
```

### Create SSH Key

* use 4096 bit RSA Keys
* encrypt with PKCS8

```
ssh-keygen -b 4096 -C user@domain.ch -f ~/.ssh/id_rsa_tmp
openssl pkcs8 -topk8 -v2 des3 -in ~/.ssh/id_rsa_tmp -out ~/.ssh/id_rsa
mv ~/.ssh/id_rsa_tmp.pub ~/.ssh/id_rsa.pub
rm ~/.ssh/id_rsa_tmp 
```

### SSH client configuration

Add client configurations to `/etc/ssh/ssh_config` by setting the `ssh::config` hash:

```
ssh::config:
  "Host":     "git"
  "HostName": "code.example.com"
  "User":     "git"
```

Hint: use `man ssh_config` ([online version](http://man.openbsd.org/ssh_config) for available configuration options


### SFTP

After adding your publickey to the server, is it possible to connect over SFTP.
We recommend to use one of the following clients:

* [Filezilla](https://filezilla-project.org)
* [Cyperduck](https://cyberduck.io)

Hint: To store your key in the memory and not having to enter the password for every connection -  use pagent (Windows) or ssh-add it (Linux)


## FTP

There is no FTP daemon installed by default. Please consider to use SSH/SCP when possible. If you really need access by FTP, follow the instructions on [Services > FTP](/services/ftp.md).

