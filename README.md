GPXKit [![CI Status](http://img.shields.io/travis/fousa/gpxkit.svg?style=flat)](https://travis-ci.org/fousa/gpxkit) [![Version](https://img.shields.io/cocoapods/v/GPXKit.svg?style=flat)](http://cocoapods.org/pods/GPXKit) [![License](https://img.shields.io/cocoapods/l/GPXKit.svg?style=flat)](http://cocoapods.org/pods/GPXKit) [![Platform](https://img.shields.io/cocoapods/p/GPXKit.svg?style=flat)](http://cocoapods.org/pods/GPXKit)
======

`GPXKit` is allows you to easily parse a GPX file in Swift.

GPX format
==========

The currently supported `GPX` format is version **1.1** as described in the [schema documentation](http://www.topografix.com/GPX/1/1/).

Integration
===========

Add this pod to your `Podfile` by adding the following line:

``` ruby
pod 'GPXKit', '~> 1.1'
```

_It's important to add the version to the `pod 'GPXKit'`, this way you are sure that a next update of the pod will not break your code._

Usage
=====

You can take a look at the different specs on how to use this pod. But for now I describe in short how it can be used.

Here is a sample GPX file with some data:

``` xml
<gpx creator='GPXKit'>
  <metadata>
    <name>Jelle Vandebeeck</name>
    <desc>A GPX file</desc>
    <time>2016-03-10T10:05:12+02:00</time>
    <keywords>hiking, forest, wild</keywords>
  </metadata>
</gpx>                    
```

The only thing you have to do is make sure to get the contents of the GPX file into an `NSData` structure. When you have this you can easily parse the file into a `GKFile`.

``` swift
let content: String = '...'
let data = content.dataUsingEncoding(NSUTF8StringEncoding)
let file = try! GKParser(data: data).parse()
```

When the parsing fails an error will be thrown. There are currently **two** types of errors:

- `invalidData` thrown when the data object is empty.
- `invalidFormat` thrown when the data object can't be parsed.
- `invalidVersion` thrown when the data object contains an incorrect version of the GPX file.

License
=======

GPXKit is available under the MIT license. See the LICENSE file for more info.
