# Swift Macros 🚧(WIP)
Contains a collection of handy macros for your everyday project.

## Usage
### Symbol
```swift
let symbol = #symbol("swift") // Macro expands to "swift"
```
> [!NOTE]
> In case the provided value is not a valid SF Symbol, Xcode will show a compile error.

### URL
```swift
let url = #URL("https://www.swift.org") // Macro expands to URL(string: "https://www.swift.org")!
```
> [!NOTE]
> In case the provided value is not a valid URL, Xcode will show a compile error.
