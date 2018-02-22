---
layout: post
title: Compiling net-snmp with lm_sensors support
categories:
- Administration
tags:
- ArchLinux
- snmp
- lm_sensors
- monitoring
comments: []
---

The official ArchLinux package for [net-snmp](http://www.net-snmp.org/) does not come with [lm_sensors](http://www.lm-sensors.org/) support, consequently the corresponding MIB is missing. Here is how to customize and compile the package to get sensors suppors.

We will use the [Arch Build System](https://wiki.archlinux.org/index.php/Arch_Build_System) (ABS) to first, install and run ABS to retrieve the PKGBUILD scripts from the Arch Linux repositories:

```shell
shell> pacman -S abs base-devel
# (edited, usual output)
shell> abs
# (edited, lots of output here)
```

Then copy the `net-snmpd` package to a custom location:

```shell
shell> cp -r /var/abs/extra/net-snmpd ~/abs_workspace
shell> cd ~/abs_workspace/net-snmp
```

Now edit the PKGBUILD and look for the line starting the flag `--with-mib-modules` and append `ucd-snmp/lmsensorsMib` to it. As of date, it is line #44 and the resulting line is:

```
--with-mib-modules="host misc/ipfwacc ucd-snmp/diskio tunnel ucd-snmp/dlmod ucd-snmp/lmsensorsMib" \
```

Now build the package and install it:

```shell
shell> makepkg -s --skippgpcheck
shell> pacman -U
shell> systemctl daemon-reload
shell> systemctl restart
```

Now for the test:

```shell
shell> snmpwalk -v 2c -c public localhost lmSensors
# following is just a sample of the line&nbsp;you should get:
LM-SENSORS-MIB::lmTempSensorsIndex.1 = INTEGER: 1
LM-SENSORS-MIB::lmTempSensorsDevice.1 = STRING: Physical id 0
LM-SENSORS-MIB::lmTempSensorsValue.1 = Gauge32: 33000
```

You may have notice I used the `--skippgpcheck` flag with `makepkg`. See [this post](http://allanmcrae.com/2015/01/two-pgp-keyrings-for-package-management-in-arch-linux/) for more information.</p>
