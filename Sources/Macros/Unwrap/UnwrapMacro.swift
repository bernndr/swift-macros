import SwiftSyntaxMacros
import SwiftSyntax

public struct UnwrapMacro: ExpressionMacro {
  public static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) throws -> ExprSyntax {
    guard 
      let value = node.argumentList.first?.expression,
      let defaultValue = node.argumentList.last?.expression
    else {
      fatalError("compiler bug: the macro does not have any arguments")
    }

    return """
      { [wrapped = \(value)] in
        guard let wrapped else {
          return \(defaultValue)
        }
        return wrapped
      }()
      """
  }
}
