# Access


## SSH

Your server is accessible trough SSH by default. We allow only key based logins
as non privileged user (no root Login). You can add global keys to your server
like this:

```
ssh::keys:
  "enduser":
    "contact@example.net":
      "key": "ssh-rsa AAAAB....."
```

Please use a valid contact address, so we are able to get in touch if something
comes up.

Additionaly, you can add custom environment variables to those keys. They get
applied on every SSH login:

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


## FTP

There is no FTP daemon installed by default. Please consider to use SSH/SCP
when possible. If you really need access by FTP, follow the instructions on
[Services > FTP](/services/ftp/).

