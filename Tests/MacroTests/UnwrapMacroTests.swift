import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
@testable import SwiftMacros

final class UnwrapMacroTests: XCTestCase {
  func testReturnDefaultValue() {
    let string: String? = nil
    XCTAssertEqual(#unwrap(string, default: "macro"), "macro")
  }

  func testReturnValue() {
    let string: String? = "swift"
    XCTAssertEqual(#unwrap(string, default: "macro"), "swift")
  }

  func testGeneratedCode() {
    #if canImport(Macros)
    assertMacroExpansion(
        #"""
        let string: String? = "swift"
        #unwrap(string, default: "macro")
        """#,
        expandedSource: """
        let string: String? = "swift"
        { [wrapped = string] in
          guard let wrapped else {
            return "macro"
          }
          return wrapped
        }()
        """,
        macros: testMacros
    )
    #else
    throw XCTSkip("macros are only supported when running tests for the host platform")
    #endif
  }
}
