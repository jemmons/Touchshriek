import Foundation
import Ramona



public struct Event {
  let delta: VariableLengthQuantity
  let messageData: Data  
}



extension Event: MultibyteConvertible {
  public var data: Data {
    var buf = delta.data
    buf.append(messageData)
    return buf
  }
}
