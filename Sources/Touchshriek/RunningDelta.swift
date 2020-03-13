import Foundation
import CoreMIDI



public struct RunningTotal<Value> where Value: AdditiveArithmetic {
  private var total: Value
  
  public init() {
    self.init(initial: Value.zero)
  }
  
  
  public init(initial: Value) {
    total = initial
  }
  
  
  public mutating func delta(to next: Value) -> Value {
    defer {
      total = next
    }
    return next - total
  }
  
  
  public mutating func total(adding: Value) -> Value {
    total += adding
    return total
  }
}
