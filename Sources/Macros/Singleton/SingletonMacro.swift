import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

struct SingletonMacro: MemberMacro {
  static func expansion(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    guard [SwiftSyntax.SyntaxKind.classDecl, .structDecl].contains(declaration.kind) else {
      throw SingletonMacroError.notAStructOrClass
    }

    let nameOfDecl = try name(providingMembersOf: declaration).text
    let isPublic = declaration.modifiers.map(\.name.tokenKind.keyword).contains(.public)
    let initializer = try InitializerDeclSyntax("private init()") {}

    let shared = "\(isPublic ? "public" : "") static let shared = \(nameOfDecl)()"

    return [
      DeclSyntax(stringLiteral: shared),
      DeclSyntax(initializer),
    ]
  }
}

private extension SingletonMacro {
  static func name(providingMembersOf declaration: some DeclGroupSyntax) throws -> TokenSyntax {
    if let classDecl = declaration.as(ClassDeclSyntax.self) {
      classDecl.name
    } else if let structDecl = declaration.as(StructDeclSyntax.self) {
      structDecl.name
    } else {
      throw SingletonMacroError.notAStructOrClass
    }
  }
}
