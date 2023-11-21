@freestanding(expression)
public macro symbol(_ name: String) -> String = #externalMacro(module: "Macros", type: "SymbolMacro")
