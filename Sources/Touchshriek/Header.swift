import Foundation
import Ramona



public struct Header {
  public enum FileType {
    case singleTrack
    case multiTrackSequence
    case multiTrackIndependent
    
    var data: Data {
      switch self {
      case .singleTrack: return Data([0x00, 0x00])
      case .multiTrackSequence: return Data([0x00, 0x01])
      case .multiTrackIndependent: return Data([0x00, 0x02])
      }
    }
  }
  
  
  public let fileType: FileType
  public let trackCount: UInt16
  public let division: Division
  
  
  public init(chunk: Chunk) {
    fileType = .multiTrackIndependent
    trackCount = 1
    division = .metrical(ticksPerQuarterNote: 120)
  }
  
  
  public var chunk: Chunk {
    var body = fileType.data
    body.append(word: trackCount)
    body.append(word: division.word)

    return Chunk(type: .header, body: body)
  }
  
  
  public init(type: FileType, trackCount: Int, division: Division) {
    fileType = type
    self.trackCount = UInt16(clamping: trackCount)
    self.division = division
  }
}
