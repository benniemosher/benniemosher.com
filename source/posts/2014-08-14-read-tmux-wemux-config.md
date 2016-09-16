---
title: How to read your tmux/wemux config
description: A walk-down of reading your tmux/wemux config to enable you to quickly learn
categories:
  - .dotfiles
  - tmux
tags:
  - dotfiles
  - learning
  - thoughtbot
  - tmux
  - wemux
---
So, if you are using a fork of my dotfiles you will see that I have a tmux and wemux config file in there. I generally use wemux to do work, don&#8217;t ask me why but it is what was suggested by a coworker over tmux (maybe a post will be due soon on that). I have been reading a lot on how to use tmux and have been having some problems. Thoughtbot has a whole [trail on tmux](https://upcase.com/tmux) and has a lot of great information on that trail.

I was reading through some of the post and getting discouraged very quickly. Everything in my dotfiles was mapped differntly then what thoughtbot had. I begain to think about this and realized that most of thoughtbot&#8217;s materials probably assume that you are using their [laptop](https://github.com/thoughtbot/laptop) setup. What if you are not using their setup? What if you are using a laptop from work that your boss set up for you so that you can have the same setup as the rest of the team, as to make pairing a lot easier. How do you learn the key bindings to things like vim or tmux? Well I have come up with a small tip: ***READ THE CONFIG FILES!***

You might be thinking to yourself, I have looked at those config files and they are confusing and hard to understand. Let&#8217;s quickly go over some details and things to look for so that you can begin to understand how to pick out the good things in the config files.

You can see my `.tmux.conf` file [here](https://github.com/benniemosher/dotfiles/blob/master/tmux.conf).

### Command keys

In my configuration my command keys for tmux is `ctrl+a`. This can get cumbersome to type, unless you remap your `caps lock` key to `ctrl`. Then all you do is press `caps lock + a` followed by a command.

### `bind-key` or `bind`

When you see `bind-key` or `bind` in your config file, to my understanding, this is a way to set shortcuts. So, I read `bind-key` as `ctrl+a` (`caps lock + a`).

#### `bind-key`s or `bind`s to note

  * [line 22](https://github.com/benniemosher/dotfiles/blob/master/tmux.conf#L22) &#8211; `bind-key |   split-window -h`.
  * [line 24](https://github.com/benniemosher/dotfiles/blob/master/tmux.conf#L24) &#8211; `bind-key -   split-window -v`.
  * [line 25](https://github.com/benniemosher/dotfiles/blob/master/tmux.conf#L25) &#8211; `bind-key x   kill-pane`.
  * [line 47-50](https://github.com/benniemosher/dotfiles/blob/master/tmux.conf#L47-50) &#8211; These bindings allow you to navigate through panes using VIM keybindings thruogh `ctrl + a <key>`

### More details

To get better ideas of what to look for and to figure out some key commands, thoughtbot has these two great links:

  * [Love, hate, & tmux](http://robots.thoughtbot.com/post/2166174647/love-hate-tmux)
  * [A Tmux Crash Course](http://robots.thoughtbot.com/post/2641409235/a-tmux-crash-course)

Here is to *muxing your future!
