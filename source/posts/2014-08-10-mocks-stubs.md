---
title: mocks != stubs
categories:
  - Test Driven Development
tags:
  - learning
  - tdd
  - test driven development
  - thoughtbot
---
In attempting to complete thoughtbot’s Testing trail, I read Martin Fowlers’s article, [“Mocks Aren&#8217;t Stubs”](http://martinfowler.com/articles/mocksArentStubs.html).

I have been writing tests for about a year now and I have always just done Integration/Feature tests because they were easier, and I really didn&#8217;t know how to use mocks and stubs. This was okay until our test suite at work reached a few minutes to complete because of all the feature specs. Now that I have read Fowler&#8217;s article, I understand what they are now.

> Stubs provide canned answers to calls made during the test, usually not responding at all to anything outside what&#8217;s programmed in for the test.
>
> <cite>Martin Fowler</cite>
>
> Mocks &#8230; objects pre-programmed with expectations which form a specification of the calls they are expected to receive.
>
> <cite>Martin Fowler</cite>

In general stubs will use state verification and mocks will uses behavior verification. As Fowler talks about in his article, a stub would tell you if your message was marked as sent in a database and your mock would make sure that the proper methods where called and that they were sent the right things.

You can often use mocks to test that a third-party service is called. Such as below:

```ruby
third_party_mock.should_receive(:create).with(
    user_guid: user.guid,
    account_guid: account.guid,
    attr_1: attr_1,
    attr_2: attr_2
)
```

This allows us to make sure that the behavior is called and that the correct elements are sent with the call.

You can often use stubs to fake out states of variables that that it returns the required data. You can stub out how many elements are returned per page for pagination like so:

```ruby
ArticleController.any_instance.stub(:articles_per_page).and_return(1)
```

This is nice because instead of having `articles_per_page = 10` and then have to generate 11 articles in your test, you can set it to be 1 and then you only have to create 2 articles to test that your pagination is working.

I think that it finally makese sense now and now that I have a grasp on when to use mocks vs. stubs I can go and test the world!
