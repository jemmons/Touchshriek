import Foundation



public enum Division {
  case metrical(ticksPerQuarterNote: Int)
  case smpteFilm(ticksPerFrame: Int),
  smptePAL(ticksPerFrame: Int),
  smpteDropFrameNTSC(ticksPerFrame: Int),
  smpteNTSC(ticksPerFrame: Int)
  
  var word: UInt16 {
    switch self {
    case let .metrical(ticks):
      return UInt16(clamping: ticks & 0b0111_1111_1111_1111)
    case let .smpteFilm(ticks):
      return UInt16(clamping: 0xE800 | (ticks & 0b1111_1111))
    case let .smptePAL(ticks):
      return UInt16(clamping: 0xE700 | (ticks & 0b1111_1111))
    case let .smpteDropFrameNTSC(ticks):
      return UInt16(clamping: 0xE300 | (ticks & 0b1111_1111))
    case let .smpteNTSC(ticks):
      return UInt16(clamping: 0xE200 | (ticks & 0b1111_1111))
    }
  }
}
