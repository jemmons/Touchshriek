import Foundation
import Ramona



public struct Header {
  public enum FileType {
    case singleTrack
    case multiTrackSequence
    case multiTrackIndependent
    
    public enum Error: LocalizedError {
      case unknownType
      public var errorDescription: String? {
        switch self {
        case .unknownType: return "Unknown file type specified."
        }
      }
    }
    
    
    init(data: Data) throws {
      switch data {
      case Self.singleTrack.data:
        self = .singleTrack
      case Self.multiTrackSequence.data:
        self = .multiTrackSequence
      case Self.multiTrackIndependent.data:
        self = .multiTrackIndependent
      default:
        throw Error.unknownType
      }
    }
    
    
    var data: Data {
      switch self {
      case .singleTrack: return Data([0x00, 0x00])
      case .multiTrackSequence: return Data([0x00, 0x01])
      case .multiTrackIndependent: return Data([0x00, 0x02])
      }
    }
  }

  
  public enum Error: LocalizedError {
    case notHeaderChunk
    
    public var errorDescription: String? {
      switch self {
      case .notHeaderChunk: return "Chunk type is not “MThd”."
      }
    }
  }
  
  
  public let fileType: FileType
  public let trackCount: Int
  public let division: Division
  
  
  public init(chunk: Chunk) throws {
    guard
      case .header = chunk.type,
      chunk.length == 6 else {
        throw Error.notHeaderChunk
    }
    fileType = try FileType(data: chunk.body.prefix(2))
    trackCount = try Int(chunk.body.dropFirst(2).parse() as UInt16)
    division = try Division(data: chunk.body.dropFirst(4).prefix(2))
  }
  
  
  public var chunk: Chunk {
    var body = fileType.data
    body.append(word: UInt16(clamping: trackCount))
    body.append(word: division.word)

    return Chunk(type: .header, body: body)
  }
  
  
  public init(type: FileType, trackCount: Int, division: Division) {
    fileType = type
    self.trackCount = trackCount
    self.division = division
  }
}
