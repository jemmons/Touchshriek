import Foundation
import CoreMIDI



public struct RunningDelta<Value> where Value: AdditiveArithmetic {
  private var value: Value
  
  public init() {
    value = Value.zero
  }
  
  
  public init(initial: Value) {
    value = initial
  }
  
  
  public mutating func delta(to next: Value) -> Value {
    defer {
      value = next
    }
    return next - value
  }
}
