import Quick
import Nimble
import GPXKit

class ParserSpec: QuickSpec {
    override func spec() {
        describe("parser") {
            it("should be successful") {
                expect{ try GKParser(data: NSData()) }.notTo(throwError())
            }
            
            it("should throw an data error") {
                expect{ try GKParser(data: nil) }.to(throwError(GKParseError.InvalidData))
            }
            
            it("should throw an parse error") {
                expect{ try GKParser(data: NSData()).parse() }.to(throwError(GKParseError.InvalidFormat))
            }
            
            pending("should throw an empty error") {
                expect{ try GKParser(data: NSData()).parse() }.to(throwError(GKParseError.Empty))
            }
        }
    }
}