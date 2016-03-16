import Quick
import Nimble
import GPXKit

class CommonSpec: QuickSpec {
    override func spec() {
        describe("common data") {
            var file: GKFile!
            
            beforeEach {
                let content = "<gpx creator='GPXKit'>"
                                + "<metadata>"
                                    + "<name>Jelle</name>"
                                    + "<desc>A GPX file</desc>"
                                    + "<author>Vandebeeck</author>"
                    
                                    // Copyright
                                    + "<copyright author='Jelle Vandebeeck'>"
                                        + "<year>2016</year>"
                                        + "<license>MIT</license>"
                                    + "</copyright>"
                    
                                    // Link
                                    + "<link href='http://fousa.be'>"
                                        + "<text>Fousa</text>"
                                        + "<type>text/html</type>"
                                    + "</link>"
                                + "</metadata>"
                            + "</gpx>"
                let data = content.dataUsingEncoding(NSUTF8StringEncoding)
                file = try! GKParser(data: data).parse()
            }
            
            it("should have a creator name") {
                expect(file.creator).to(equal("GPXKit"))
            }
            
            context("metadata") {
                it("should have a name") {
                    expect(file.name).to(equal("Jelle"))
                }
                
                it("should have a description") {
                    expect(file.description).to(equal("A GPX file"))
                }
                
                it("should have a author") {
                    expect(file.author).to(equal("Vandebeeck"))
                }
                
                it("should have a copyright notice") {
                    expect(file.copyrightNotice?.author).to(equal("Jelle Vandebeeck"))
                    expect(file.copyrightNotice?.year).to(equal(2016))
                    expect(file.copyrightNotice?.license).to(equal("MIT"))
                }
                
                it("should have a link") {
                    expect(file.link?.link).to(equal("http://fousa.be"))
                    expect(file.link?.text).to(equal("Fousa"))
                    print(file.link?.mimeType)
                    expect(file.link?.mimeType).to(equal("text/html"))
                }
                
                pending("should have a time") {}
                pending("should have keywords") {}
                pending("should have bounds") {}
            }
            
            context("empty file") {}
        }
    }
}
