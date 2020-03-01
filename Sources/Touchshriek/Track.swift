import Foundation
import CoreMIDI
import Ramona



public struct Track: Chunk {
  public let chunkType: ChunkType = .track
  public var chunkLength: UInt32 {
    UInt32(clamping: midiStream.count)
  }
  private var midiStream: Data
  private var runningStatus: UInt8?
  
  
  public init(packetHash: TrackableHash) {
    let sortedTimeStamps = packetHash.keys.sorted()
    var runningTimeStamp = RunningDelta(initial: MIDITimeStamp.zero)
    midiStream = Data()
    
    midiStream = sortedTimeStamps.flatMap { (timeStamp) -> [Event] in
      (packetHash[timeStamp] ?? []).map { message in
        let delta = runningTimeStamp.delta(to: timeStamp)
        let vlq = VariableLengthQuantity(Int(delta))
        var trackData = message.trackData
        switch message {
        case Ramona.Message.channel:
          let status = trackData.first
          switch status == runningStatus {
          case true:
            _ = trackData.popFirst()
          case false:
            runningStatus = status
          }
        default:
          runningStatus = nil
        }
        return (delta: vlq, trackData: trackData)
      }
    }.reduce(into: Data()) { acc, next in
      acc.append(next.delta.bytes)
      acc.append(next.trackData)
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
