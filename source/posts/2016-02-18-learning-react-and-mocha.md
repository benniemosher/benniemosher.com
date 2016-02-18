---
title: Learning React and Mocha
categories:
  - Learning
tags:
  - learning
---
In my recent job search I have been getting turned down by a lot of employers because I do not have React or Angular experience. Today I decided to learn one and build a demo app that can prove that I know the framework and can get work done. After research and tallying up denial emails, I decided that React was looking more needed and that it was smarter to learn React. So, I set out to do it. I read a [article](http://reactfordesigners.com/labs/reactjs-introduction-for-people-who-know-just-enough-jquery-to-get-by/) that explain why React was superior to React and I was hooked. Mind you I finished this at 0200, when I should of been cozyed up against my wife, dogs, and my daughter in bed. However, now I have the damn learning fever that I get when I am learning something new.

I knew that after learning the basics of states, that I needed to learn someway to write React in a TDD environment. The article mentioned above, as well as the [documentation](http://facebook.github.io/react/docs/getting-started.html) provided by Facebook did not mention this. So, I did the normal developer thing, I Googled it. Which brought me to this little gem of a [blog post](http://www.bebetterdeveloper.com/coding/getting-started-react-mocha.html). The content is incredible, and it in fact does work and taught me how to get Mocha running with React. However, if you look at the dependencies there, it lists Gulp as a dependency.

I know, I know, all you magpies are in love with Gulp and Grunt and whatever G word you can think up with to build your environment. I on the other hand have recently been trying to keep it simple. I have been doing everything in my power to write on NPM scripts, and stay away from the extra complexity that G's bring. So, I went over to Lena's Github profile, and found her repository for [react-mocha-example](https://github.com/LenaBarinova/react-mocha-example) and forked it. And then the obsession grew even deeper.

## Removing Gulp

*HULK SMASH!!!* and done, Gulp is removed. No, no, I will provide you with more context. So, first thing that I did was ran `npm install` just to make sure that my tests pass before I did anything. We are green, awesome. Now, what happens if I run `npm uninstall --save-dev gulp gulp-load-plugins gulp-mocha gulp-open`? Well, it uninstalls those modules of course. And then we run `npm test` again, and we are green. Okay, phew I didn't break anything yet. Wait, look in package.json what is this `vinyl-source-stream` package? I have no idea, but it has the word stream in it, so it must have something to do with Gulp. A quick search on [npmjs.com](https://npmjs.com) and *BAM*, I found it! In fact [`vinyl-source-stream`](https://www.npmjs.com/package/vinyl-source-stream) actually is a Gulp related package. Alright, sweet let's blast that guy too, `npm uninstall --save-dev vinyl-source-stream`. Alright, run `npm test` again, and we are green. SWEET! That just removed five unneeded plugins from this repository. HELL TO THE YEAH! Now, lets delete the `gulpfile.js` as we will not need it anymore, and then commit.

## Removing Browserify

Alright, `browserify` is not a bad package at all. However, I just didn't see the need for us to have it in this repository at this time. So, lets `npm uninstall --save-dev browserify` and then run `npm test`. Yup, we are green. Alright, we are doing pretty good so far, not a big deal. Let's commit and then look at `package.json`.

## Removing unneeded Babel packages

Alright, this is where it began to get a little hairy. I didn't want to have Babel in the package list at all. So, I `npm uninstall --save-dev babel babel-core babel-preset-es2015 babel-preset-react` and run `npm test`. Holy mother of moses, we have errors. All over. Shoot. Okay, let's undo that really fast `git co package.json && npm install`. Let's look at that list that we just uninstalled. At this point in my learning, I am willing to bet money that a package with the name "react" in it is most likely needed. So, let's try the next one in line `npm uninstall --save-dev babel-preset-es2015` and then run `npm test`. Oops, nope still getting errors. Okay, again let's undo that `git co package.json && npm install`. Alright, next in line let's ditch babel-core `npm uninstall --save-dev babel-core` and then run `npm test`. "Dammit, man! I'm a doctor, not a physicist!" Alright, we have to have that one too. Okay, lets undo that again `git co package.json && npm install`. Last try here, `npm uninstall --save-dev babel` and then run `npm test`. DING DING DING! We have a winner! Looks like we don't need babel in our package list. Well, at least that gets rid of one package. Let's commit and move on.

## Upgrading packages

At this point, we have removed everything from the `package.json` that we can. However, I did notice when we were running `npm install` that we were getting some warnings and deprecation notices. So, let's go ahead and delete the `"devDependencies"` element out of our JSON object in `package.json`. Then we can run `npm install --save-dev babel-core babel-preset-es2015 babel-preset-react jsdom mocha mocha-jsdom react react-addons-test-utils react-dom` and of course run a quick `npm test` to make sure we are still green, and we are. Great. Let's commit here and move on.

## Changing out mocha-jsdom for jsdom-global

One thing that I noticed on that last `npm install` command was a deprecation warning about `mocha-jsdom` and to move to using `jsdom-global`. So, let's just go ahead and do that `npm uninstall --save-dev mocha-jsdom` and then `npm install --save-dev jsdom-global`. Of course, lets run `npm test` again. And we have another failure. That is okay, pretty easy to fix that one. Let's `vim test/component-test.js` and change line 4 to `var jsdom = require('jsdom-global');`, and then run `npm test`. Sweet, that was an easy fix and we got rid of one of the deprecation warnings. Let's commit at this point.

After that I just changed the example code to be a little more generic and use things like "Hello World!", instead of the chipper "Lovely! Here it is - my very first React component!". BAH HUMBUG!!! Mr. Scrooge no like chipper. You can see the majority of those [changes here](https://github.com/benniemosher/react-mocha-example/commit/3c341bea3749c94a5e4317df3071076444202417).

That is it. You now have a basic React and Mocha test framework that you can duplicate and use on every project. Pretty simple right? I thought so, and it was a lot of fun to HULK SMASH NPM packages for an hour or so. Well, I am off to grab some shut eye before my daughter wakes up; but tomorrow I will be learning more React and possibly starting the job hunting app I have been thinking about. Until next time, "You stay classy, San Diego!"

P.S. I technically was able to completely remove the Babel dependency from the project, however because Facebook has official endorsed Babel, I didn't include those steps in this post. You can check out the PR and read more about the Babel/JSTransform fight to the death [here](https://github.com/benniemosher/react-mocha-example/pull/1)!
