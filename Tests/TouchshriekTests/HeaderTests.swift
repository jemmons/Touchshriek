import XCTest
import Touchshriek



class HeaderTests: XCTestCase {
  func testHeader() {
    let data = Header(type: .multiTrackSequence, trackCount: 7, division: .metrical(ticksPerQuarterNote: 480)).data
    print(data.map { String(format: "%02hhX", $0) }.joined())

  }
}
