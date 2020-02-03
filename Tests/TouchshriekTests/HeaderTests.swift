import XCTest
import Touchshriek



class HeaderTests: XCTestCase {
  func testHeader() {
    let subject = Header(type: .multiTrackSequence, trackCount: 7, division: .metrical(ticksPerQuarterNote: 480))
    let output = Data([0x4D, 0x54, 0x68, 0x64, 0x00, 0x00, 0x00, 0x06, 0x00, 0x01, 0x00, 0x07, 0x01, 0xE0])
    XCTAssertEqual(subject.data, output)
  }
}
