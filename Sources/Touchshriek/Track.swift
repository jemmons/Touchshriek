import Foundation
import CoreMIDI
import Ramona



public struct Track: Chunk {
  public let chunkType: ChunkType = .track
  public var chunkLength: UInt32 {
    UInt32(clamping: midiStream.count)
  }
  private let midiStream: Data
  
  
  public init(packetHash: PacketHash) {
    let sortedTimeStamps = packetHash.keys.sorted()
    var runningTimeStamp = RunningDelta(initial: MIDITimeStamp.zero)
    
    midiStream = sortedTimeStamps.flatMap { (timeStamp) -> [Event] in
      (packetHash[timeStamp] ?? []).map { message in
        let delta = runningTimeStamp.delta(to: timeStamp)
        let vlq = VariableLengthQuantity(Int(delta))
        return (delta: vlq, message: message)
      }
    }.reduce(into: Data()) { acc, next in
      acc.append(next.delta.bytes)
      acc.append(next.message.data)
    }
  }
}



public extension Track {
  var data: Data {
    var buf = Data()
    buf.append(chunkType.data)
    buf.append(doubleWord: chunkLength)
    buf.append(midiStream)
    return buf
  }
}
