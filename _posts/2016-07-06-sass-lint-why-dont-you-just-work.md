---
layout: post
title: sass-lint, why don't you just work?
comments: true
---

Tonight I came up with this, to see if I could have some saner error reporting (other than standard `sass` complaining about non-consequential stuff) in my stylesheets.

{% gist dcluna/13ba91424db1bd9c6eb236592c247484 %}

Results were a bit lackluster, as the following image shows (plain `sass` works fine, though):

![]({{ site.url }}/public/lackluster-results-sass-lint.png)

Am I missing something obvious, or it's just that `sass-lint` is works this way?

(BTW, this gist is not entirely correct, but that's the best I have...for now. If time and patience allow, hopefully I'll submit a patch to [flycheck](https://github.com/flycheck/flycheck) when I get this working)
