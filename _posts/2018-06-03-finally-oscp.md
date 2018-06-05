---
layout: post
title: Finally, OSCP!
description: OSCP review with tips for literate pentesting with Emacs and Org-mode
image: public/posts/finally-oscp/offsec-say-tryharder.png
---

My last few months were full of adrenaline, insomnia and fun, provided by the [Offsec team](https://offensive-security.com) (creators and maintainers of the Kali Linux distro) and their [PWK course](https://www.offensive-security.com/information-security-training/penetration-testing-training-kali-linux/). There are many reviews of the course (my favorites being [this one](http://buffered.io/posts/oscp-and-me/) and [this other one](https://blog.g0tmi1k.com/2011/07/pentesting-with-backtrack-pwb/)), and it looks like it's my turn to add to this informal tradition of writing yet another "I'm an OSCP!" blog post.

# The course #

![You'll be hearing that...a lot]({{ site.url }}/public/posts/finally-oscp/offsec-say-tryharder.png "You'll be hearing that...a lot")

The course is comprised of two parts: a PDF with accompanying videos showing the tools of the trade, and a lab full of targets to hack. The written/video material is very good, and shows the most well-known tools a pentester should be acquainted with, plus a few tricks here and there (I particularly enjoyed the discussion on uploading files with Windows built-ins).

These materials are just an appetizer for the main dish: Offsec provides a network of machines with different configurations that mirror real-life situations a pentester might find during an engagement. Each machine is unique and requires a different strategy for breaking in and escalating privileges. The game aspects of the course ("yay, popped another box!") are addictive and ensure the student will learn good pentesting habits through repetition.

Some boxes are standard installations of known/vulnerable software, some are more CTF-ish, which keeps things interesting. Something that sets this course apart from other challenges like [Vulnhub](https://www.vulnhub.com/) or [Hackthebox](https://www.hackthebox.eu/) is the presence of multiple networks and dependencies between machines, requiring a good job of post-exploitation on the student's part.

Those who have been in the labs know how frustrating, difficult and ultimately rewarding the course is.

# Reporting, Emacs style #

The exam (about which I cannot talk too much, due to course rules) demands a written report of the steps taken to break into the machines, much like a professional engagement. In addition, the student gets extra points in the exam if s/he delivers a test report for the boxes popped during the labs. This is the "unsexy" part of the job, but I figured I could make it a little more interesting...

Among the tools suggested in the course is [KeepNote](http://keepnote.org/), a note-taking application used to store everything: commands, shells' screenshots, you name it. Since Emacs already has [Org-mode](https://orgmode.org/), I thought, why not just use it? It turned out better than expected.

[This blog post](http://howardism.org/Technical/Emacs/literate-devops.html) by Howard Abrams explains in much better detail all the built-in functions Emacs has for literate programming in Org-mode. Since a pentest report falls into this broad category, I decided to give it a go for the labs and got hooked - it really makes everything much easier.

The highlights for me were:

## Named sessions ##

![I don't confirm nor deny these are the boxes' hostnames]({{ site.url }}/public/posts/finally-oscp/various-cat-names.jpg "I don't confirm nor deny these are the boxes' hostnames")

From the Org-mode [documentation](https://orgmode.org/worg/org-contrib/babel/intro.html#org98c324c):

```
For some languages, such as python, R, ruby and shell, it is possible to run an interactive session as an "inferior process" within Emacs.

This means that an environment is created containing data objects that persist between different source code blocks.

Babel supports evaluation of code within such sessions with the :session header argument.
```

This functionality allows you to write commands much like you would in a script, keeping all state across executions! Much like iPython and other "scientific computing" platforms, it serves as a literate REPL, allowing you to keep notes on all computations of interest.

This is all driven by standard Elisp code, and, in the case of the shell wrapper (what you'll be working with most of the time when pentesting), Emacs' built-in [subshell](https://www.gnu.org/software/emacs/manual/html_node/emacs/Interactive-Shell.html). This means you get some cool stuff for free:

- History enabled by default (via M-p / M-n), which is particularly useful for shells with no tty
- Easy to copy/paste content because it's just text in an Emacs buffer. In particular, you can even _save_ the whole terminal interaction as just another file.

The [`:session`](https://orgmode.org/manual/session.html) keyword allows multiple interactive shells, making it easier to juggle a bunch of different commands to get a remote shell (e.g. you set up a netcat listener in a `victim-sh` session, and run an RCE exploit in a `exploit-victim` session).

## Exporting ##

![Doge is pleased with your fancy Org-mode report]({{ site.url }}/public/posts/finally-oscp/doge-pleased-with-data.jpg "Doge is pleased with your fancy Org-mode report")

This is an example source Org-mode document (taken from my notes on the [MBE exercises](https://github.com/RPISEC/MBE/blob/master/README.md)):

![]({{ site.url }}/public/posts/finally-oscp/mbe-lab-emacs.png "Radare: RAinbow DisAssembler for Reverse Engineering")

Org-mode allows one to [easily export](https://orgmode.org/manual/Exporting.html) a document to multiple formats. It's as easy as C-c C-e $FORMAT.

After exporting to ODT/PDF, this is what it looks like:

![And this PDF runs 'rm -rf /' when opened...jk. Maybe not.]({{ site.url }}/public/posts/finally-oscp/mbe-pdf.png "And this PDF runs 'rm -rf /' when opened...jk. Maybe not.")

This made it very easy to convert my notes into a quality document. Since the commands were already there, with some comments in place to remind me what they did, the only work necessary was to tidy up the notes and export. No fiddling with converters/formatting necessary - all handled by Org-mode.

Did I mention it's also possible to "[tangle](https://orgmode.org/manual/Extracting-source-code.html)" the commands together into standalone scripts if necessary, so you have a way to distribute this in a more fitting form to non-Emacs users?

# Why? #

![Still a better depiction of hacking than almost every 90s' movie]({{ site.url }}/public/posts/finally-oscp/developer-versus-cheater.jpg "Still a better depiction of hacking than almost every 90s' movie")

All this looks like a lot of work. And it is. Why should you bother going through all this, if it's not going to directly impact your day job?

As a software developer, it's easy to overlook security. We all have days when we think "this is a clumsy hack, but it'll have no further repercussions, and we'll fix it later". This sort of rationale goes out the window when you know _how_ an attacker is able to use that particular issue to pwn your app and turn your servers into Monero mining bots. Or, even worse, your [customers' machines](https://www.pandasecurity.com/mediacenter/mobile-news/wannamine-cryptomining-malware/).

It also shows how security failures tend to be _systemic_. Most machines in the course are designed not to fall to a point-and-click exploit, but to a combination of weak credentials, too-much-exposed services and lax access controls. Gives one a new appreciation for the work of devops/sysadmin people, keeping everything patched and running smoothly.

Besides, the labs are _very_ fun, and I definitely recommend going for it if you're looking for a challenge.
