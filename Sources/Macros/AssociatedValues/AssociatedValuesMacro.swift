import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

struct AssociatedValuesMacro: MemberMacro {
  static func expansion(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    guard let enumDecl = declaration.as(EnumDeclSyntax.self) else {
      throw AssociatedValuesMacroError.notAEnum
    }

    return try enumDecl.memberBlock.members.compactMap {
      $0.decl.as(EnumCaseDeclSyntax.self)?
        .elements
        .compactMap { $0 }
    }
    .reduce([], +)
    .compactMap { element -> DeclSyntax? in
      guard let associatedValue = element.parameterClause else {
        return nil
      }

      let variableNames = associatedValue
        .parameters
        .enumerated()
        .map { index, _ in
          "v\(index)"
        }
        .joined(separator: ", ")

      return DeclSyntax(
        try VariableDeclSyntax("\(declaration.modifiers)var \(element.name)Value: \(raw: associatedValue)?") {
          try IfExprSyntax("if case let .\(element.name)(\(raw: variableNames)) = self") {
            if associatedValue.parameters.count == 1 {
              "return \(raw: variableNames)"
            } else {
              "return (\(raw: variableNames))"
            }
          }
          "return nil"
        }
      )
    }
  }
}
