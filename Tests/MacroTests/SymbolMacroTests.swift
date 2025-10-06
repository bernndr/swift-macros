#if canImport(Macros)
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import Testing

@Suite("Symbol Macro")
struct SymbolMacroTests {
  @Test
  func validSymbol() {
    assertMacroExpansion(
        """
        #symbol("swift")
        """,
        expandedSource: 
        """
        "swift"
        """,
        macros: testMacros
    )
  }

  @Test
  func invalidSymbol() {
    assertMacroExpansion(
        """
        #symbol("test")
        """,
        expandedSource:
        """
        #symbol("test")
        """,
        diagnostics: [
          DiagnosticSpec(message: #""test" is not a valid symbol"#, line: 1, column: 1)
        ],
        macros: testMacros
    )
  }

  @Test
  func parseSymbolNameWithError() {
    assertMacroExpansion(
        #"""
        #symbol("\("swift")")
        """#,
        expandedSource:
        #"""
        #symbol("\("swift")")
        """#,
        diagnostics: [
          DiagnosticSpec(message: #"Cannot parse SF Symbol name"#, line: 1, column: 1)
        ],
        macros: testMacros
    )
  }
}
#endif
