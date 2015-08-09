---
layout: post
title: A vi tutorial
---

There is an epic post in [StackOverflow](http://stackoverflow.com/a/1220118/1536138) explaining why vi is so great. As a longtime Emacs user, the concept of modal editing always eluded me. Having to press 'i' before typing, accidentally pressing 'u' and undoing your changes...this looks like a nightmare! Fortunately, the pain of an unexpected tendonitis forced me to find ways to type drastically less, and I decided to give vi a go (in the form of IDE plugins such as [IDEAVim](https://github.com/JetBrains/ideavim) and [VsVim](https://github.com/jaredpar/VsVim/)).

(Obligatory disclaimer: No, I didn't get the tendonitis from Emacs. But I have to agree that its default keymap could be more [ergonomic](http://ergoemacs.org/).)

What makes vi key bindings so efficient? Terseness (a lot of complex actions are triggered with few keystrokes) and composability. Let's take a little dive on how to do a few small tasks in Vim...

# Moving around, writing some stuff #

hjkl keys are used to move left,up,down,right respectively. But that's not the way you should be moving around in a file. Let's say we have the following code:

```python
def i_do_something(index, otherparam):
    my_thing = |grab_stuff_at(index)
    my_thing.modify(otherparam)
```

And the '|' represents where the cursor is in the file. How would you set the cursor:

* <b>f</b>ollowing the letter 's'? 
![following the letter 's' - small demo]({{ site.url }}/public/vim-primer-fs.gif)
* af<b>t</b>er the 't' in my_thing?
![following the letter 't' - small demo]({{ site.url }}/public/vim-primer-Tt.gif)
* at the beginning or end of the line? at the first non-whitespace character of the line?
![line movement demo]({{ site.url }}/public/vim-primer-edition-example.gif)

Answers: respectively, pressing 'fs', 'Tt', '0', '$', '^' (without quotes).

What all these operations have in common? They are toggled by one keystroke, followed by its "argument" (optional in some cases, as we've seen). If this looks like a function call, it is...more on that later.

What about plain old typing? How do I write, delete, change and move text around? Most people try to memorize a few vi "shortcuts", without realizing that it follows the same pattern:

* want to <b>i</b>nsert text before the cursor? or maybe <b>a</b>ppend to the character following the cursor? Or even better, <b>I</b>nsert at the beginning or <b>A</b>ppend at the end of the current line?
![insert / append demo]({{ site.url }}/public/vim-primer-insert-append-example.gif)
* <b>d</b>elete or <b>c</b>hange text in the current line? <b>s</b>ubstitute a few characters, e<b>x</b>tract or <b>r</b>eplace them?
![multiple insert / append demo]({{ site.url }}/public/vim-primer-edition-example.gif)

(Go ahead, try playing with the letters in bold while in vi normal mode, and you'll see what I mean)

So, we've seen how to do basic operations in Vim, but this does not get us any more productive than any Notepad/nano user. How do you go from there to sculpting your code in a few keystrokes?

# Composing commands: applying over a range, keyboard macros, repeating #

Remember that vi commands look like function calls? The great thing is that they usually accept optional parameters too. Coming back to our Python example, let's say you want to delete from cursor to the end of the line. How do you do that? Press 'd$', which should translate as "delete from here to the end of the line". This works for every vi command, like the ones we've mentioned above.

Want to perform somewhat complex text operations? Keyboard macros to the rescue! When you press 'q' in normal mode, vi expects the next character to be a register to store your macro. Any alphanumeric character will do. For instance, let's say we have the following text:

```html
<div>
    <ul>
        <li>Something here</li>
        <li>Another thing here</li>
    </ul>
</div>
```

And you want to add a URL to every occurrence of the word 'here'. Make a keyboard macro by pressing, say, 'qq', then type the commands: '/here\[Enter\]i\<a href="http://my.important.link.com"\>\[Esc\]lea\</a>\[Esc\]'. After that, press '@q' to replay your recently-saved macro. The result will be:

```html
<div>
    <ul>
        <li>Something <a href="http://my.important.link.com">here</a></li>
        <li>Another thing <a href="http://my.important.link.com">here</a></li>
    </ul>
</div>
```

![HTML link addition with macros demo]({{ site.url }}/public/vim-primer-html-macro.gif)

(Want to check what is saved in your registers? Press ':reg' in normal mode)

You can also "programatically" repeat a macro or command by prefixing it with a number, telling how many times you want the macro to be played. 

![Repeating macro with by a number of times - small demo]({{ site.url }}/public/vim-primer-complex-html.gif)

# Conclusion #

These "simple" commands are the bread and butter of my daily code editing. 90% of my tasks are solved with this small set of operations and the multiple ways to combine them. And this is not even advanced Vim! We did not go through creative uses of registers, how to use marks, ex commands, calling and reading from the shell...and, in the case of my tool of choice, [Spacemacs](https://github.com/syl20bnr/spacemacs), how to create new motions and commands. Let's leave it for another post! For now, I hope these instructions will be useful for you to be more productive with vi-like editors.
