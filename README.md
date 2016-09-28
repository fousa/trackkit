TrackKit
========

[![CI Status](http://img.shields.io/travis/fousa/trackkit.svg?style=flat)](https://travis-ci.org/fousa/trackkit) [![Version](https://img.shields.io/cocoapods/v/TrackKit.svg?style=flat)](http://cocoapods.org/pods/TrackKit) [![License](https://img.shields.io/cocoapods/l/TrackKit.svg?style=flat)](http://cocoapods.org/pods/TrackKit) [![Platform](https://img.shields.io/cocoapods/p/TrackKit.svg?style=flat)](http://cocoapods.org/pods/TrackKit)
[![Language Swift 3.0](https://img.shields.io/badge/Language-Swift%203.0-orange.svg?style=flat)](https://swift.org)

`TrackKit` is allows you to easily parse a GPX file in Swift.

Supported Formats
=================

GPX
---

The `GPX` format that is support is version **1.1** as described in the [schema documentation](http://www.topografix.com/GPX/1/1/).

Integration
===========

Add this pod to your `Podfile` by adding the following line:

``` ruby
pod 'TrackKit', '~> 1.2'
```

_It's important to add the version to the `pod 'TrackKit'`, this way you are sure that a next update of the pod will not break your code._

Usage
=====

You can take a look at the different specs on how to use this pod. But for now I describe in short how it can be used.

Here is a sample GPX file with some data:

``` xml
<gpx creator='TrackKit'>
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
let data = content.data(using: String.Encoding.utf8)
let file = try! Parser(data: data).parse()
```

When the parsing fails an error will be thrown. There are currently **two** types of errors:

- `invalidData` thrown when the data object is empty.
- `invalidFormat` thrown when the data object can't be parsed.
- `invalidVersion` thrown when the data object contains an incorrect version of the GPX file.

License
=======

TrackKit is available under the MIT license. See the LICENSE file for more info.
