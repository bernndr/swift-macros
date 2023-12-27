import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct Plugins: CompilerPlugin {
  let providingMacros: [Macro.Type] = [
    URLMacro.self,
    SymbolMacro.self,
    AssociatedValuesMacro.self,
    SingletonMacro.self
  ]
}
