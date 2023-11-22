import Foundation

enum AssociatedValuesMacroError: Error, CustomStringConvertible {
  case notAEnum
  
  var description: String {
    switch self {
    case .notAEnum:
      "@AssociatedValues Can only be applied to enum"
    }
  }
}
