import Foundation



internal extension Data {
  mutating func append(word: UInt16) {
    var mutableWord = word.bigEndian
    append(UnsafeBufferPointer(start: &mutableWord, count: 1))
  }
  
  
  mutating func append(doubleWord: UInt32) {
    var mutableInt = doubleWord.bigEndian
    append(UnsafeBufferPointer(start: &mutableInt, count: 1))
  }
}
