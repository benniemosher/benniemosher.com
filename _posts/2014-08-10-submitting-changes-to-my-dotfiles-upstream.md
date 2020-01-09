---
layout: post
title: Submitting Changes to my .dotfiles upstream
description: How to submit changes to a repos upstream repository
categories:
- ".dotfiles"
- Vim
tags:
- dotfiles
- learning
- thoughtbot
- vim

---
At work I have started to use Vim more often. In doing so I have adapted my coworker&#8217;s dotfiles repo (which is based off of thoughtbot&#8217;s dotfiles) and started using it for myself. I have forked it [here](https://github.com/benniemosher/dotfiles). To install read the [README.md](https://github.com/benniemosher/dotfiles/blob/master/README.md) or [thoughtbot&#8217;s install blog post](http://robots.thoughtbot.com/manage-team-and-personal-dotfiles-together-with-rcm).

I recently hit a problem with using these dotfiles in that I wanted to make some changes to my setup but still wanted to be able to contribute things back to my coworkers dotfiles. So, I started to do some research and was able to get ahold of [@r00k](https://twitter.com/r00k) and [@croaky](https://twitter.com/croaky) on Twitter and [@croaky](https://twitter.com/croaky) mapped me to this [blog post from thoughtbot](http://robots.thoughtbot.com/keeping-a-github-fork-updated).

It took me a little bit of thinking and trial and error but I have finally figured it out. So, here we go&#8230;

Lets clone your forked dotfiles repo down (replace <github_username> with your username):

```bash
git clone git@github.com:<github_username>/dotfiles.git
```

Then we can add a remote called upstream, which will the repo that you forked yours from:

```bash
cd dotfiles
git remote add upstream git@github.com:benniemosher/dotfiles
```

Now we are set. We can now update our master branch from our upstreams master branch:

```bash
git fetch upstream
git rebase upstream/master
```

This will allow us to get any updates that our upstream repo pushes out. We can now change anything that we want in our forked dotfiles repo and push it to github. We can begin to personal our dotfiles and still be able to retrieve updates from our upstream repo.

Let&#8217;s say that you have wrote this amazing macro for your Vim setup and you want to push it out to your upstream repo.

Simply checkout your upstreams master branch under a branch named upstream:

```bash
git co -b upstream upstream/master
```

This will remove all of your Vim customizations and set you back to your upstreams default. We can now make a change in the upstream branch, push it to github, and then make a pull request (PR) comparing our upstream branch to upstream/masters branch. This will allow you to push any customization that is worthy of being in the upstream repo up, and then create PRs of only those changes. Once the PR has been approved and merged into our upstream repo, we can update our local copy with those changes:

```bash
git fetch upstream
git rebase upstream/master
```

We do a rebase here instead of a merge so that we can try to avoid as many conflicts as possible. This should take the commit in our upstream branch and replay it on top of all of our customizations. Now we just simply rinse and repeat!

Happy Viming!