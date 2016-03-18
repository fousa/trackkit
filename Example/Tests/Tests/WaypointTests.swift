import Quick
import Nimble
import GPXKit

class WaypointSpec: QuickSpec {
    override func spec() {
        describe("waypoints") {
            it("should not have waypoints") {
                let content = "<gpx></gpx>"
                let data = content.dataUsingEncoding(NSUTF8StringEncoding)
                let file = try! GKParser(data: data).parse()
                
                expect(file.waypoints).to(beNil())
            }
            
            it("should not have waypoints without a coordinate") {
                let content = "<gpx>"
                    + "<wpt></wpt>"
                    + "<wpt></wpt>"
                    + "</gpx>"
                let data = content.dataUsingEncoding(NSUTF8StringEncoding)
                let file = try! GKParser(data: data).parse()
                
                expect(file.waypoints?.count) == 0
            }
            
            it("should have waypoints") {
                let content = "<gpx>"
                    + "<wpt lat='10' lon='10'></wpt>"
                    + "<wpt lat='11' lon='11'></wpt>"
                    + "</gpx>"
                let data = content.dataUsingEncoding(NSUTF8StringEncoding)
                let file = try! GKParser(data: data).parse()
                
                expect(file.waypoints?.count) == 2
            }
        }
        
        describe("waypoint data") {
            var point: GKPoint!
            
            beforeEach {
                let content = "<gpx creator='GPXKit'>"
                                + "<wpt lat='41.2' lon='-71.3'>"
                                    + "<ele>1001</ele>"
                                    + "<name>A waypoint</name>"
                                    + "<time>2016-03-10T10:05:12+02:00</time>"
                                    + "<geoidheight>56</geoidheight>"
                                    + "<cmt>A comment</cmt>"
                                    + "<desc>A description</desc>"
                                    + "<src>A source</src>"
                                    + "<sym>A symbol</sym>"
                                    + "<type>A type</type>"
                                    + "<sat>9</sat>"
                                    + "<hdop>1.3</hdop>"
                                    + "<vdop>2.2</vdop>"
                                    + "<pdop>3.1</pdop>"
                                    + "<ageofdgpsdata>0.4</ageofdgpsdata>"
                                    
                                    // Link
                                    + "<link href='http://fousa.be'>"
                                        + "<text>Fousa</text>"
                                        + "<type>text/html</type>"
                                    + "</link>"
                                + "</wpt>"
                            + "</gpx>"
                let data = content.dataUsingEncoding(NSUTF8StringEncoding)
                let file = try! GKParser(data: data).parse()
                
                point = file.waypoints?.first!
            }
            
            it("should have a coordinate") {
                expect(point.coordinate?.latitude) == 41.2
                expect(point.coordinate?.longitude) == -71.3
            }
            
            it("should have an elevation") {
                expect(point.elevation) == 1001
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
        }
        
        describe("empty waypoint") {
        }
    }
}