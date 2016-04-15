# E-Mail

Webservers are not allowed to send mails directly, instead they will be delivered over mailrelay.snowflakehosting.ch.

Hint: Within PHP, only e-mails on "PROD" environments are sent. See [Development > E-Mail Handling](/development/email.md) for details.

## SPF Record

Good secured mail services will discard mails sent from hosts which are not paricularly allowed to, eventhough the default behaviour is to accept every mail. To explicitly allow our mailrelay to send mails from your domain you need to add an SPF record to your DNS zone.

```
example.com.              3600     IN      TXT     "v=spf1 mx a:mailrelay.snowflakehosting.ch"
```

Warning: Please make shure to include all other servers that should be able to send mails from your domain.

## TYPO3

### Mailer Daemon
To be able to send mails from our webservers you have to use 'mail' as mailer daemon. Use the following snippet in your TYPO3 config:

```
'MAIL' => array (
	'transport' => 'mail',
),
```

### Mail Forms

Configure the mail formular fields as described here:

* From: must be static and should contain a valid mail address of your domain.
* Reply-To: set this filed to 'mail' to use the form fillers mail address.

Warning: Always check wether the form filler is a human. Sooner or later every mail form without check will be used to send spam.

## Symfony
To use the standard swift-mailer in your symfony application, you have to adapt the parameters to:
```
parameters:
    mailer_transport: mail
```
