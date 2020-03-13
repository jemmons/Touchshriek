import Foundation
import Ramona



public struct Chunk {
  public enum Error: LocalizedError {
    case incompleteChunk
    case lengthMismatch
    case unknownType
    public var errorDescription: String? {
      switch self {
      case .incompleteChunk: return "Data does not represent complete chunk."
      case .lengthMismatch: return "The size of the chunk’s body does not agree with its stated length."
      case .unknownType: return "Unknown type (expected “MThd” or “MTrk”)"
      }
    }
  }
    
    
  public enum ChunkType {
    case header, track
    
    public init(data: Data) throws {
      switch data {
      case Self.header.data:
        self = .header
      case Self.track.data:
        self = .track
      default:
        throw Error.unknownType
      }
    }
    
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
  let length: Int
  let body: Data
  
  
  public init(data: Data) throws {
    guard data.count >= 8 else {
      throw Error.incompleteChunk
    }
    
    let type = try ChunkType.init(data: data.prefix(4))
    let length = try Int(data.dropFirst(4).parse() as UInt32)
    let body = data.dropFirst(8)
    
    guard length == body.count else {
      throw Error.lengthMismatch
    }
    
    self.init(type: type, body: body)
  }
  
  
  public init(type: ChunkType, body: Data) {
    self.type = type
    self.body = body
    length = body.count
  }
}



extension Chunk: MultibyteConvertible {
  public var data: Data {
    var buf = type.data
    buf.append(long: UInt32(clamping: length))
    buf.append(body)
    return buf
  }
}
