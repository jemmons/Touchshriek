import Foundation


public extension Data {
  var hex: String {
    return enumerated().map { i, byte in
      return ((i.isMultiple(of: 4) && i != 0) ? " " : "") + String(format: "%02hhX", byte)
    }.joined()
  }
}
