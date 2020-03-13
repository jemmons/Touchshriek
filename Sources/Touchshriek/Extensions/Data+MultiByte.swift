import Foundation


public enum DataError: LocalizedError {
  case parseFailure
  public var errorDescription: String? {
    switch self {
    case .parseFailure: return "Unable to parse data into type."
    }
  }
  
}


internal extension Data {
  init(word: UInt16) {
    var mutableWord = word.bigEndian
    self.init(bytes: &mutableWord, count: MemoryLayout<UInt16>.size)
  }

  
  init(long: UInt32) {
    var mutableLong = long.bigEndian
    self.init(bytes: &mutableLong, count: MemoryLayout<UInt32>.size)
  }
  
  
  mutating func append(word: UInt16) {
    var mutableWord = word.bigEndian
    append(UnsafeBufferPointer(start: &mutableWord, count: 1))
  }
  
  
  mutating func append(long: UInt32) {
    var mutableInt = long.bigEndian
    append(UnsafeBufferPointer(start: &mutableInt, count: 1))
  }
  
  
  func parse<T>() throws -> T where T: FixedWidthInteger {
    let size = MemoryLayout<T>.size
    guard count >= size else {
      throw DataError.parseFailure
    }
    return prefix(size).reduce(0) { $0 << 8 | T($1) }
  }
}
