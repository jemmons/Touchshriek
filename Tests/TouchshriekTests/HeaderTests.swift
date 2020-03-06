import XCTest
import Touchshriek



class HeaderTests: XCTestCase {
  let headerData = Data([0x4D, 0x54, 0x68, 0x64, 0x00, 0x00, 0x00, 0x06, 0x00, 0x01, 0x00, 0x03, 0x01, 0xE0])
  
  
  func testReadHeader() {
    let chunk = Chunk(type: .header, body: headerData.dropFirst(8))
    let subject = try! Header(chunk: chunk)
    XCTAssertEqual(subject.fileType, .multiTrackSequence)
    XCTAssertEqual(subject.division, Division.metrical(ticksPerQuarterNote: 480))
    XCTAssertEqual(subject.trackCount, 3)
  }
  
  
  func testWriteHeader() {
    let subject = Header(type: .multiTrackSequence, trackCount: 3, division: .metrical(ticksPerQuarterNote: 480))
    XCTAssertEqual(subject.chunk.data, headerData)
  }
}
