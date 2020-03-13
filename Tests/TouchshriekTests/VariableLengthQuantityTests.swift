import XCTest
import Touchshriek



class VariableLengthQuantityTests: XCTestCase {
  func testToBytes() {
    let subjects = [
      0,
      0x40,
      0x7F,
      0x80,
      0x20_00,
      0x3F_FF,
      0x40_00,
      0x10_00_00,
      0x1F_FF_FF,
      0x20_00_00,
      0x08_00_00_00,
      0x0F_FF_FF_FF
      ].map(VariableLengthQuantity.init)
    
    let results = [
      Data([00]),
      Data([0x40]),
      Data([0x7F]),
      Data([0x81, 0x00]),
      Data([0xC0, 0x00]),
      Data([0xFF, 0x7F]),
      Data([0x81, 0x80, 0x00]),
      Data([0xC0, 0x80, 0x00]),
      Data([0xFF, 0xFF, 0x7F]),
      Data([0x81, 0x80, 0x80, 0x00]),
      Data([0xC0, 0x80, 0x80, 0x00]),
      Data([0xFF, 0xFF, 0xFF, 0x7F])
    ]
    XCTAssertEqual(results, subjects.map { $0.data })
  }
  
  
  func testFromBytes() {
    let subjects = [
      Data([00]),
      Data([0x40]),
      Data([0x7F]),
      Data([0x81, 0x00]),
      Data([0xC0, 0x00]),
      Data([0xFF, 0x7F]),
      Data([0x81, 0x80, 0x00]),
      Data([0xC0, 0x80, 0x00]),
      Data([0xFF, 0xFF, 0x7F]),
      Data([0x81, 0x80, 0x80, 0x00]),
      Data([0xC0, 0x80, 0x80, 0x00]),
      Data([0xFF, 0xFF, 0xFF, 0x7F])
      ].map(VariableLengthQuantity.init(data:))
    let results = [
      0,
      0x40,
      0x7F,
      0x80,
      0x20_00,
      0x3F_FF,
      0x40_00,
      0x10_00_00,
      0x1F_FF_FF,
      0x20_00_00,
      0x08_00_00_00,
      0x0F_FF_FF_FF
    ]
    XCTAssertEqual(results, subjects.map { $0.value })
  }
  
  
  func testRoundTrip() {
    (1...100).forEach { it in
      XCTAssertEqual(it, VariableLengthQuantity(data: VariableLengthQuantity(it).data).value)
    }
    (500...600).forEach { it in
      XCTAssertEqual(it, VariableLengthQuantity(data: VariableLengthQuantity(it).data).value)
    }
    (20_000...20_100).forEach { it in
      XCTAssertEqual(it, VariableLengthQuantity(data: VariableLengthQuantity(it).data).value)
    }
    (300_500...300_600).forEach { it in
      XCTAssertEqual(it, VariableLengthQuantity(data: VariableLengthQuantity(it).data).value)
    }
  }
}
