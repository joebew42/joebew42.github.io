---
layout: post
title:  "It's time to go for a new laptop"
date:   2019-12-15 15:00:00 +0100
excerpt_separator: <!--more-->
---

The time has arrived and after almost seven years of really well served time of my previous laptop [^1], I finally decided to buy a new one. It's an [Acer Predator Helios 300](https://www.amazon.com/Acer-Predator-i7-9750H-Keyboard-PH315-52-78VL/dp/B07QXLFLXT), and as you can see it's a gaming laptop, which of course I will not use to play videogames. So, why this decision?

There are several reasons that led me to end up with this decision.

First of all, I think at my [adventure on Twitch](https://joebew42.github.io/twitch/about). It had an important weight to this decision, and I really enjoyed the experience of Live Coding on Twitch, and sooner or later I will resume it!

Other reason is due I started to create few screencasts about [Clean Coding, TDD and Refactoring](https://www.youtube.com/watch?v=pmoLmjirmTk) (more creations are expected to come in the future), and I would like to continue to follow this idea to create more contents (as live code streaming sessions, more screencasts, and even complete video series) about the discipline of Clean Code.

Apart from all this, it's also my intention to schedule periodic Pair Programming sessions with you all (_so, if you are interested in doing pair programming with me, let me know_).

And last but not least, I want to develop few ideas into real products. Yes, I will create few products of my own. What?!

So, in order to support all these initiatives I had to end up with a first investment that it got translated in buying a more powerful computer.

Here will follow the story in installing Ubuntu 19.10 as a replacement for Windows.

<!--more-->

## Yes, but, not Windows, please!

My preferred operating system is GNU/Linux and unfortunately, this laptop comes with a pre-installed copy of Windows 10. Damn, a malware!

Not so bad, let's fix it and install Ubuntu 19.10!

_Long story short, yes, it works!, Ubuntu 19.10 is working "quite" fine!_

My previous OS was Arch Linux but this time I decided to switch to Ubuntu 19.10 (easy to install, ready-to-go.)

Steps I followed to install Ubuntu 19.10:

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
- **I removed all the Windows related partitions, and decided to have only Ubuntu on this laptop, no dual-boot. So, from this point proceed at your own risk!**
- Once the installation is over, just restart the laptop :)

### 5. Post installation steps/issues

**Issue: [50-second hang each time I resume from a "deep" (suspend-to-RAM) sleep.](https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1850238)**

This seems to be an issue intoduced by the recent Linux Kernel 5.3 and NVIDIA drivers.

The `dmesg` log:

```
[mer dic 18 15:18:22 2019] nvme nvme0: 8/0/0 default/read/poll queues
[mer dic 18 15:19:12 2019] ucsi_ccg 0-0008: PPM NOT RESPONDING
[mer dic 18 15:19:12 2019] PM: dpm_run_callback(): ucsi_ccg_resume+0x0/0x20 [ucsi_ccg] returns -110
[mer dic 18 15:19:12 2019] PM: Device 0-0008 failed to resume: error -110
```

**Issue: System Clock is not updated after suspend**

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

**Issue: Touchpad is not working after suspend!**

After playing for a while with `modprobe`, I discovered that:

```
sudo modprobe -vr i2c_hid
sudo modprobe -v i2c_hid
```

Did the trick! Touchpad working again :)

There should be the way to automate this step when the laptop wakes up after the suspend, but I need to learn more about that. If you know how, please let me know.

### 6. Enjoy!

Everything seems fine except the suspend!

If you find something new or wants to add more information, contact me on Twitter [`@joebew42`](https://twitter.com/joebew42).

![Ubuntu 19.10 on Acer Predator Helios 300](/assets/ubuntu-19.10-on-acer-predator-helios-300.jpg)

_Ubuntu 19.10 on Acer Predator Helios 300_

[^1]: Lenovo T460U 2013 model.