import Foundation
import Ramona



public struct Chunk {
  public enum ChunkType {
    case header, track
    
    public var data: Data {
      switch self {
      case .header:
        return Data("MThd".utf8)
      case .track:
        return Data("MTrk".utf8)
      }
    }
  }
  
  
  let type: ChunkType
  let length: UInt32
  let body: Data
  
  
  public init(type: ChunkType, body: Data) {
    self.type = type
    self.body = body
    length = UInt32(clamping: body.count)
  }
}



extension Chunk: MultibyteConvertible {
  public var data: Data {
    var buf = type.data
    buf.append(doubleWord: length)
    buf.append(body)
    return buf
  }
}
