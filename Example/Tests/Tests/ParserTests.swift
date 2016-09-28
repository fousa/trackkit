import Quick
import Nimble
import LogKit

class ParserSpec: QuickSpec {
    override func spec() {
        describe("parser") {
            it("should be successful") {
                expect{ try Parser(data: Data()) }.notTo(throwError())
            }
            
            it("should throw an data error") {
                expect{ try Parser(data: nil) }.to(throwError(ParseError.invalidData))
            }
            
            it("should throw an parse error") {
                expect{ try Parser(data: Data()).parse() }.to(throwError(ParseError.invalidFormat))
            }
            
            it("should throw an invalid version error") {
                let content = "<gpx version='1.0'></gpx>"
                let data = content.data(using: String.Encoding.utf8)
                
                expect{ try Parser(data: data).parse() }.to(throwError(ParseError.invalidVersion))
            }
        }
    }
}
