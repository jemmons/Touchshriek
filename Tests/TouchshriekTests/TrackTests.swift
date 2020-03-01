import Foundation
import XCTest
import Touchshriek
import Ramona



class TrackTests: XCTestCase {
  func testFirstTrack() {
    let subject = Track(packetHash:
      [
        0: [
          MetaEvent.timeSignature(.init(numerator: 4, denominator: 4)),
          MetaEvent.keySignature(.cMaj),
          MetaEvent.smpteOffset(.init(hours: 33)),
          MetaEvent.setTempo(566037),
          MetaEvent.endOfTrack
        ]
      ]
    )
    let expected = Data([0x4D, 0x54, 0x72, 0x6B, 0x00, 0x00, 0x00, 0x22, 0x00, 0xFF, 0x58, 0x04, 0x04, 0x02, 0x18, 0x08, 0x00, 0xFF, 0x59, 0x02, 0x00, 0x00, 0x00, 0xFF, 0x54, 0x05, 0x21, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x51, 0x03, 0x08, 0xA3, 0x15, 0x00, 0xFF, 0x2F, 0x00])
    
    XCTAssertEqual(subject.data, expected)
  }
  
  func testOrganTrack() {
    let subject = Track(packetHash:
      [
        0: [
          MetaEvent.midiChannel(.ch1),
          MetaEvent.trackName(" DrawOrgan    "),
          MetaEvent.instrumentName("(Multi Instr.)  1"),
          Message.channel(.programChange(channel: .ch1, program: .init(clamp: 19))),
          Message.channel(.noteOn(channel: .ch1, note: .d5, velocity: .init(clamp: 105)))
        ],
        120: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .init(clamp: 105))),
          Message.channel(.noteOn(channel: .ch1, note: .d5, velocity: .off))
        ],
        240: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .off)),
          Message.channel(.noteOn(channel: .ch1, note: .a5, velocity: .init(clamp: 105))),
        ],
        360: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .init(clamp: 105))),
          Message.channel(.noteOn(channel: .ch1, note: .a5, velocity: .off)),
        ],
    ])
    print(subject.data.hex)
    let output = Data([0x4D, 0x54, 0x72, 0x6B, 0x00, 0x00, 0x04, 0xB6, 0x00, 0xFF, 0x20, 0x01, 0x00, 0x00, 0xFF, 0x03, 0x0E, 0x20, 0x44, 0x72, 0x61, 0x77, 0x4F, 0x72, 0x67, 0x61, 0x6E, 0x20, 0x20, 0x20, 0x20, 0x00, 0xFF, 0x04, 0x11, 0x28, 0x4D, 0x75, 0x6C, 0x74, 0x69, 0x20, 0x49, 0x6E, 0x73, 0x74, 0x72, 0x2E, 0x29, 0x20, 0x20, 0x31, 0x00, 0xC0, 0x13, 0x00, 0x90, 0x4A, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4A, 0x00, 0x78, 0x45, 0x00, 0x00, 0x51, 0x69, 0x78, 0x45, 0x69, 0x00, 0x51, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4F, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4F, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4D, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4D, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4D, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4D, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4A, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4A, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4D, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4D, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4F, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4F, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4D, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4D, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x48, 0x69, 0x78, 0x45, 0x69, 0x00, 0x48, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4A, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4A, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4A, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4A, 0x00, 0x78, 0x45, 0x00, 0x00, 0x51, 0x69, 0x78, 0x45, 0x69, 0x00, 0x51, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4F, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4F, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4D, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4D, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4D, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4D, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4A, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4A, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4D, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4D, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4F, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4F, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4D, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4D, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x48, 0x69, 0x78, 0x45, 0x69, 0x00, 0x48, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4A, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4A, 0x00, 0x78, 0x45, 0x00, 0xF8, 0x00, 0x4A, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4A, 0x00, 0x78, 0x45, 0x00, 0x00, 0x51, 0x69, 0x78, 0x45, 0x69, 0x00, 0x51, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4F, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4F, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4D, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4D, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4D, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4D, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4A, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4A, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4D, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4D, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4F, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4F, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4D, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4D, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x48, 0x69, 0x78, 0x45, 0x69, 0x00, 0x48, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4A, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4A, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4A, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4A, 0x00, 0x78, 0x45, 0x00, 0x00, 0x51, 0x69, 0x78, 0x45, 0x69, 0x00, 0x51, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4F, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4F, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4D, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4D, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4D, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4D, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4A, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4A, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4D, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4D, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4F, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4F, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4D, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4D, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x48, 0x69, 0x78, 0x45, 0x69, 0x00, 0x48, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4A, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4A, 0x00, 0x78, 0x45, 0x00, 0xF8, 0x00, 0x4A, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4A, 0x00, 0x78, 0x45, 0x00, 0x00, 0x51, 0x69, 0x78, 0x45, 0x69, 0x00, 0x51, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4F, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4F, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4D, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4D, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4D, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4D, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4A, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4A, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4D, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4D, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4F, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4F, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4D, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4D, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x48, 0x69, 0x78, 0x45, 0x69, 0x00, 0x48, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4A, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4A, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4A, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4A, 0x00, 0x78, 0x45, 0x00, 0x00, 0x51, 0x69, 0x78, 0x45, 0x69, 0x00, 0x51, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4F, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4F, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4D, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4D, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4D, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4D, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4A, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4A, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4D, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4D, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4F, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4F, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4D, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4D, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x48, 0x69, 0x78, 0x45, 0x69, 0x00, 0x48, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4A, 0x69, 0x78, 0x45, 0x69, 0x00, 0x4A, 0x00, 0x78, 0x45, 0x00, 0x00, 0xFF, 0x2F, 0x00])
  }
}
