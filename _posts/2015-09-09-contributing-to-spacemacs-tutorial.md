---
layout: post
title: Contributing to Spacemacs
---

Recently I touched a Rails/JavaScript codebase and I needed to tweak my Spacemacs a little. The defaults are great, but I felt that some things were missing: [better integration](https://github.com/syl20bnr/spacemacs/pull/2949) with [Rubocop](https://github.com/bbatsov/rubocop) and a [REPL](https://github.com/skeeto/skewer-mode) for [JS](https://github.com/syl20bnr/spacemacs/pull/2979). So, instead of making it a private layer, why not contribute back to the project? It's easier than you think!

Places to start: Spacemacs guidelines [for contributors](https://github.com/syl20bnr/spacemacs/blob/master/doc/CONTRIBUTE.org) and this [great tutorial](http://thume.ca/howto/2015/03/07/configuring-spacemacs-a-tutorial/) by Tristan Hume.

Considering you followed the official [installation instructions](https://github.com/syl20bnr/spacemacs):

```sh
git clone --recursive https://github.com/syl20bnr/spacemacs ~/.emacs.d
```

You should:

* Fork the original repo in Github
* Add your repository as a remote

    If you are using [Magit](http://magit.vc/) (and you should), press 'M a' to add your repo. Magit will prompt for the remote name (I chose 'my-fork') and URL.
* Branch from the 'develop' branch

    I usually end up with two branches - one that I merge with my own version of master (so that I can use it with the stable version of Spacemacs) and another for PR'ing in the official Spacemacs repository (the 'develop' branch).
* Make your changes and commit them

    Spacemacs' policy is that PRs must contain only *ONE* commit. No worries - develop with as many commits as you want, and let Magit do the hard work for you by rebasing your branch with the ['squash' option](http://howardism.org/Technical/Emacs/magit-squashing.html). This also works if you need to make changes during code review - just squash your new commits and push them to your remote repository (git will probably complain about the remote tip being behind your branch, but it's *usually* safe to ignore this).
* Push the changes to your remote repository and then make a pull request to the original Spacemacs repository

    Remember, all pull requests should be against the 'develop' branch, *NOT master*!

If during this process your branch gets behind the current develop (Spacemacs is a very active project, and as of the time of this writing this happened with me), just press 'F -r o origin/develop' in Magit, which translates to

```sh
git pull --rebase origin/develop
```

That's it, you contributed to Spacemacs and made it one step closer to the best out-of-the-box Emacs experience there is.

And if you are a JS developer, check out skewer-mode's [demo video](https://www.youtube.com/watch?v=4tyTgyzUJqM&feature=youtu.be), it's awesome!
