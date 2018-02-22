---
layout: post
title:  "Navigate JSON content with ease in JavaScript (aka XPath for JSON)"
tags:
- Dev
- JSON
- XPath
---
In your familiar with XML files, you’ve probably heard of/used [XPath](https://en.wikipedia.org/wiki/XPath) to select nodes from a XML document without implementing a custom parser. There is a similar tool for JSON, called JSONPath. This post shows you where to get the documentation, implementation and tools to get you started.

First, a good yet concise presentation is available on [Stefan Goessner’s blog](http://goessner.net/articles/JsonPath/). It gives you background, defines the syntax and comes with many examples. A JavaScript implementation is also available but it seems unmaintained.

Subbu Allamaraju forked this implementatio, modernized and improved to an extend unknown to me. Nevertheless I’ve decided to use it in my project as it is actively maintained. It’s available [on GitHub](https://github.com/s3u/JSONPath). Looking at [the test files](https://github.com/s3u/JSONPath/blob/master/test/test.examples.js) is a good source of “in-situation” examples.

To test the queries, an online JSONPath evaluator is a convenient tool. I find [jsonpath.com](http://jsonpath.com/) to be the best. You can paste your JSON content and your JSONPath expression and it will immediately show you the matching content.

Edit: link is dead ~~There is an interesting alternative to JSONPath: [json:select()](http://jsonselect.org/), CSS-like selectors for JSON. I never took the time to play with it but it could be worth a shot.~~
