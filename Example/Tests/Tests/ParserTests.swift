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
            
            it("should throw an invalid version error") {
                let content = "<gpx version='1.0'></gpx>"
                let data = content.dataUsingEncoding(NSUTF8StringEncoding)
                
                expect{ try Parser(data: data).parse() }.to(throwError(ParseError.InvalidVersion))
            }
        }
    }
}