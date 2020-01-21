import Foundation
import Ramona


public struct Header: Chunk {
  public enum FileType {
    case singleTrack
    case multiTrackSequence
    case multiTrackIndependent
    
    var data: Data {
      switch self {
      case .singleTrack: return Data(repeating: 0, count: 2)
      case .multiTrackSequence: return Data([0x00, 0x01])
      case .multiTrackIndependent: return Data([0x00, 0x02])
      }
    }
  }
  
  
  public let chunkType = ChunkType.header
  public var chunkLength = UInt32(6)
  public let fileType: FileType
  public let trackCount: UInt16
  public let division: Division
  
  
  public init(type: FileType, trackCount: Int, division: Division) {
    fileType = type
    self.trackCount = UInt16(clamping: trackCount)
    self.division = division
  }
}



public extension Header {
  var data: Data {
    var buf = Data()
    buf.append(chunkType.data)
    buf.append(doubleWord: chunkLength)
    buf.append(fileType.data)
    buf.append(word: trackCount)
    buf.append(word: division.word)
    return buf
  }
}



private extension Data {
  mutating func append(word: UInt16) {
    var mutableWord = word.bigEndian
    append(UnsafeBufferPointer(start: &mutableWord, count: 1))
  }
  
  
  mutating func append(doubleWord: UInt32) {
    var mutableInt = doubleWord.bigEndian
    append(UnsafeBufferPointer(start: &mutableInt, count: 1))
  }
}
