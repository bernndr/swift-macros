#if canImport(Macros)
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import Testing

@Suite("Singleton Macro")
struct SingletonMacroTests {
  @Test
  func generateAPublicSignletonProperty() {
    assertMacroExpansion(
        """
        @Singleton
        public struct UserStore {
        }
        """,
        expandedSource:
        """
        public struct UserStore {

          public static let shared = UserStore()

          private init() {
          }
        }
        """,
        macros: testMacros,
        indentationWidth: .spaces(2)
    )
  }

  @Test
  func generateASignletonProperty() {
    assertMacroExpansion(
        """
        @Singleton
        class UserStore {
        }
        """,
        expandedSource:
        """
        class UserStore {

          static let shared = UserStore()

          private init() {
          }
        }
        """,
        macros: testMacros,
        indentationWidth: .spaces(2)
    )
  }

  @Test
  func macroIsOnlySupportClassOrStruct() {
    assertMacroExpansion(
        """
        @Singleton
        enum UserStore {
        }
        """,
        expandedSource:
        """
        enum UserStore {
        }
        """,
        diagnostics: [
          DiagnosticSpec(message: "Can only be applied to a struct or class", line: 1, column: 1)
        ],
        macros: testMacros
    )
  }
}
#endif
