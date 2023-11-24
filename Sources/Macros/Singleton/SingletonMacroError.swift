enum SingletonMacroError: Error, CustomStringConvertible {
  case notAStructOrClass
  
  var description: String {
    switch self {
    case .notAStructOrClass:
      "Can only be applied to a struct or class"
    }
  }
}
