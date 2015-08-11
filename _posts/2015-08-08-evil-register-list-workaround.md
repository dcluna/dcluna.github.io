---
layout: post
title: Fix for :reg error in Evil
---

Small post with a fix for a (somewhat) common problem. If you use Emacs' registers to save window or frame configurations, you probably found a small bug with the ':reg' command in Evil-mode.

![Backtrace with 'wrong-type-argument number-or-marker-p _' error]({{ site.url }}/public/evil-backtrace.jpeg)

Fortunately, the solution is very simple, just apply [this patch](https://gist.github.com/dcluna/b7fa8f05bd2ce7d8234e) and it will work. Or you can just copy-paste and evaluate this code:

```emacs-lisp
(defun evil-register-list ()
  "Returns an alist of all registers"
  (sort (append (mapcar #'(lambda (reg)
                            (cons reg (evil-get-register reg t)))
                        '(?\" ?* ?+ ?% ?# ?/ ?: ?. ?-
                              ?1 ?2 ?3 ?4 ?5 ?6 ?7 ?8 ?9))
                (delq nil (mapcar (lambda (reg) (and (number-or-marker-p (car reg)) reg)) register-alist)) nil
                nil)
        #'(lambda (reg1 reg2) (< (car reg1) (car reg2)))))
```

