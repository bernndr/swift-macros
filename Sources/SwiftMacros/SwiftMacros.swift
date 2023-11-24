import Foundation

@freestanding(expression)
public macro URL(_ string: String) -> URL = #externalMacro(module: "Macros", type: "URLMacro")

@freestanding(expression)
public macro symbol(_ name: String) -> String = #externalMacro(module: "Macros", type: "SymbolMacro")

@freestanding(expression)
public macro unwrap<Wrapped>(_ wrapped: Wrapped?, default: Wrapped) -> Wrapped = #externalMacro(module: "Macros", type: "UnwrapMacro")

@attached(member, names: arbitrary)
public macro AssociatedValues() = #externalMacro(module: "Macros", type: "AssociatedValuesMacro")

@attached(member, names: named(init), named(shared))
public macro Singleton() = #externalMacro(module: "Macros", type: "SingletonMacro")
