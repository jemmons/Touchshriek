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
  case unknown(type: UInt8, body: Data)
  
  
  public init(type: UInt8, body: Data) throws {
    switch type {
    case 0x00:
      try self = .sequenceNumber(body.parse())
    case 0x01:
      try self = .text(String(utf8: body))
    case 0x02:
      try self = .copyright(String(utf8: body))
    case 0x03:
      try self = .trackName(String(utf8: body))
    case 0x04:
      try self = .instrumentName(String(utf8: body))
    case 0x05:
      try self = .lyric(String(utf8: body))
    case 0x06:
      try self = .marker(String(utf8: body))
    case 0x07:
      try self = .cuePoint(String(utf8: body))
    case 0x20:
      try self = .midiChannel(Channel(data: body))
    case 0x2F:
      self = .endOfTrack
    case 0x51:
      let tempo = body.prefix(3).reduce(0) { $0 << 8 | Int($1) }
      self = .setTempo(tempo)
    case 0x54:
      try self = .smpteOffset(SMPTE(data: body))
    case 0x58:
      try self = .timeSignature(TimeSignature(data: body))
    case 0x59:
      try self = .keySignature(KeySignature(data: body))
    case 0x7F:
      self = .sequencerSpecific(body)
    case let type:
      self = .unknown(type: type, body: body)
    }
  }
    
  
  public var trackData: Data {
    var buf = Data([0xFF, type])
    let body = makeBody()
    buf.append(VariableLengthQuantity(body.count).data)
    buf.append(body)
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
    case .unknown(type: let type, body: _): return type
    }
  }
  
  
  private func makeBody() -> Data {
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
        UInt8(clamping: (i & 0xFF_00_00) >> 16),
        UInt8(clamping: (i & 0x00_FF_00) >> 8),
        UInt8(clamping: (i & 0x00_00_FF))
      ])
    case .smpteOffset(let smpte): return smpte.data
    case .timeSignature(let time): return time.data
    case .keySignature(let key): return key.data
    case .sequencerSpecific(let d): return d
    case .unknown(type: _, body: let body): return body
    }
  }
}



public enum StringConversionError: LocalizedError {
  case utf8
  
  public var errorDescription: String? {
    switch self {
    case .utf8: return "The given data does not represent a UTF-8 string."
    }
  }
}



private extension String {
  init(utf8: Data) throws {
    guard let new = Self(data: utf8, encoding: .utf8) else {
      throw StringConversionError.utf8
    }
    self = new
  }
}
