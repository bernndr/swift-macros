enum AssociatedValuesMacroError: Error, CustomStringConvertible {
  case notAEnum
  
  var description: String {
    switch self {
    case .notAEnum:
      "Can only be applied to enum"
    }
  }
}
