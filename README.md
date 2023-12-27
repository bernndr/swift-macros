# Swift Macros
Contains a collection of useful macros for my personal projects.

## Usage
### Symbol
```swift
let symbol = #symbol("swift") // Macro expands to "swift"
```
> In case the provided value is not a valid SF Symbol, Xcode will show a compile error.

### URL
```swift
let url = #URL("https://www.swift.org") // Macro expands to URL(string: "https://www.swift.org")!
```
> In case the provided value is not a valid URL, Xcode will show a compile error.

### AssociatedValues
Add variables to retrieve the associated values.

```swift
@AssociatedValues
enum Barcode {
  case upc(Int, Int, Int, Int)
  case qrCode(String)
}

// Expands to
enum Barcode {
  ...

  var upcValue: (Int, Int, Int, Int)? {
    if case let .upc(v0, v1, v2, v3) = self {
        return (v0, v1, v2, v3)
    }
    return nil
  }

  var qrCodeValue: (String)? {
    if case let .qrCode(v0) = self {
        return v0
    }
    return nil
  }
}
```

### Singleton
Generate singleton code for struct and class

```swift
@Singleton
struct UserStore {
}

// Expands to
struct UserStore {
  static let shared = UserStore()

  private init() {
  }
}
```
