import Foundation
import Ramona



public struct TimeSignature: MultibyteConvertible {
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
  
  
  public var data: Data {
    return Data([
      UInt8(clamping: numerator),
      UInt8(clamping: Int(log(Double(denominator))/log(2.0))),
      UInt8(clamping: midiClocksPerMetronomeTick),
      UInt8(clamping: notated32ndNotesPer24MIDIClocks)
    ])
  }
}
