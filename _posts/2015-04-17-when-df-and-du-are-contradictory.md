---
layout: post
title: When df and du are contradictory
tags:
- Linux
- Filesystems
---

I encountered a situation today where _du_ reported a usage of 2.9M whereas _df_ reported a occupation of 34G.

```
shell> df -h
Filesystem Size Used Avail Use% Mounted on
/dev/sdc1  40G  34G  3.5G   91% /var/log/httpd

shell> pwd; du -hs
/var/log/httpd
2.9M .
```

After some research I find out that _df_ take into account currently open files, even if they have been deleted by another application in the meantime.

```
shell> lsof | grep "/var/log/httpd"
httpd.wor 30576 root 19w REG 8,33 6854529 48 /var/log/httpd/internetfr-error_log-20150403 (deleted)
# [troncated]
```

Reloading Apache HTTPd resolved the situation, as it closed deleted files' descriptor.

```
shell> df -h
Filesystem Size Used Avail Use% Mounted on
/dev/sdc1  40G    3M 39.9G   1% /var/log/httpd
```