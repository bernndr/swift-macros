import Foundation
import SwiftSyntaxMacros

#if canImport(Macros)
@testable import Macros

let testMacros: [String: Macro.Type] = [
  "symbol": SymbolMacro.self,
  "URL": URLMacro.self,
  "AssociatedValues": AssociatedValuesMacro.self,
  "Singleton": SingletonMacro.self
]
#endif
