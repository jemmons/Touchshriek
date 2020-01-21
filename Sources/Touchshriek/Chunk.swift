import Foundation


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


public protocol Chunk {
  var chunkType: ChunkType { get }
  var chunkLength: UInt32 { get }
}
