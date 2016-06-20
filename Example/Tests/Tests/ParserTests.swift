import Quick
import Nimble
import GPXKit

class ParserSpec: QuickSpec {
    override func spec() {
        describe("parser") {
            it("should be successful") {
                expect{ try Parser(data: NSData()) }.notTo(throwError())
            }
            
            it("should throw an data error") {
                expect{ try Parser(data: nil) }.to(throwError(ParseError.InvalidData))
            }
            
            it("should throw an parse error") {
                expect{ try Parser(data: NSData()).parse() }.to(throwError(ParseError.InvalidFormat))
            }
        }
    }
}