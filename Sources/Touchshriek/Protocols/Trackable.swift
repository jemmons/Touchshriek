import Foundation
import Ramona
import CoreMIDI



public protocol Trackable {
  var trackData: Data { get }
}



public typealias TrackableHash = [MIDITimeStamp: [Trackable]]



