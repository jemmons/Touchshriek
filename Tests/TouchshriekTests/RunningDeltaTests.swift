import XCTest
import Touchshriek



class RunningDeltaTests: XCTestCase {
  func testPositiveDeltas() {
    var subject = RunningDelta(initial: 0)
    XCTAssertEqual(subject.delta(to: 4), 4)
    XCTAssertEqual(subject.delta(to: 8), 4)
    XCTAssertEqual(subject.delta(to: 15), 7)
    XCTAssertEqual(subject.delta(to: 16), 1)
    XCTAssertEqual(subject.delta(to: 23), 7)
    XCTAssertEqual(subject.delta(to: 42), 19)
  }
}
