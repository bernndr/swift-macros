#if canImport(Macros)
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import Testing

@Suite("URL Macro")
struct URLMacroTests {
  @Test
  func validURL() {
    assertMacroExpansion(
        """
        #URL("https://www.apple.com")
        """,
        expandedSource: 
        """
        URL(string: "https://www.apple.com")!
        """,
        macros: testMacros
    )
  }

  @Test
  func UrlStringLiteralError() {
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
  }

  @Test
  func malformedURLError() {
    assertMacroExpansion(
        """
        #URL("https://www. apple.com")
        """,
        expandedSource:
        """
        #URL("https://www. apple.com")
        """,
        diagnostics: [
          DiagnosticSpec(message: #"The input URL is malformed: "https://www. apple.com""#, line: 1, column: 1)
        ],
        macros: testMacros
    )
  }
}
#endif
