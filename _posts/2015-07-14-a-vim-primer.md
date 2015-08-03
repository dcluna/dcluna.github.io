---
layout: post
title: A Vim tutorial
---

There is an epic post in [StackOverflow](http://stackoverflow.com/a/1220118/1536138) explaining about why Vim is so great. As a longtime Emacs user, the concept of modal editing always eluded me. Having to press 'i' before typing, accidentally pressing 'u' and undoing your changes...this looks like a nightmare! Fortunately, the pain of an unexpected tendionitis forced me to find ways to type drastically less, and I decided to give Vim a go (in the form of IDE plugins such as [IDEAVim](https://github.com/JetBrains/ideavim) and [VsVim](https://github.com/jaredpar/VsVim/)).

(Obligatory disclaimer: No, I didn't get the tendionitis from Emacs. But I have to agree that its default keymap could be more ergonomic.)

What makes Vim keybindings so ergonomic and efficient? Terseness (a lot of complex actions are triggered with few keystrokes) and composability. Let's take a little dive on how to do a few small tasks in Vim...

# Moving around, writing some stuff #

hjkl keys are used to move left,up,down,right respectively. But that's not the way you should be moving around in a file. Let's say we have the following code:

```python
def i_do_something(index, otherparam):
    my_thing = |grab_stuff_at(index)
    my_thing.modify(otherparam)
```

And the '|' represents where the cursor is in the file. How would you set the cursor:

* <b>f</b>ollowing the letter 's'?
* af<b>t</b>er the 't' in my_thing?
* at the beginning or end of the line?
* at the first non-whitespace character of the line?
* at the previous or next occurrence of the word 'grab'?

Answer: respectively, pressing 'fs', 'Tt', '0', '$', '^', '#', '*' (without quotes).

What all these operations have in common? They are toggled by one keystroke, followed by its "argument" (optional in some cases, as we've seen). 
