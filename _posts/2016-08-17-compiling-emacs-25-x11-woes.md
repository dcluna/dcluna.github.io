---
layout: post
title: Compiling Emacs 25 - X11 woes and toolkit issues
---
I was prompted by the requirements of this [very important package](https://lars.ingebrigtsen.no/2016/06/28/emacs-can-haz-fancy-meme/) to recompile my Emacs from source. I thought that'd be easy. Oh boy, was I in for a surprise.

## First try ##
Everything went smoothly in the beginning. I would just run `git fetch && git pull`, `./autogen.sh`, `./configure && make`, `cd src/ && ./emacs`, and I would be looking at the Spacemacs window in no time. "This is so easy, I can't believe it won't fail".

I was correct in my suspicion.

First, Emacs complained about `(void-function define-inline)`. After reading [INSTALL](http://git.savannah.gnu.org/cgit/emacs.git/tree/INSTALL), I learned that I should use the `make bootstrap` command.

After that, it did compile, but with none of the libraries I intended to use. The graphics were weird, too - probably because I wasn't using GTK, but the Lucid X toolkit.

"Just configure it with your desired toolkit!"

When I ran `./configure --with-x-toolkit=gtk3 --with-modules && make bootstrap`, my problems just started:

```
configure: error: Package 'xproto', required by 'xau', not found
```

OK, where is 'xproto'? After running `locate xproto`, I found out that there was a `.pc` file in a system directory. If you look at the documentation for `pkg-config`, you'll see the following:

> DESCRIPTION
>        The pkg-config program is used to retrieve information about installed libraries in the system.  It is typically used to compile and link against one or more libraries.  Here is a typical usage scenario in a Makefile:
>
>        program: program.c
>             cc program.c $(pkg-config --cflags --libs gnomeui)
>
>        pkg-config retrieves information about packages from special metadata files. These files  are  named  after
>        the  package,  and  has  a  .pc  extension.   On  most  systems,  pkg-config  looks  in /usr/lib/pkgconfig,
>        /usr/share/pkgconfig, /usr/local/lib/pkgconfig and /usr/local/share/pkgconfig for  these  files.   It  will
>        additionally look in the colon-separated (on Windows, semicolon-separated) list of directories specified by
>        the PKG_CONFIG_PATH environment variable.

So, basically this program ensures we're compiling with all the right flags. I'm running a 64-bit Linux, and this means that libraries might not be in their standard places (that, and the fact that I also run a symlink-hodge-podge between 3 different partitions. More on that later, if I'm not too ashamed of talking about that in public).

## List of commands for installation ##

```bash
X11_PATH=`dirname $(locate x11 | grep pkgconfig | head -1)`
XPROTO_PATH=`dirname $(locate xproto | grep pkgconfig | head -1)`
export PKG_CONFIG_PATH="$XPROTO_PATH:$X11_PATH:$PKG_CONFIG_PATH"
./configure --with-x-toolkit=gtk3 --with-modules
make bootstrap
```

## Other issues ##

After that I faced this [known bug](https://github.com/syl20bnr/spacemacs/issues/6290) on Spacemacs. Thankfully, the devs already found a [workaround](https://github.com/syl20bnr/spacemacs/issues/6246#issuecomment-224195320):

```elisp
dotspacemacs-configuration-layers
'(
  (python :variables python-test-runner '(nose pytest))
  ;; other layers here
  )
```

After that, I had a problem with the background color - it always defaulted to white. Thanks to this [SO answer](http://superuser.com/a/44185), I traced the root of the problem to a "Customize" option in my `.spacemacs`. Deleting it solved the problem:

```elisp
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;; '(default
 ;; a bunch of color definitions here that weren't helpful
 ;; )
 )
```

## XWidgets (optional) ##

After that, I figured "hey, why don't I compile with xwidgets support? Looks cool, and it'll help while I don't get a second monitor". For that, I needed to install this dependency:

```sh
sudo apt-get install libwebkitgtk-3.0-dev
```

And the command for compiling Emacs with this optional module became:

```sh
./configure --with-x-toolkit=gtk3 --with-modules --with-xwidgets
```

## Takeaways ##

Now I can meme inside Spacemacs to my heart's content. Hopefully, this blog post might help someone who's going through the same problems as I did.
