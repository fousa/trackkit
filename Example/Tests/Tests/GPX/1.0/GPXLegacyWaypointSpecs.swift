//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 30/12/2016.
//

import Quick
import Nimble
import TrackKit

class GPXLegacyWaypointSpec: QuickSpec {
    override func spec() {
        describe("waypoints") {
            it("should not have waypoints") {
                let content = "<gpx version='1.0'></gpx>"
                let data = content.data(using: .utf8)
                let file = try! TrackParser(data: data, type: .gpx).parse()

                expect(file.waypoints).to(beNil())
            }

            it("should not have waypoints without a coordinate") {
                let content = "<gpx version='1.0'>"
                                + "<wpt></wpt>"
                                + "<wpt></wpt>"
                            + "</gpx>"
                let data = content.data(using: .utf8)
                let file = try! TrackParser(data: data, type: .gpx).parse()

                expect(file.waypoints).to(beNil())
            }

            it("should have waypoints") {
                let content = "<gpx version='1.0'>"
                                + "<wpt lat='10' lon='10'></wpt>"
                                + "<wpt lat='11' lon='11'></wpt>"
                            + "</gpx>"
                let data = content.data(using: .utf8)
                let file = try! TrackParser(data: data, type: .gpx).parse()

                expect(file.waypoints?.count) == 2
            }
        }

        describe("waypoint data") {
            var point: Point!

            beforeEach {
                let content = "<gpx creator='TrackKit' version='1.0'>"
                                + "<wpt lat='41.2' lon='-71.3'>"
                                    + "<ele>1001</ele>"
                                    + "<magvar>300</magvar>"
                                    + "<name>A waypoint</name>"
                                    + "<time>2016-03-10T10:05:12+02:00</time>"
                                    + "<geoidheight>56</geoidheight>"
                                    + "<cmt>A comment</cmt>"
                                    + "<desc>A description</desc>"
                                    + "<src>A source</src>"
                                    + "<sym>A symbol</sym>"
                                    + "<type>A type</type>"
                                    + "<fix>dgps</fix>"
                                    + "<sat>9</sat>"
                                    + "<hdop>1.3</hdop>"
                                    + "<vdop>2.2</vdop>"
                                    + "<pdop>3.1</pdop>"
                                    + "<ageofdgpsdata>0.4</ageofdgpsdata>"
                                    + "<dgpsid>400</dgpsid>"
                                    + "<url>http://fousa.be</url>"
                                    + "<urlname>Fousa</urlname>"
                                + "</wpt>"
                            + "</gpx>"
                let data = content.data(using: .utf8)
                let file = try! TrackParser(data: data, type: .gpx).parse()

                point = file.waypoints?.first!
            }

            it("should have a coordinate") {
                expect(point.coordinate?.latitude) == 41.2
                expect(point.coordinate?.longitude) == -71.3
            }

            it("should have an elevation") {
                expect(point.elevation) == 1001
            }

            it("should have a magnetic variation") {
                expect(point.magneticVariation) == 300
            }

            it("should have a time") {
                expect(point.time?.description) == "2016-03-10 08:05:12 +0000"
            }

            it("should have a mean sea level height") {
                expect(point.meanSeaLevelHeight) == 56
            }

            it("should have a name") {
                expect(point.name) == "A waypoint"
            }

            it("should have a comment") {
                expect(point.comment) == "A comment"
            }

            it("should have a description") {
                expect(point.description) == "A description"
            }

            it("should have a source") {
                expect(point.source) == "A source"
            }

            it("should have a link") {
                expect(point.link?.link) == "http://fousa.be"
                expect(point.link?.text) == "Fousa"
            }

            it("should have a symbol") {
                expect(point.source) == "A source"
            }

            it("should have satelites") {
                expect(point.satelites) == 9
            }

            it("should have a horizontal dilution of precision") {
                expect(point.horizontalDilutionOfPrecision) == 1.3
            }

            it("should have a vertical dilution of precision") {
                expect(point.verticalDilutionOfPrecision) == 2.2
            }

            it("should have a position dilution of precision") {
                expect(point.positionDilutionOfPrecision) == 3.1
            }

            it("should have an age of gpx data") {
                expect(point.ageOfTheGpxData) == 0.4
            }

            it("should have a gps station type") {
                expect(point.dgpsStationType) == 400
            }

            it("should have a type") {
                expect(point.type) == "A type"
            }

            it("should have a fix") {
                expect(point.fix) == .dgps
            }
        }

        describe("empty waypoint") {
            var point: Point!

            beforeEach {
                let content = "<gpx creator='TrackKit' version='1.0'>"
                                + "<wpt lat='41.2' lon='-71.3'>"
                                + "</wpt>"
                            + "</gpx>"
                let data = content.data(using: .utf8)
                let file = try! TrackParser(data: data, type: .gpx).parse()

                point = file.waypoints?.first!
            }

            it("should not have an elevation") {
                expect(point.elevation).to(beNil())
            }

            it("should not have a magnetic variation") {
                expect(point.magneticVariation).to(beNil())
            }

            it("should not have a time") {
                expect(point.time?.description).to(beNil())
            }

            it("should not have a mean sea level height") {
                expect(point.meanSeaLevelHeight).to(beNil())
            }

            it("should not have a name") {
                expect(point.name).to(beNil())
            }

            it("should not have a comment") {
                expect(point.comment).to(beNil())
            }

            it("should not have a description") {
                expect(point.description).to(beNil())
            }

            it("should not have a source") {
                expect(point.source).to(beNil())
            }

            it("should not have a link") {
                expect(point.link).to(beNil())
            }

            it("should not have a type") {
                expect(point.type).to(beNil())
            }

            it("should not have a fix") {
                expect(point.fix).to(beNil())
            }

            it("should not have a symbol") {
                expect(point.source).to(beNil())
            }

            it("should not have satelites") {
                expect(point.satelites).to(beNil())
            }

            it("should not have a horizontal dilution of precision") {
                expect(point.horizontalDilutionOfPrecision).to(beNil())
            }

            it("should not have a vertical dilution of precision") {
                expect(point.verticalDilutionOfPrecision).to(beNil())
            }

            it("should not have a position dilution of precision") {
                expect(point.positionDilutionOfPrecision).to(beNil())
            }

            it("should not have an age of gpx data") {
                expect(point.ageOfTheGpxData).to(beNil())
            }

            it("should have a gps station type") {
                expect(point.dgpsStationType).to(beNil())
            }
        }
    }
}
