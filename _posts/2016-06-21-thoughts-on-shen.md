# What is Shen?

-   Practical version

> Shen is an hosted Lisp that comes with a full-featured macro system, a Prolog, an optional type system more powerful than Haskell's, and does it all in under 5000 lines of code. It has been ported to many platforms including Java, JavaScript and Ruby.

-   Emotional version

It is the magnum opus of a [lone programmer](http://marktarver.com/) who is well-versed in [theory](http://www.shenlanguage.org/LPC/lpc.html) AND [practice](http://marktarver.com/hackers.html). Even if you don't think the language might be worth more attention outside of this talk, it might give you a few cool insights.

The essay linked under \`practice\` is one I feel so strongly about that I must restrain myself not to tell it over and over to every new coworker. Guy tells a bit about my personal story - only I didn't return to academia to see what I could gain by studying more.

# Why Lisp?

Most people could rephrase it as 'these parens hurt my eyes!'. Rest assured that they matter. We Lispers understand that they're there for a very important reason, and that reason is:

Lisp is the [programmable programming language](https://news.ycombinator.com/item?id=11240983).

Btw, there are tools to alleviate most problems with parens. There's the awesome [Paredit](http://danmidwood.com/content/2014/11/21/animated-paredit.html), and the subject of [M-Expressions](https://en.wikipedia.org/wiki/M-expression) always comes up (we only need more developers to actively work on this!)

# Problems in paradise?

As told in "[The bipolar Lisp programmer](http://marktarver.com/bipolar.html)", Lisp loses culturally because it's so easy to do complicated stuff in it that no one cares to document and package nicely for "lesser" mortals.

(Ironically enough, I'm writing this while in one of my own insomniac intellectual frenzy of productivity. Especially in my country - Brazil - I find a teacher who understands the finer psychological aspects of learning and productivity a very rare sight. Perhaps we can learn from other cultures how to do university better?)

There's a lot of historical baggage and lingo that is very off-putting for new developers ("`head` is `car` and `tail` is `cdr`? What do these even mean?")

The very nature of the language gives a lot of space for the programmer to make mistakes. It is powerful, but should be wielded wisely.

(As with most dynamic languages, in fact.)

One coworker wrote a [very cool piece](https://mrkkrp.github.io/posts/lisp-and-haskell.html) on some of the problems he found in the (Common) Lisp language. I agree with the sentiment (I have spent some time with Haskell because of this), but I feel that Shen is a step ahead, by joining the best of both worlds.

# Got it, Lisp is cool but not perfect. How does Shen compare?

Shen has a Haskell-style type system that is entirely [optional](https://en.wikipedia.org/wiki/Gradual_typing). This allows one to opt-in or out of this feature whenever needed - so you get the best of both worlds: the flexibility of dynamic languages and the feedback on compiling mistakes of "static" languages.

It respects and improves on the venerable Lisp tradition of easily creating DSLs by providing a built-in, baked-inside-the-language [YACC](http://www.shenlanguage.org/learn-shen/shendoc.htm#Shen-YACC%20II). This, coupled with the fact that Shen is [homoiconic](https://en.wikipedia.org/wiki/Homoiconicity), gives you a lot of power with very low operational overhead. It is used to [implement](https://github.com/Shen-Language/shen-sources/blob/master/sources/prolog.shen#L34) the [built-in Prolog](http://www.shenlanguage.org/learn-shen/shendoc.htm#Prolog) in what I consider a very small LOC for the amount of functionality it provides.

(Yeah, there's a `defcc` "primitive". How cool is that? Perl 5 people should be envious.)

(To clarify: what is "operational overhead"? I want to say that it's easier to do JetBrains-style stuff when the language allows you to. Better than having to muck around parsing code, and deal with the problems related to it. No syntax = one less problem to focus on.)

Strangely enough, it is a Lisp with the Unix-virusesque quality (as argued in the body of essays collectively named as [Worse is Better](https://en.wikipedia.org/wiki/Worse_is_better)). It compiles down to a mini-Lisp called KLambda that is very easy to port to different environments, and this has been done [many](https://github.com/gregspurrier/shen-ruby), [many](https://github.com/deech/shen-elisp) times.

# Shen sounds very cool. Now, I'm sure it's not perfect. Can you tell me about its problems?

Sure! There are a few:

The community is definitely niche. At the time of this writing, the mailing list for the project is around 500 people - IMHO, it looks like it's mostly academics who bend towards the practical and like to "get their hands dirty" on code. Almost the same demographic one would expect to find in Haskell mailing lists.

The language's author is known for being a bit [harsh](http://marktarver.com/problems.html) towards open source. It difficults adoption (no self-respecting developer wants to be forced to use something [s]he can not read the source and tweak, if the need ever arises). The author argues eloquently about this to some extent [here](http://marktarver.com/open.html), but, as one of the so-called "Twitter generation" myself, I have to say that I only started taking Shen more seriously after their website was revamped.

# Wait, what do you mean? There's no open source?

Yes, there [is](https://github.com/Shen-Language/shen-sources/blob/master/sources/prolog.shen#L34).

You can understand the author's stance on open source by looking at it through the point of view of the Lisp community. There is a recurring theme of pride in using what are called professional-level tools. The community understands that such a degree of power can only be used by people who committed themselves to understanding how to use it - and the level of dedication required for that usually means "for my entire lifetime".

Given that the Lisp arts are alien to most programmers, the level of investment necessary to use them "in the real world" is much bigger than less "weird" counterparts. So, paradoxically, Lisp respects its users' intellectual ability, but exactly because of that, it demands more of them, while other languages might give a "quick fix" by appealing to what is easily relatable (as a famous example, JavaScript having C-style syntax, opposed to Scheme syntax as Brendan Eich [originally envisioned](https://brendaneich.com/2008/04/popularity/)).

And so, it remains (and probably will remain) a niche language. It gives you very, very much, but it "only" requires that you dedicate yourself completely to it. Ever read the [piece](http://www.xent.com/pipermail/fork/Week-of-Mon-20070219/044101.html) about Haskell being "that girl, the special one"? It's kinda like that.

Obligatory [xkcd](https://xkcd.com/297/) on this matter. It tells more than I can put into words, really. Also, I need it to finish this.

# Takeaways

Shen is a cool language in the spirit of Lisp that modernizes it and is backed by cutting-edge research on programming languages. It gives very thoughtful answers to problems we, the programmers' global tribe, are collectively facing.

The community is small, but well-meaning and full of smart people. Exactly the sort of people you want covering your back when you're facing a difficult bug.

We still need to solve the "Lisp paradox", but we'll get there, one step at a time.

Resist the seductive argument of using "real world" languages and choose one that has the best of both worlds. We are the rebels. [Join us](http://churchm.ag/wp-content/uploads/2011/05/star-wars-propaganda-posters-rebel-alliance-6-620x930.jpg)!
