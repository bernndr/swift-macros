import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

final class AssociatedValuesMacroTests: XCTestCase {
  func testGenerateVarForAssociatedValues() throws {
    #if canImport(Macros)
    assertMacroExpansion(
        """
        @AssociatedValues
        enum SomeEnum {
          case none
          case labeledValue(a: String, b: String)
          case optional(String?)
          case value(Int)
          case closure(() -> Void)
          indirect case someEnum(SomeEnum)
        }
        """,
        expandedSource:
        """
        enum SomeEnum {
          case none
          case labeledValue(a: String, b: String)
          case optional(String?)
          case value(Int)
          case closure(() -> Void)
          indirect case someEnum(SomeEnum)

          var labeledValueValue: (a: String, b: String)? {
            if case let .labeledValue(v0, v1) = self {
              return (v0, v1)
            }
            return nil
          }

          var optionalValue: (String?)? {
            if case let .optional(v0) = self {
              return v0
            }
            return nil
          }

          var valueValue: (Int)? {
            if case let .value(v0) = self {
              return v0
            }
            return nil
          }

          var closureValue: (() -> Void)? {
            if case let .closure(v0) = self {
              return v0
            }
            return nil
          }

          var someEnumValue: (SomeEnum)? {
            if case let .someEnum(v0) = self {
              return v0
            }
            return nil
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

  func testMacroIsOnlySupportEnum() throws {
    #if canImport(Macros)
    assertMacroExpansion(
        #"""
        @AssociatedValues
        struct SomeStructure {

        }
        """#,
        expandedSource:
        #"""
        struct SomeStructure {

        }
        """#,
        diagnostics: [
          DiagnosticSpec(message: #"Can only be applied to enum"#, line: 1, column: 1)
        ],
        macros: testMacros
    )
    #else
    throw XCTSkip("macros are only supported when running tests for the host platform")
    #endif
  }
}
