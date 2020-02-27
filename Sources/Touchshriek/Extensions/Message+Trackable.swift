import Foundation
import Ramona



extension Message: Trackable {
  public var trackData: Data {
    switch self {
    case .channel(let c):
      return c.data
    case .system(let s):
      #warning("Need to wrap this in a SYSEX escape.")
      return s.data
    }
  }
}

