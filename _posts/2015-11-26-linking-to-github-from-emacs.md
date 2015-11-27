---
layout: post
title: Linking to Github directly from Emacs
---

GitHub has a RESTful interface for showing files in different branches and commits. In my daily tasks, it's common to refer to files in different branches and commits for code review, so I knew I had to make this more efficient. Thus the following code was born:

```elisp
(defun github/copy-file-url (curbranch)
  (interactive (list (magit-read-branch "Branch: ")))
  (let* ((toplevel (replace-regexp-in-string "\/$" "" (magit-toplevel)))
         (curbranch (or curbranch (magit-get-current-branch)))
         (pathtofile (replace-regexp-in-string (regexp-quote toplevel) "" (buffer-file-name))))
    (message
     ;; format: $REMOTE-URL/blob/$BRANCH/$PATHTOFILE
     (kill-new (format "%s/blob/%s%s#%s"
                       (replace-regexp-in-string "\.git$" "" (magit-get "remote.origin.url"))
                       curbranch
                       pathtofile
                       (mapconcat (lambda (pos) (format "L%s" (line-number-at-pos pos)))
                                  (if (region-active-p)
                                      (list (region-beginning) (region-end))
                                    (list (point))) "-"))))))
```

In the top let* expression, we get the current branch and the path to the current file relative to the repository's toplevel. I usually clone via HTTP, so ```remote.origin.url``` returns an almost correct URL (we need to strip it of the trailing '.git' to work). Finally, we get the line number(s - plural if there's an active region) from Emacs and build the Github URL.

I didn't test it, but would be happy to discover that this function also works with [git-timemachine](https://github.com/pidu/git-timemachine).
