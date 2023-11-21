import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

final class SymbolMacroTests: XCTestCase {
  func testValidSymbol() {
    #if canImport(Macros)
    assertMacroExpansion(
        #"""
        #symbol("globe")
        """#,
        expandedSource: "globe",
        macros: testMacros
    )
    #else
    throw XCTSkip("macros are only supported when running tests for the host platform")
    #endif
  }

  func testInvalidSymbol() {
    #if canImport(Macros)
    assertMacroExpansion(
        #"""
        #symbol("test")
        """#,
        expandedSource:
        #"""
        #symbol("test")
        """#,
        diagnostics: [
          DiagnosticSpec(message: #""test" is not a valid symbol"#, line: 1, column: 1)
        ],
        macros: testMacros
    )
    #else
    throw XCTSkip("macros are only supported when running tests for the host platform")
    #endif
  }

  func testParseNameError() {
    #if canImport(Macros)
    assertMacroExpansion(
        #"""
        #symbol("\("globe")")
        """#,
        expandedSource:
        #"""
        #symbol("\("globe")")
        """#,
        diagnostics: [
          DiagnosticSpec(message: #"Cannot parse SF Symbol name"#, line: 1, column: 1)
        ],
        macros: testMacros
    )
    #else
    throw XCTSkip("macros are only supported when running tests for the host platform")
    #endif
  }
}
