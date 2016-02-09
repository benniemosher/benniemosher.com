---
title: What is a category?
categories:
  - Learning
tags:
  - groovy
  - learning
  - category
---

Categories are not a Groovy specific thing. From a quick google search I found this [Wikipedia](https://en.wikipedia.org/wiki/Class_(computer_programming)#Partial) article, which tells us  that the idea of categories have been around in many languages such as Smalltalk (known as Class Extensions), C# 2.0 and Visual Basic 2005 (known as partial classes), Objective-C (known as categories), and I also found that [Swift](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Extensions.html) has the same idea known as Extensions.

Since I am by no means a programming expert (yet, I will get there!), I will not try to completely explain categories instead I will just make some notes on the things that I learned about them during the pairing session. Categories do not add methods to the parent class at compile time like most other classes, instead it actually is adding them at runtime. This allows for the interpretor to basically layer the classes on top of each other. Let us look at an example our core class `Bob`:

```groovy
class Bob
{
  String drinkCoffee()
  {
    String cup = '16oz'
    return cup
  }
}
```

In our `Bob` class above, we have a method called `drinkCoffee`. In this method we simply create a string called `cup` and then set it to `'16 oz'`. We simply just then return our string `cup` at the end of the method. This is just a basic class and method, I am sure that your codebase is much more complex, as is the codebase at my work, however for this example we will keep it simple. Let us get our category on!

```groovy
class Bill
{
  use(Bob) {
    String drinkCoffee()
    {
      String coffee = 'French Roast with Cream and Sugar'
      return cup + coffee
    }
  }
}
```

If we look here, we use a category by `use(Bob)` and then extend the functionality by calling the same method `drinkCoffee()`. As we can see here, we don't redeclare `String cup = '16oz'` because we don't want to change it. The category principle basically allows us to inherit the cup variable from the parent class. We then set coffee with `String coffee = 'French Roast with Cream and Sugar'`. At the end of the method we then just `return cup + coffee`. The category allows us to easily extend the base method and include our own data and functionality and inherit the variables from the parent method.
