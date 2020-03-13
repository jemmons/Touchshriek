import Foundation



public struct DataLooper {
  public enum Error: LocalizedError {
    case outOfBounds
    public var errorDescription: String? {
      switch self {
      case .outOfBounds: return "Request for data larger than total size."
      }
    }
  }
  
  
  public enum Status: LocalizedError {
    case endLoop
    public var errorDescription: String? {
      switch self {
      case .endLoop: return "It was politely requested that we stop looping."
      }
    }
  }
  
  
  private var data: Data
  
  
  @discardableResult
  public init(data: Data, loop: (inout Self) throws -> Void) {
    self.data = data
    while !self.data.isEmpty {
      do {
        try loop(&self)
      } catch {
        break
      }
    }
  }

  
  public mutating func take(_ n: Int) throws -> Data {
    guard data.count >= n else {
      throw Error.outOfBounds
    }
    defer {
      data = data.dropFirst(n)
    }
    return data.prefix(n)
  }
  
  
  public mutating func next() throws -> UInt8 {
    let d = try take(1)
    return d[d.startIndex]
  }


  public mutating func takeUntil(predicate: (UInt8)->Bool) throws -> Data {
    var stop = false
    var buf = Data()
    while !stop {
      let nextByte = try next()
      buf.append(nextByte)
      stop = predicate(nextByte)
    }
    return buf
  }
}
