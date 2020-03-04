import Foundation
import CoreMIDI
import Ramona



public struct Track {
  public var messagesByTimeStamp: TrackableHash
  
  
  public init(messagesByTimeStamp: TrackableHash) {
    self.messagesByTimeStamp = messagesByTimeStamp
  }
  
  
  public init(chunk: Chunk) throws {
    messagesByTimeStamp = [:]
  }

  
  public var chunk: Chunk {
    let sortedTimeStamps = messagesByTimeStamp.keys.sorted()
    var runningTimeStamp = RunningDelta(initial: MIDITimeStamp.zero)
    let statusStrategy = RunningStatusStrategy()
    
    let body = sortedTimeStamps.flatMap { timeStamp -> [Event] in
      (messagesByTimeStamp[timeStamp] ?? []).map { message in
        let delta = runningTimeStamp.delta(to: timeStamp)
        let vlq = VariableLengthQuantity(Int(delta))
        let messageData = statusStrategy.parseMessage(message)
        
        return Event(delta: vlq, messageData: messageData)
      }
    }.reduce(into: Data()) { data, next in
      data.append(next.data)
    }
    
    return Chunk(type: .track, body: body)
  }

  
//  public init(packetHash: TrackableHash) {
//    let sortedTimeStamps = packetHash.keys.sorted()
//    var runningTimeStamp = RunningDelta(initial: MIDITimeStamp.zero)
//    midiStream = Data()
//
//    midiStream = sortedTimeStamps.flatMap { (timeStamp) -> [Event] in
//      (packetHash[timeStamp] ?? []).map { message in
//        let delta = runningTimeStamp.delta(to: timeStamp)
//        let vlq = VariableLengthQuantity(Int(delta))
//        var trackData = message.trackData
//        switch message {
//        case Ramona.Message.channel:
//          let status = trackData.first
//          switch status == runningStatus {
//          case true:
//            _ = trackData.popFirst()
//          case false:
//            runningStatus = status
//          }
//        default:
//          runningStatus = nil
//        }
//        return (delta: vlq, trackData: trackData)
//      }
//    }.reduce(into: Data()) { acc, next in
//      acc.append(next.delta.bytes)
//      acc.append(next.trackData)
//    }
//  }
}



private class RunningStatusStrategy {
  private var runningStatus: UInt8?
  
  func parseMessage(_ message: Trackable) -> Data {
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
    
    return trackData
  }
}
