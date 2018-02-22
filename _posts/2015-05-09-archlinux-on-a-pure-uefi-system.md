---
layout: post
title: ArchLinux on a pure UEFI system
tags:
- UEFI
- Linux
- ArchLinux
- GPT
---

Installing ArchLinux in UEFI _native_ mode is surprisingly simple. Here are the steps I followed.

Quoting Wikipedia: [UEFI](https://en.wikipedia.org/wiki/Unified_Extensible_Firmware_Interface) is a software interface between an operating system and platform firmware. UEFI is meant to replace the Basic Input/Output System (BIOS) firmware interface, originally present in all IBM PC-compatible personal computers.

This post describe a setup without GRUB:

- The Linux kernel is directly loaded by firmware
- In case of dual boot, the OS selection is done from the UEFI user interface

# Motherboard configuration

The [Compatibility Support Module (CSM)](http://en.wikipedia.org/wiki/Unified_Extensible_Firmware_Interface#CSM_booting) can be disabled as the resulting system will boot _natively_ into UEFI.

[SecureBoot](http://en.wikipedia.org/wiki/Unified_Extensible_Firmware_Interface#Secure_boot) must allow unsigned kernel to boot. On my system (a Maximus VI Gene), the setting is called _OS Type_, and I set i to _Other OS_.

# Partitionning / file systems

The partition table must be a [GUID Partition Table (GPT)](http://en.wikipedia.org/wiki/GUID_Partition_Table), instead of a msdos legacy partition table. 

The program and configuration files necessary to start the system must reside in a dedicated partition, called the [EFI System partition (ESP)](http://en.wikipedia.org/wiki/EFI_System_partition). The ESP must have partition type _EFI system_ (C12A7328-F81F-11D2-BA4B-00A0C93EC93B) set in the GPT. It must be FAT formatted yet the variant is up to you: FAT12/16/32. 

To simplify the partition scheme, i’m also using the ESP for /boot. So 512M is good. The rest of the partitioning is up to you. Using fdisk, which now supports GPT:

```
bash> fdisk /dev/sda

fdisk> g
Created a new GPT disklabel (GUID: ABC02D92-4420-4998-A39B-B39257341D68).
fdisk> n
Partition number (1-128, default 1): 1
First sector (2048-500118158, default 2048): 
Last sector, +sectors or +size{K,M,G,T,P} (2048-500118158, default 500118158): +512M

Created a new partition 1 of type 'Linux filesystem' and of size 512 MiB.
fdisk> t
Selected partition 1 Hex code (type L to list all codes): 1 
Changed type of partition 'Linux filesystem' to 'EFI System'. 

fdisk> w
fdisk> q

bash> mkfs.fat -F32 -nEFI /dev/sda1
bash> mkfs.ext4 -LROOT /dev/sda2
```

# Installation

Installation as usual, see the [official Installation Guide](https://wiki.archlinux.org/index.php/Installation_guide) for more information. Following are only the relevant commands:

```
mount /dev/sda2 /mnt/
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot/
pacstrap /mnt base
genfstab -U -p /mnt >> /mnt/etc/fstab
arch-chroot /mnt
```

# Boot config

UEFI doesn’t rely on the [Master Boot Record (MBR)](http://en.wikipedia.org/wiki/Master_boot_record) and it is able to read the ESP FAT filesystem autonomously, so there is no need for things like GRUB stage1/1.5 in the final setup.

The only configuration yet to do is to create a boot entry in the EFI non-volatile memory. This entry tells the UEFI system which file to load and execute from the ESP.

```
pacman -S efibootmgr
efibootmgr -c -l /vmlinuz-linux -u "root=/dev/sda2 initrd=/initramfs-linux.img"
```

# Final steps

Reboot your system. You’ll find a Linux entry in the boot selection menu of your motherboard. Selecting it would boot ArchLinux. Enjoy!