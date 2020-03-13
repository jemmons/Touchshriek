import Foundation
import Ramona
import CoreMIDI



public protocol Trackable {
  var trackData: Data { get }
}



public typealias TrackableHash = [MIDITimeStamp: [Trackable]]



internal extension Dictionary where Value == [Trackable] {
  mutating func appendToCollection(at key: Key, element: Trackable) {
    if self[key] == nil {
      self[key] = [element]
    } else {
      self[key]!.append(element)
    }
  }
}
