---
layout: post
title: Pull requests in Emacs with Magit
---

Magit's keybindings for working with git are awesome, and the newest version has many improvements. Even though there's [magit-gh-pulls](https://github.com/sigma/magit-gh-pulls) for working with Github pull requests, I'm still a fan of Github's online interface. I use a customized version of the function presented in [Endless Parentheses](http://endlessparentheses.com/create-github-prs-from-emacs-with-magit.html):

```emacs-lisp
(defun endless/visit-pull-request-url (base)
  "visit the current branch's pr on github and compares it against BASE."
  (interactive (list (magit-read-other-branch-or-commit "Compare with")))
  (browse-url
   (format "%s/compare/%s...%s"
           (magit-get "remote.origin.url")
           base
           (cdr (magit-get-remote-branch))
           )))

;; I use spacemacs, so this is the incantation to bind this function to a keystroke:
(evil-leader/set-key (kbd "g P c") 'endless/visit-pull-request-url)
```

So whenever I'm finished with my changes, I just press Space g P c and it opens the Github PR interface in the default browser. If you want to change the browser, check the browse-url-generic-program variable in Customize.
