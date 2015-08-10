---
layout: post
title: Ensure working trees are empty before running 'git push'
---

Every developer has been through this scenario:

* make changes, bug seems fixed
* commits everything
* refactors some bits of code
* pushes code to the remote

and everything seems fine and dandy...until Jenkins warns that you broke the build because some changes you made were in a different repository that you forgot to update.

I've been through that too, but fortunately with Gradle you have an easy way to avoid this. Put this in your Gradle [init script](https://docs.gradle.org/current/userguide/init_scripts.html):

```groovy
allprojects {
    task paths << { task -> println "$task.project.projectDir" }
}
```

And put this script somewhere (I usually put this in ~/bin):

```bash
#!/bin/bash

# This script checks if the staging area for git directories in $1/stdin is empty
while read line; do
    dir=$line
    curdir=$PWD
    cd $dir
    gitroot=`git rev-parse --show-toplevel`
    cd $gitroot
    if [[ -z "$gitroot" ]]
    then
        echo "No git directory @ $dir!"
        cd $curdir
        exit 1
    fi
    changed=`git status -s | grep -v "^??"`
    if [[ -z "$changed" ]]
    then
        cd $curdir
    else
        cd $curdir
        printf "There are changed files in $dir:\n$changed"
        exit 1
    fi
done < "${1:-/dev/stdin}"
```

And add this to your [pre-push hook](https://github.com/git/git/blob/master/Documentation/githooks.txt#L181):

```bash
echo "Checking for unstaged changes in project directories"
gradle -q path | ~/bin/git-check-empty-staging-area.sh
if [ $? -ne 0 ]
then
    exit 1
fi
```

Feel free to update the [gist](https://gist.github.com/da9a12e16d53d267c1f6) with better code, and let me know!
