import Foundation
import Ramona



public struct TimeSignature: MultibyteConvertible {
  public enum Error: LocalizedError {
    case missingData
    public var localizedDescription: String {
      switch self {
      case .missingData: return "There is insufficient data to represent a TimeSignature."
      }
    }
  }
  public let numerator: Int
  public let denominator: Int
  public let midiClocksPerMetronomeTick: Int
  public let notated32ndNotesPer24MIDIClocks: Int
  
  
  public init(numerator: Int, denominator: Int) {
    self.numerator = numerator
    self.denominator = denominator
    midiClocksPerMetronomeTick = 24 // every quarter note
    notated32ndNotesPer24MIDIClocks = 8 // standard 24 clocks per notated quarter note (8 32nd notes == ♬ ♬ == ♫ == ♩)
  }
  
  
  public init(data: Data) throws {
    guard data.count >= 4 else {
      throw Error.missingData
    }
    numerator = Int(data[0])
    denominator = 2 << (Int(data[1]) - 1)
    midiClocksPerMetronomeTick = Int(data[2])
    notated32ndNotesPer24MIDIClocks = Int(data[3])
  }
  
  
  public var data: Data {
    return Data([
      UInt8(clamping: numerator),
      UInt8(clamping: Int(log(Double(denominator))/log(2.0))),
      UInt8(clamping: midiClocksPerMetronomeTick),
      UInt8(clamping: notated32ndNotesPer24MIDIClocks)
    ])
  }
}
