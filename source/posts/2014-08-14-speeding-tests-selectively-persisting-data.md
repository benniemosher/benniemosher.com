---
title: Speeding up your tests by selectively persisting data
description: Learn to benchmark your gems and selectively persist data
categories:
  - Test Driven Development
tags:
  - factory girl
  - learning
  - tdd
  - test driven development
---
I follow the [thoughtbot blog](http://robots.thoughtbot.com) very closely, and today they posted about [speeding up tests by selectively avoiding factory girl](http://robots.thoughtbot.com/speed-up-tests-by-selectively-avoiding-factory-girl). This was enlightening on multiple levels.

## Benchmarking their own gems

For me it was extremely enlightening to see a company, who does a lot of gem work, benchmark their own gem. It was great to see that they don&#8217;t always use [FactoryGirl](https://github.com/thoughtbot/factory_girl) in their test suites.

## Okay to not always be persisting data

It was awesome to see that a company so highly thought of say that it is okay to not persist data in your specs. I have been using FactoryGirl for a few years now, and admittedly probably too much. I thought that it was always necessary to persist the data, but to see that its 100% faster to not persist data is going to make me think twice next time I create a test.

Go test things and don&#8217;t always persisting data!
