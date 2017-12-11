TrackKit
========

[![CI Status](http://img.shields.io/travis/fousa/trackkit.svg?style=flat)](https://travis-ci.org/fousa/trackkit) [![Version](https://img.shields.io/cocoapods/v/TrackKit.svg?style=flat)](http://cocoapods.org/pods/TrackKit) [![License](https://img.shields.io/cocoapods/l/TrackKit.svg?style=flat)](http://cocoapods.org/pods/TrackKit) [![Platform](https://img.shields.io/cocoapods/p/TrackKit.svg?style=flat)](http://cocoapods.org/pods/TrackKit)
[![Language Swift 3.0](https://img.shields.io/badge/Language-Swift%203.0-orange.svg?style=flat)](https://swift.org) [![Language Swift 4.0](https://img.shields.io/badge/Language-Swift%204.0-orange.svg?style=flat)](https://swift.org)

`TrackKit` allows you to easily parse log files in Swift.

Supported Formats
=================

GPX
---

The `GPX` formats that are supported are versions **1.0** and **1.1** as described in [schema documentation for 1.0](http://www.topografix.com/gpx_manual.asp#gpx_private) and [schema documentation for 1.1](http://www.topografix.com/GPX/1/1/).

LOC
---

The `GPX` format that is supported is version **1.0**. No schema description was found for this format, but we looked at how [Geoaching](http://geocaching.com) used it.

NMEA
----

The `NMEA` format that is supported is version NMEA-0183. The different identifiers that are supported by TrackKit are:

- GPGGA
- GPGLL
- GPRMC
- GPWPL

TCX
---

The `TCX` format that is supported is version **2** as described in the [schema documentation](http://www8.garmin.com/xmlschemas/TrainingCenterDatabasev2.xsd).

TRACK
-----

The `TRACK`format is a custom format that is created by yours truly. It looks to be a custom data file, but when you just open a `.track` file with a text editor you'll notice that it is a simple JSON format. Here is an example on how it's formatted:

``` json
[
	{
		"latitude": 10.0,
		"longitude": 20.0,
		"altitude": 120,
		"horizontalAccuracy": 10,
		"verticalAccuracy": 10, 
		"course": 30,
		"speed": 12,
		"timestamp": 123456 
	}
]
```

Integration
===========

Add this pod to your `Podfile` by adding the following line:

``` ruby
pod 'TrackKit', '~> 2.4'
```

_It's important to add the version to the `pod 'TrackKit'`, this way you are sure that a next update of the pod will not break your code._

Usage
=====

You can take a look at the different specs on how to use this pod. But for now I describe in short how it can be used.

GPX
---

Here is a sample GPX file with some data:

``` xml
<gpx version='1.1' creator='TrackKit'>
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
let data = content.data(using: .utf8)
let file = try! TrackParser(data: data, type: .gpx).parse()
```

LOC
---

Here is a sample LOC file with some data:

``` xml
<loc version='1.0'>
  <waypoint>
    <name id='GC54AMF'><![CDATA[Mortsel]]></name>
    <coord lat='51.16215' lon='4.456933'/>
    <type>Geocache</type>
    <link text='Details'>http://www.geocaching.com</link>
  </waypoint>
</loc>
```

The only thing you have to do is make sure to get the contents of the LOC file into an `Data` structure. When you have this you can easily parse the file into a `File`.

``` swift
let content: String = '...'
let data = content.data(using: .utf8)
let file = try! TrackParser(data: data, type: .loc).parse()
```

NMEA
----

Here is a sample NMEA file with some data:

``` csv
$GPRMC,134732.000,A,5540.3244,N,01231.2941,E,1.75,90.16,041112,,,A*5E
$GPRMC,134735.000,A,5540.3232,N,01231.2946,E,1.97,88.98,041112,,,A*5C
$GPWPL,5540.2823,N,01231.1182,E,00001*7E
```

The only thing you have to do is make sure to get the contents of the NMEA file into an `Data` structure. When you have this you can easily parse the file into a `File`.

``` swift
let content: String = '...'
let data = content.data(using: .utf8)
let file = try! TrackParser(data: data, type: .nmea).parse()
```

TCX
---

Here is a sample TCX file with some data:

``` xml
<TrainingCenterDatabase xmlns='http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2'>
    <Courses>
        <Course>
            <Name>Jelle Vandebeeck</Name>
            <Lap>
                <TotalTimeSeconds>60</TotalTimeSeconds>
                <DistanceMeters>1200</DistanceMeters>
                <BeginPosition>
                    <LatitudeDegrees>51.208845321089</LatitudeDegrees>
                    <LongitudeDegrees>4.394159177318</LongitudeDegrees>
                </BeginPosition>
                <EndPosition>
                    <LatitudeDegrees>51.208867281675</LatitudeDegrees>
                    <LongitudeDegrees>4.394087595865</LongitudeDegrees>
                </EndPosition>
                <Intensity>Active</Intensity>
            </Lap>
            <Track>
                <TrackPoint>
                    <Position>
                        <LatitudeDegrees>51.208845321089</LatitudeDegrees>
                        <LongitudeDegrees>4.394159177318</LongitudeDegrees>
                    </Position>
                </TrackPoint>
            </Track>
        </Course>
    </Courses>
</TrainingCenterDatabase>
```

The only thing you have to do is make sure to get the contents of the TCX file into an `Data` structure. When you have this you can easily parse the file into a `File`.

``` swift
let content: String = '...'
let data = content.data(using: .utf8)
let file = try! TrackParser(data: data, type: .tcx).parse()
```

Type Handling
-------------

There is also an automated way to handle the type selection. Just pass the file extension to the `TrackType` enum.

``` swift
let gpxType = TrackType(fileExtension: 'gpx')
let locType = TrackType(fileExtension: 'loc')
let tcxType = TrackType(fileExtension: 'tcx')
```

_The `fileExtension` value that is passed ignores the case._

Error Handling
--------------

When the parsing fails an error will be thrown. There are currently **two** types of errors:

- `invalidData` thrown when the data object is empty.
- `invalidFormat` thrown when the data object can't be parsed.
- `invalidVersion` thrown when the data object contains an incorrect version of the file.

License
=======

TrackKit is available under the MIT license. See the LICENSE file for more info.
