import SwiftSyntaxMacros
import SwiftSyntax
import Foundation

struct URLMacro: ExpressionMacro {
  static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) throws -> ExprSyntax {
    guard
      let argument = node.arguments.first?.expression,
      let segments = argument.as(StringLiteralExprSyntax.self)?.segments,
      segments.count == 1,
      case .stringSegment(let literalSegment)? = segments.first
    else {
      throw URLMacroError.requiresStaticStringLiteral
    }

    guard let _ = URL(string: literalSegment.content.text) else {
      throw URLMacroError.malformedURL(urlString: "\(argument)")
    }

    return "URL(string: \(argument))!"
  }
}
