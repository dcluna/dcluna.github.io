---
layout: post
title: Vi keybindings in terminal and ansi-term
---

I did not see this problem described somewhere else, so this is a small post to document it. I was having an issue similar to the one described in [this blog post](http://blog.refu.co/?p=1277), but ansi-term could print the "weird" characters that were supposed to cause the problem. After checking my dotfiles a bit, I found this piece of code:

```sh
# vi keybindings for zsh
bindkey -v
zle-keymap-select () {
    if [ $TERM = "screen" ]; then
        if [ $KEYMAP = vicmd ]; then
            echo -ne '\033P\033]12;#ff6565\007\033\\'
        else
            echo -ne '\033P\033]12;grey\007\033\\'
        fi
    elif [ $TERM != "linux" ]; then
        if [ $KEYMAP = vicmd ]; then
            echo -ne "\033]12;#ff6565\007"
        else
            echo -ne "\033]12;grey\007"
        fi
    fi
}; zle -N zle-keymap-select
zle-line-init () {
    zle -K viins
    if [ $TERM = "screen" ]; then
        echo -ne '\033P\033]12;grey\007\033\\'
    elif [ $TERM != "linux" ]; then
        echo -ne "\033]12;grey\007"
    fi
    zle vi-cmd-mode
}; zle -N zle-line-init
```

This piece sets up a red cursor for when I am in 'vim mode' in zsh. Apparently Emacs did not recognize these escape sequences and generated this weird output:

![weird ansi-term behavior]({{ site.url }}/public/ansi-term-weird.png)

ansi-term sets up an env variable called $EMACS, so I just wrapped this code around it:

```sh
if [ -n "$EMACS" ]; then
    echo "no vi keybindings inside emacs terms"
else
    # the previous giant ball of code is now here
fi
```

And it works correctly now:

![yay for working ansi-term]({{ site.url }}/public/ansi-term-correct.png)
