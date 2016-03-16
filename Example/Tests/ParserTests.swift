import Quick
import Nimble
import GPXKit

class ParserSpec: QuickSpec {
    override func spec() {
        describe("parser") {
            it("should be successful") {
                let data = NSData()
                expect{ try GKParser(data: data) }.notTo(throwError())
            }
            
            it("should throw an data error") {
                expect{ try GKParser(data: nil) }.to(throwError(GKParseError.InvalidData))
            }
            
            pending("should throw an parse error") {}
            pending("should throw an empty error") {}
        }
    }
}
