import Foundation



public enum Division: Equatable {
  case metrical(ticksPerQuarterNote: Int)
  case smpteFilm(ticksPerFrame: Int),
  smptePAL(ticksPerFrame: Int),
  smpteDropFrameNTSC(ticksPerFrame: Int),
  smpteNTSC(ticksPerFrame: Int)
  
  
  public enum Error: LocalizedError {
    case unknownDivision
    public var errorDescription: String? {
      switch self {
      case .unknownDivision: return "Unrecognized division format."
      }
    }
  }
  
  
  init(data: Data) throws {
    let word: UInt16 = try data.parse()
    let byte = Int(UInt8(clamping: word))
    switch word & 0xFF00 {
    case 0xE800:
      self = .smpteFilm(ticksPerFrame: byte)
    case 0xE700:
      self = .smptePAL(ticksPerFrame: byte)
    case 0xE300:
      self = .smpteDropFrameNTSC(ticksPerFrame: byte)
    case 0xE200:
      self = .smpteNTSC(ticksPerFrame: byte)
    case ..<0x8000:
      self = .metrical(ticksPerQuarterNote: Int(word));
    default:
      throw Error.unknownDivision
    }
  }
  
  
  var word: UInt16 {
    switch self {
    case let .metrical(ticks):
      return UInt16(clamping: ticks & 0x7FFF)
    case let .smpteFilm(ticks):
      return UInt16(clamping: 0xE800 | (ticks & 0xFF))
    case let .smptePAL(ticks):
      return UInt16(clamping: 0xE700 | (ticks & 0xFF))
    case let .smpteDropFrameNTSC(ticks):
      return UInt16(clamping: 0xE300 | (ticks & 0xFF))
    case let .smpteNTSC(ticks):
      return UInt16(clamping: 0xE200 | (ticks & 0xFF))
    }
  }
}
