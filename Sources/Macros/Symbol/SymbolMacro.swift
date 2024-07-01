import SwiftSyntaxMacros
import SwiftSyntax
import SwiftUI

struct SymbolMacro: ExpressionMacro {
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
      throw SymbolMacroError.parseName
    }

    try verifySymbol(name: literalSegment.content.text)
    return "\"\(raw: literalSegment.content.text)\""
  }

  private static func verifySymbol(name: String) throws {
    #if canImport(UIKit)
    if let _ = UIImage(systemName: name) { return }
    #else
    if let _ = NSImage(systemSymbolName: name, accessibilityDescription: nil) { return }
    #endif
    throw SymbolMacroError.invalidSymbol(name: name)
  }
}
