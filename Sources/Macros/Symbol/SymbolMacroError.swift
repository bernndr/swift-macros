enum SymbolMacroError: Error, CustomStringConvertible {
  case invalidSymbol(name: String)
  case parseName

  var description: String {
    switch self {
    case .parseName:
      "Cannot parse SF Symbol name"
    case .invalidSymbol(let name):
      "\"\(name)\" is not a valid symbol"
    }
  }
}
