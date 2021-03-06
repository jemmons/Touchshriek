import Foundation
import Ramona



public struct SMPTE: MultibyteConvertible {
  public enum Error: LocalizedError {
    case missingData
    public var errorDescription: String? {
      switch self {
      case .missingData: return "There is insufficient data to construct an SMPTE value."
      }
    }
  }
  
  
  public let hours: Int
  public let minutes: Int
  public let seconds: Int
  public let frames: Int
  public let fractionalFrames: Int
  
  
  public init(hours: Int, minutes: Int, seconds: Int, frames: Int, fractionalFrames: Int) {
    self.hours = hours
    self.minutes = minutes
    self.seconds = seconds
    self.frames = frames
    self.fractionalFrames = fractionalFrames
  }
  
  
  public init(hours: Int) {
    self.init(hours: hours, minutes: 0, seconds: 0, frames: 0, fractionalFrames: 0)
  }
  
  
  public init(data: Data) throws {
    guard data.count >= 5 else {
      throw Error.missingData
    }
    self.init(
      hours: Int(data[0]),
      minutes: Int(data[1]),
      seconds: Int(data[2]),
      frames: Int(data[3]),
      fractionalFrames: Int(data[4])
    )
  }
  
  
  public var data: Data {
    return Data([
      UInt8(clamping: hours),
      UInt8(clamping: minutes),
      UInt8(clamping: seconds),
      UInt8(clamping: frames),
      UInt8(clamping: fractionalFrames)
    ])
  }
}
