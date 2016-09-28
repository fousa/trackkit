import Quick
import Nimble
import TrackKit

class GPXRouteSpec: QuickSpec {
    override func spec() {
        describe("routes") {
            it("should not have routes") {
                let content = "<gpx version='1.1'></gpx>"
                let data = content.data(using: String.Encoding.utf8)
                let file = try! GPXParser(data: data).parse()

                expect(file.routes).to(beNil())
            }

            it("should not have routes without a points") {
                let content = "<gpx version='1.1'>"
                                + "<rte></rte>"
                                + "<rte></rte>"
                            + "</gpx>"
                let data = content.data(using: String.Encoding.utf8)
                let file = try! GPXParser(data: data).parse()

                expect(file.routes).to(beNil())
            }

            it("should have routes") {
                let content = "<gpx version='1.1'>"
                                + "<rte>"
                                    + "<rtept lat='10' lon='10'></rtept>"
                                    + "<rtept lat='11' lon='11'></rtept>"
                                + "</rte>"
                                + "<rte>"
                                    + "<rtept lat='10' lon='10'></rtept>"
                                    + "<rtept lat='11' lon='11'></rtept>"
                                + "</rte>"
                            + "</gpx>"
                let data = content.data(using: String.Encoding.utf8)
                let file = try! GPXParser(data: data).parse()

                expect(file.routes?.count) == 2
            }
        }

        describe("route data") {
            var route: Route!

            beforeEach {
                let content = "<gpx creator='TrackKit' version='1.1'>"
                                + "<rte>"
                                    + "<name>A waypoint</name>"
                                    + "<cmt>A comment</cmt>"
                                    + "<desc>A description</desc>"
                                    + "<src>A source</src>"
                                    + "<type>A type</type>"
                                    + "<number>9</number>"

                                    // Link
                                    + "<link href='http://fousa.be'>"
                                        + "<text>Fousa</text>"
                                        + "<type>text/html</type>"
                                    + "</link>"
                                    + "<rtept lat='41.2' lon='-71.3'></rtept>"
                                + "</rte>"
                            + "</gpx>"
                let data = content.data(using: String.Encoding.utf8)
                let file = try! GPXParser(data: data).parse()

                route = file.routes?.first!
            }


            it("should have a name") {
                expect(route.name) == "A waypoint"
            }

            it("should have a comment") {
                expect(route.comment) == "A comment"
            }

            it("should have a description") {
                expect(route.description) == "A description"
            }

            it("should have a source") {
                expect(route.source) == "A source"
            }

            it("should have a link") {
                expect(route.link?.link) == "http://fousa.be"
                expect(route.link?.text) == "Fousa"
                expect(route.link?.mimeType) == "text/html"
            }

            it("should have a number") {
                expect(route.number) == 9
            }

            it("should have a type") {
                expect(route.type) == "A type"
            }
        }

        describe("route point data") {
            var point: Point!

            beforeEach {
                let content = "<gpx creator='TrackKit' version='1.1'>"
                                + "<rte>"
                                    + "<rtept lat='41.2' lon='-71.3'>"
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
                                        + "<sat>9</sat>"
                                        + "<fix>dgps</fix>"
                                        + "<hdop>1.3</hdop>"
                                        + "<vdop>2.2</vdop>"
                                        + "<pdop>3.1</pdop>"
                                        + "<ageofdgpsdata>0.4</ageofdgpsdata>"
                                        + "<dgpsid>400</dgpsid>"

                                        // Link
                                        + "<link href='http://fousa.be'>"
                                        + "<text>Fousa</text>"
                                        + "<type>text/html</type>"
                                        + "</link>"
                                    + "</rtept>"
                                + "</rte>"
                            + "</gpx>"
                let data = content.data(using: String.Encoding.utf8)
                let file = try! GPXParser(data: data).parse()

                point = file.routes?.first?.points?.first!
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

            it("should have a fix") {
                expect(point.fix) == FixType.dgps
            }

            it("should have a type") {
                expect(point.type) == "A type"
            }

            it("should have a link") {
                expect(point.link?.link) == "http://fousa.be"
                expect(point.link?.text) == "Fousa"
                expect(point.link?.mimeType) == "text/html"
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
        }

        describe("empty route point") {
            var point: Point!

            beforeEach {
                let content = "<gpx creator='TrackKit' version='1.1'>"
                                + "<rte>"
                                    + "<rtept lat='41.2' lon='-71.3'></rtept>"
                                + "</rte>"
                            + "</gpx>"
                let data = content.data(using: String.Encoding.utf8)
                let file = try! GPXParser(data: data).parse()

                point = file.routes?.first?.points?.first!
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

            it("should not have agps station type") {
                expect(point.ageOfTheGpxData).to(beNil())
            }

            it("should have a gps station type") {
                expect(point.dgpsStationType).to(beNil())
            }
        }
    }
}
