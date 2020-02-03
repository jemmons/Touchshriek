import Foundation
import CoreMIDI
import Ramona



public struct Track: Chunk {
  public let chunkType: ChunkType = .track
  public var chunkLength: UInt32 {
    UInt32(clamping: body.count)
  }
  public let body: Data
  
  
  public init(packetHash: PacketHash) {
    let sortedTimeStamps = packetHash.keys.sorted()
    var runningTimeStamp = RunningTimeStamp()
    
    body = sortedTimeStamps.flatMap { (timeStamp) -> [Event] in
      (packetHash[timeStamp] ?? []).map { message in
        (delta: VariableLengthQuantity(Int(runningTimeStamp.delta(to: timeStamp))), message: message)
      }
    }.reduce(into: Data()) { acc, next in
      acc.append(next.delta.bytes)
      acc.append(next.message.bytes)
    }
  }
  
  public var data: Data {
    var buf = Data()
    buf.append(chunkType.data)
    buf.append(doubleWord: chunkLength)
    buf.append(fileType.data)
    buf.append(word: trackCount)
    buf.append(word: division.word)
    return buf
  }
}



private struct RunningTimeStamp {
  private var value: MIDITimeStamp = 0
  
  mutating func delta(to next: MIDITimeStamp) -> MIDITimeStamp {
    defer {
      value = next
    }
    return next - value
  }
}
