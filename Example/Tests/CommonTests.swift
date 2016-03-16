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
                
                pending("should have a copyright notice") {}
                pending("should have a link") {}
                pending("should have a time") {}
                pending("should have keywords") {}
                pending("should have bounds") {}
            }
            
            context("empty file") {}
        }
    }
}
