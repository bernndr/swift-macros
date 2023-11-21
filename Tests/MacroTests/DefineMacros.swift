import Foundation
import SwiftSyntaxMacros

#if canImport(Macros)
import Macros

let testMacros: [String: Macro.Type] = [
  "symbol": SymbolMacro.self,
  "URL": URLMacro.self
]
#endif
