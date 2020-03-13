import XCTest
import Touchshriek



class RunningDeltaTests: XCTestCase {
  func testPositiveDeltas() {
    var subject = RunningTotal(initial: 0)
    XCTAssertEqual(subject.delta(to: 4), 4)
    XCTAssertEqual(subject.delta(to: 8), 4)
    XCTAssertEqual(subject.delta(to: 15), 7)
    XCTAssertEqual(subject.delta(to: 16), 1)
    XCTAssertEqual(subject.delta(to: 23), 7)
    XCTAssertEqual(subject.delta(to: 42), 19)
  }
  
  
  func testTotals() {
    var subject = RunningTotal(initial: 0)
    XCTAssertEqual(subject.total(adding: 4), 4)
    XCTAssertEqual(subject.total(adding: 8), 12)
    XCTAssertEqual(subject.total(adding: 15), 27)
    XCTAssertEqual(subject.total(adding: 16), 43)
    XCTAssertEqual(subject.total(adding: 23), 66)
    XCTAssertEqual(subject.total(adding: 42), 108)
  }
}
