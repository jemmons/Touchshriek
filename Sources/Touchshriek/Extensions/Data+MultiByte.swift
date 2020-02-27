import Foundation



internal extension Data {
  init(word: UInt16) {
    var mutableWord = word.bigEndian
    self.init(bytes: &mutableWord, count: MemoryLayout<UInt16>.size)
  }

  
  init(doubleWord: UInt32) {
    var mutableDoubleWord = doubleWord.bigEndian
    self.init(bytes: &mutableDoubleWord, count: MemoryLayout<UInt32>.size)
  }
  
  
  mutating func append(word: UInt16) {
    var mutableWord = word.bigEndian
    append(UnsafeBufferPointer(start: &mutableWord, count: 1))
  }
  
  
  mutating func append(doubleWord: UInt32) {
    var mutableInt = doubleWord.bigEndian
    append(UnsafeBufferPointer(start: &mutableInt, count: 1))
  }
}
