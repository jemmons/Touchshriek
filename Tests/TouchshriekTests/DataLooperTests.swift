import XCTest
import Touchshriek



class DataLooperTests: XCTestCase {
  let bytes: [UInt8] = [4, 8, 15, 16, 23, 42]


  func testNLoops() {
    var loops = 0
    var buf = [UInt8]()
    DataLooper(data: Data(bytes)) {
      try buf.append($0.next())
      loops += 1
    }
    XCTAssertEqual(buf, bytes)
    XCTAssertEqual(loops, bytes.count)
  }
  

  func testOneLoop() {
    var loops = 0
    var buf = [UInt8]()
    DataLooper(data: Data(bytes)) {
      try buf.append($0.next())
      try buf.append($0.next())
      try buf.append($0.next())
      try buf.append($0.next())
      try buf.append($0.next())
      try buf.append($0.next())
      loops += 1
    }
    XCTAssertEqual(buf, bytes)
    XCTAssertEqual(loops, 1)
  }
  
  
  func testLoopOutOfBounds() {
    var loops = 0
    var buf = [UInt8]()
    DataLooper(data: Data(bytes)) {
      try buf.append($0.next())
      try buf.append($0.next())
      try buf.append($0.next())
      try buf.append($0.next())
      try buf.append($0.next())
      try buf.append($0.next())
      loops += 1
      XCTAssert(true, "still in bounds")
      try buf.append($0.next())
      XCTFail("Out of bounds (should have thrown)")
      try buf.append($0.next())
    }
    XCTAssertEqual(buf, bytes)
    XCTAssertEqual(loops, 1)
  }
  
  
  func testDivisableLoops() {
    var loops = 0
    var buf = Data()
    DataLooper(data: Data(bytes)) {
      try buf.append($0.take(2))
      loops += 1
    }
    XCTAssertEqual(buf, Data(bytes))
    XCTAssertEqual(loops, 3)
  }
  
  
  func testIndivisableLoops() {
    var loops = 0
    var buf = Data()
    DataLooper(data: Data(bytes)) {
      try buf.append($0.take(4))
      loops += 1
    }
    XCTAssertEqual(buf, Data(bytes).prefix(4), "Only the first take happened.")
    XCTAssertEqual(loops, 1, "The second take went out of bounds, so aborted the second loop.")
  }

  
  func testEarlyExit() {
    var loops = 0
    var buf = Data()
    DataLooper(data: Data(bytes)) {
      let n = try $0.next()
      if n == 16 {
        throw DataLooper.Status.endLoop
      }
      buf.append(n)
      loops += 1
    }
    XCTAssertEqual(loops, 3)
    XCTAssertEqual(buf, Data(bytes).prefix(3))
  }
  
  
  func testTakeUntil() {
    var loops = 0
    var buf: [Data] = []
    DataLooper(data: Data(bytes)) {
      do {
        try buf.append($0.takeUntil {i in i.isMultiple(of: 3)})
      } catch {
        XCTFail("Should not go out of bounds — should exit loop naturally.")
      }
      loops += 1
    }
    XCTAssertEqual(loops, 2)
    XCTAssertEqual(buf[0], Data(bytes).prefix(3))
    XCTAssertEqual(buf[1], Data(bytes).dropFirst(3))
  }
  
  
  func testTakeUntilSome() {
    var loops = 0
    var buf = Data()
    DataLooper(data: Data(bytes)) {
      try buf = ($0.takeUntil { i in i == 16})
      loops += 1
    }
    XCTAssertEqual(loops, 1)
    XCTAssertEqual(buf, Data(bytes).prefix(4))
  }
  
  
  func testTakeUntilNever() {
    var loops = 0
    var buf: Data?
    DataLooper(data: Data(bytes)) {
      loops += 1
      buf = try $0.takeUntil() { _ in false }
      XCTFail("Never reached because `takeUntil` goes out of bounds")
    }
    XCTAssertEqual(loops, 1)
    XCTAssertNil(buf)
  }
}
