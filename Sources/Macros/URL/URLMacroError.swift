enum URLMacroError: Error, CustomStringConvertible {
  case requiresStaticStringLiteral
  case malformedURL(urlString: String)

  var description: String {
    switch self {
    case .requiresStaticStringLiteral:
      "#URL requires a static string literal"
    case .malformedURL(let urlString):
      "The input URL is malformed: \(urlString)"
    }
  }
}
