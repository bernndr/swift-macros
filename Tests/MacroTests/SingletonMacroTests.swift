import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

final class SingletonMacroTests: XCTestCase {
  func testGenerateAPublicSignletonProperty() {
    #if canImport(Macros)
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
    #else
    throw XCTSkip("macros are only supported when running tests for the host platform")
    #endif
  }

  func testGenerateASignletonProperty() {
    #if canImport(Macros)
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
    #else
    throw XCTSkip("macros are only supported when running tests for the host platform")
    #endif
  }

  func testMacroIsOnlySupportClassOrStruct() {
    #if canImport(Macros)
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
    #else
    throw XCTSkip("macros are only supported when running tests for the host platform")
    #endif
  }
}
