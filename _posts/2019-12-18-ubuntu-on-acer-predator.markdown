---
layout: post
title:  "Installing Ubuntu 19.10 on Acer Predator Helios 300"
date:   2019-12-18 15:00:00 +0100
---

These are steps I followed to install Ubuntu 19.10 on the [Acer Predator Helios 300]({% post_url 2019-12-15-time-for-a-new-laptop %}). I'll go through some of the issues I've encountered and their workarounds. To you who are reading this blog, I hope you'll find something useful and interesting. Cheers!

_Long story short, yes, it works! Ubuntu 19.10 is running fine..._

**Before proceeding:** _Consider to follow these steps at your own risk, replacing a pre-installed operating system may void the warranty of the laptop._

### 1. Download [Ubuntu 19.10 Desktop](http://releases.ubuntu.com/19.10/)

### 2. Create a USB Bootable Flash Drive:

`dd if=~/Downloads/ubuntu-19.10-desktop-amd64.iso of=/dev/sdb bs=4M`

_In my case the flash drive was attached to /dev/sdb._

### 3. Change BIOS settings of the Acer Predator Helios 300

- Turn the laptop on.
- At boot press `F2` and enter the BIOS Setup.
- Go to the `security` tab and set the BIOS Password (this is needed for the next step.)
- Go to the `boot` tab and disable the `Secure Boot`.
- Go to the `system` tab and switch `RST Premium Mode` to `AHCI Mode` (this will allow the Ubuntu Installer to recognize the SSD).
- Save the changes, press `F10` and reboot.

### 4. Install Ubuntu 19.10

- Insert the USB Flash Drive
- While the computer is booting press `F12`
- Choose `Try Ubuntu without installing (safe graphics)`
- Once Ubuntu is started, be sure you have an Internet connection (so that during the installation process it will fetch all the updates)
- Press the icon `Install` (remember to check the boxes to install the third-party and proprietaries drivers, they are needed for the NVIDIA video card.)
- **I removed all the Windows related partitions, and chose to have only Ubuntu on this laptop, no dual-boot!**
- Once the installation is over, just restart the laptop :)

### 5. Post installation Issues

#### [50-second hang each time I resume from a "deep" (suspend-to-RAM) sleep.](https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1850238)

This seems to be an issue intoduced by the recent Linux Kernel 5.3 and NVIDIA drivers.

The `dmesg` log:

```
[mer dic 18 15:18:22 2019] nvme nvme0: 8/0/0 default/read/poll queues
[mer dic 18 15:19:12 2019] ucsi_ccg 0-0008: PPM NOT RESPONDING
[mer dic 18 15:19:12 2019] PM: dpm_run_callback(): ucsi_ccg_resume+0x0/0x20 [ucsi_ccg] returns -110
[mer dic 18 15:19:12 2019] PM: Device 0-0008 failed to resume: error -110
```

A [temporary solution](https://askubuntu.com/questions/1155263/new-install-desktop-ubuntu-19-04-shows-error-message-ucsi-ccg-0-0008-failed-to) is to blacklist the **ucsi_ccg** kernel module. Create a file like `/etc/modprobe.d/blacklist-ucsi-ccg.conf`:

```
blacklist ucsi_ccg
```

Restart the computer and the 50 seconds hang is gone!


#### System Clock is not updated after suspend

I noticed that after the suspend, the system clock is not getting updated.

Some strange messages from the `dmesg` says:

```
[10353.568820] Restarting tasks ... done.
[10353.578325] PM: Possible incorrect RTC due to pm_trace, please use 'ntpdate' or 'rdate' to reset it.
[10353.638335] PM: suspend exit
```

I had to [install `chrony`](https://vitux.com/keep-your-clock-sync-with-internet-time-servers-in-ubuntu/):

`sudo apt-get install chrony`

And after the suspend I have to re-sync the date time manually, with:

```
sudo chronyd -q
```

#### Touchpad is not working after suspend

After playing for a while with `modprobe`, I discovered that:

```
sudo modprobe -vr i2c_hid
sudo modprobe -v i2c_hid
```

Did the trick! Touchpad working again :)

There should be the way to automate this step when the laptop wakes up after the suspend, but I need to learn more about that. If you know how, please let me know.

### 6. Enjoy!

If you find something new or wants to add more information, contact me on Twitter [`@joebew42`](https://twitter.com/joebew42).

![Ubuntu 19.10 on Acer Predator Helios 300](/assets/ubuntu-19.10-on-acer-predator-helios-300.jpg)

_Ubuntu 19.10 on Acer Predator Helios 300_

[^1]: Lenovo T460U 2013 model.