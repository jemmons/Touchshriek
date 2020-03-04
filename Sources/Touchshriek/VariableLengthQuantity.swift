import Foundation
import Ramona



public struct VariableLengthQuantity {
  public let value: Int

  
  public init(_ value: Int) {
    self.value = value
  }
  
  
  public init(bytes: Data) {
    value = bytes.reduce(into: 0) { acc, next in
      acc <<= 7
      acc |= Int(next & 0b0111_1111)
    }
  }
}



extension VariableLengthQuantity: MultibyteConvertible {
  public var data: Data {
    var mutableValue = value
    var buf = Data([UInt8(clamping: mutableValue & 0b0111_1111)])
    mutableValue >>= 7
    while mutableValue > 0 {
      buf.insert(UInt8(mutableValue & 0b0111_1111 | 0b1000_0000), at: buf.startIndex)
      mutableValue >>= 7
    }
    return buf
  }
}

