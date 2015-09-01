---
layout: post
title: Migrating an Android build system to Gradle
---

At my current employer, our team recently underwent a migration of our Android app's build system to Gradle, now the official choice for Android Studio. Following is a summary of the good and bad things in this change.

# The good #

## Automatic dependency management ##

This feature is what made us consider switching in the first place. Even though we don't use many external dependencies, including 3rd-party libraries for our project was like this:

* find the project's source code on Github and download it
* if it builds and runs correctly in Android Studio, set it as a git submodule of our project
* integrate it with Apache Ant, our old build system
* debug and fix any problems Jenkins might have with the new setup

This is far from ideal. In contrast, Gradle [got us covered](https://developer.android.com/tools/building/configuring-gradle.html#declareDeps) with one line of code:

```groovy
compile 'your.library.name:major.minor.patch'
```

Want to package some subdirectories as subprojects? Just add a build.gradle to each of these subdirectories, include them as projects in your main build.gradle and you are set. This encourages modularity and code reuse, always a Good Thing®.

## Support for multiple app versions - debug/release, free/paid... ##

This is the other "killer feature" of Gradle. It is very easy to make different [build profiles](https://developer.android.com/tools/building/configuring-gradle.html#workBuildVariants) for an app, each with its own set of source files, compile options, feature toggles and many more. I find it particularly satisfying to know I can stuff my debug builds with instrumentation code and [libraries for inspection](http://facebook.github.io/stetho/), and when releasing, no space or processing time will be used.

## Other benefits ##

In the first place, it is very refreshing to use an actual programming language ([Groovy](http://www.groovy-lang.org/)) instead of XML. Easier to understand and write, and much better for newcomers not used to Ant (like me - I had to look up documentation every time I wanted to tweak our old build system). This also lowers the barrier of adoption for potential project contributors.

Gradle also introduced the ability to inject constants in the BuildConfig classes of the project. This is particularly useful when injecting API URLs and access configurations (e.g.: extra header codes) in your application. Nothing world-changing, but very welcome. 

Did you know that Gradle integration with Ant is [excellent](https://docs.gradle.org/current/userguide/ant.html), even featuring a one-liner for importing build.xml?

```groovy
ant.importBuild 'build.xml'
```

# The bad #

## Android Studio integration issues ##

Android Studio integration with Gradle is good - if you start a project following its conventions. In our case, we migrated an Eclipse/Ant application, using non-standard paths, which led to unexpected behavior in the IDE. Some team members even reported finding "won't fix" bugs with non-standard paths.

The GUI for build configuration is very simple, and sometimes it rewrote our build.gradle badly. I recommend always writing it by hand if possible.

## Build times ##

tl, dr: always enable the [Gradle daemon](https://docs.gradle.org/current/userguide/gradle_daemon.html). If you only use Android Studio, it's on by default; if you are using Gradle in the command-line, run this command:

```sh
touch ~/.gradle/gradle.properties && echo "org.gradle.daemon=true" >> ~/.gradle/gradle.properties
```

In my machine, I see an improvement of a few seconds in build times. Which is great, because personally, I find the edit-compile-run cycle in Android slow...but it may only be my appreciation for [REPLs](https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop) talking. Unfortunately, there are none for Android because of technical limitations, but there are [plugins that come close](http://jimulabs.com/) and [smart workarounds](https://nvbn.github.io/2015/06/04/livecoding-android/).

# Conclusion #

There are many benefits and very few drawbacks to using Gradle as a build system (and in my experience, these are mostly related to IDE integration, not issues with Gradle per se). So, if you are in a JVM environment, give it a go! It works for most Java projects, not only Android ones, and there are [many plugins](https://plugins.gradle.org/) to help you achieve what you want, so try it already!
