import Foundation
import Ramona



public enum MetaEvent: Trackable {
  case sequenceNumber(Int)
  case text(String)
  case copyright(String)
  case trackName(String)
  case instrumentName(String)
  case lyric(String)
  case marker(String)
  case cuePoint(String)
  case midiChannel(Ramona.Channel)
  case endOfTrack
  case setTempo(Int)
  case smpteOffset(SMPTE)
  case timeSignature(TimeSignature)
  case keySignature(KeySignature)
  case sequencerSpecific(Data)
  
  
    
  public var trackData: Data {
    let eventData = data
    var buf = Data([0xFF, type])
    buf.append(VariableLengthQuantity(eventData.count).data)
    buf.append(eventData)
    return buf
  }

  
  private var type: UInt8 {
    switch self {
    case .sequenceNumber: return 0x00
    case .text: return 0x01
    case .copyright: return 0x02
    case .trackName: return 0x03
    case .instrumentName: return 0x04
    case .lyric: return 0x05
    case .marker: return 0x06
    case .cuePoint: return 0x07
    case .midiChannel: return 0x20
    case .endOfTrack: return 0x2F
    case .setTempo: return 0x51
    case .smpteOffset: return 0x54
    case .timeSignature: return 0x58
    case .keySignature: return 0x59
    case .sequencerSpecific: return 0x7F
    }
  }
  
  
  private var data: Data {
    switch self {
    case .sequenceNumber(let i): return Data(word: UInt16(clamping: i))
    case .text(let s),
         .copyright(let s),
         .trackName(let s),
         .instrumentName(let s),
         .lyric(let s),
         .marker(let s),
         .cuePoint(let s):
      return Data(s.utf8)
    case .midiChannel(let c): return Data([c.byte])
    case .endOfTrack: return Data()
    case .setTempo(let i):
      return Data([
        UInt8(clamping: (i & 0b1111_1111_0000_0000_0000_0000) >> 16),
        UInt8(clamping: (i & 0b1111_1111_0000_0000) >> 8),
        UInt8(clamping: (i & 0b1111_1111))
      ])
    case .smpteOffset(let smpte): return smpte.data
    case .timeSignature(let time): return time.data
    case .keySignature(let key): return key.data
    case .sequencerSpecific(let d): return d
    }
  }
}
