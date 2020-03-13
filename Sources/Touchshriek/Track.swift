import Foundation
import CoreMIDI
import Ramona



public struct Track {
  public enum Error: LocalizedError {
    case notTrackChunk
    
    public var errorDescription: String? {
      switch self {
      case .notTrackChunk: return "Expected chunk type “MTrk”."
      }
    }
  }

  
  public var messagesByTimeStamp: TrackableHash
  
  
  public init(messagesByTimeStamp: TrackableHash) {
    self.messagesByTimeStamp = messagesByTimeStamp
  }
  
  
  public init(chunk: Chunk) throws {
    guard case .track = chunk.type else {
      throw Error.notTrackChunk
    }
    self.init(messagesByTimeStamp: [:])
  }

  
  public func makeChunk() -> Chunk {
    let sortedTimeStamps = messagesByTimeStamp.keys.sorted()
    var runningTimeStamp = RunningTotal(initial: MIDITimeStamp.zero)
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
}


private enum Helper {
  static func parse(data: Data) -> TrackableHash {
    #warning("Doesn't support running status yet")
    #warning("Doesn't support sysex yet")
    var runningTimeStamp = RunningTotal(initial: MIDITimeStamp.zero)
    var hash: TrackableHash = [:]
    DataLooper(data: data) {
      let deltaData = try $0.takeUntil(predicate: isEndOfQuantity)
      let midiTimeStamp = runningTimeStamp.total(adding: timeStamp(from: deltaData))
      let status = try $0.next()
      let trackable: Trackable?
      
      if status == 0xFF {
        let type = try $0.next()
        let lengthData = try $0.takeUntil(predicate: isEndOfQuantity)
        let body = try $0.take(length(from: lengthData))
        trackable = try? MetaEvent(type: type, body: body)
      } else {
        trackable = nil
      }
      
      guard let someTrackable = trackable else {
        return
      }
      hash.appendToCollection(at: midiTimeStamp, element: someTrackable)
    }
    return hash
  }
  
  
  private static func isEndOfQuantity(byte: UInt8) -> Bool {
    byte & 0b1000_0000 == 0
  }
  
  private static func timeStamp(from data: Data) -> MIDITimeStamp {
    MIDITimeStamp(VariableLengthQuantity(data: data).value)
  }
  
  
  private static func length(from data: Data) -> Int {
    VariableLengthQuantity(data: data).value
  }
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
