import SwiftSyntax

extension TokenKind {
  var keyword: Keyword? {
    switch self {
    case let .keyword(keyword):
      return keyword
    default:
      return nil
    }
  }
}
