import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

final class URLMacroTests: XCTestCase {
  func testValidURL() {
    #if canImport(Macros)
    assertMacroExpansion(
        #"""
        #URL("https://www.apple.com")
        """#,
        expandedSource: #"""
        URL(string: "https://www.apple.com")!
        """#,
        macros: testMacros
    )
    #else
    throw XCTSkip("macros are only supported when running tests for the host platform")
    #endif
  }

  func testURLStringLiteralError() {
    #if canImport(Macros)
    assertMacroExpansion(
        #"""
        #URL("https://www.apple.com\(Int.random())")
        """#,
        expandedSource:
        #"""
        #URL("https://www.apple.com\(Int.random())")
        """#,
        diagnostics: [
          DiagnosticSpec(message: "#URL requires a static string literal", line: 1, column: 1)
        ],
        macros: testMacros
    )
    #else
    throw XCTSkip("macros are only supported when running tests for the host platform")
    #endif
  }

  func testMalformedURLError() {
    #if canImport(Macros)
    assertMacroExpansion(
        #"""
        #URL("https://www. apple.com")
        """#,
        expandedSource:
        #"""
        #URL("https://www. apple.com")
        """#,
        diagnostics: [
          DiagnosticSpec(message: #"The input URL is malformed: "https://www. apple.com""#, line: 1, column: 1)
        ],
        macros: testMacros
    )
    #else
    throw XCTSkip("macros are only supported when running tests for the host platform")
    #endif
  }
}
