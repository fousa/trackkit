LogKit [![CI Status](http://img.shields.io/travis/fousa/logkit.svg?style=flat)](https://travis-ci.org/fousa/logkit) [![Version](https://img.shields.io/cocoapods/v/LogKit.svg?style=flat)](http://cocoapods.org/pods/LogKit) [![License](https://img.shields.io/cocoapods/l/LogKit.svg?style=flat)](http://cocoapods.org/pods/LogKit) [![Platform](https://img.shields.io/cocoapods/p/LogKit.svg?style=flat)](http://cocoapods.org/pods/LogKit)
======

`LogKit` is allows you to easily parse a GPX file in Swift.

Supported Formats
=================

GPX
---

The `GPX` format that is support is version **1.1** as described in the [schema documentation](http://www.topografix.com/GPX/1/1/).

Integration
===========

Add this pod to your `Podfile` by adding the following line:

``` ruby
pod 'LogKit', '~> 1.1'
```

_It's important to add the version to the `pod 'LogKit'`, this way you are sure that a next update of the pod will not break your code._

Usage
=====

You can take a look at the different specs on how to use this pod. But for now I describe in short how it can be used.

Here is a sample GPX file with some data:

``` xml
<gpx creator='LogKit'>
  <metadata>
    <name>Jelle Vandebeeck</name>
    <desc>A GPX file</desc>
    <time>2016-03-10T10:05:12+02:00</time>
    <keywords>hiking, forest, wild</keywords>
  </metadata>
</gpx>                    
```

The only thing you have to do is make sure to get the contents of the GPX file into an `Data` structure. When you have this you can easily parse the file into a `File`.

``` swift
let content: String = '...'
let data = content.dataUsingEncoding(NSUTF8StringEncoding)
let file = try! Parser(data: data).parse()
```

When the parsing fails an error will be thrown. There are currently **two** types of errors:

- `invalidData` thrown when the data object is empty.
- `invalidFormat` thrown when the data object can't be parsed.
- `invalidVersion` thrown when the data object contains an incorrect version of the GPX file.

License
=======

LogKit is available under the MIT license. See the LICENSE file for more info.
