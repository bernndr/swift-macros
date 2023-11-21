import Foundation

@freestanding(expression)
public macro URL(_ string: String) -> URL = #externalMacro(module: "Macros", type: "URLMacro")

@freestanding(expression)
public macro symbol(_ name: String) -> String = #externalMacro(module: "Macros", type: "SymbolMacro")
