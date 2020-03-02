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
          MetaEvent.trackName("Opening Arpeggios"),
          MetaEvent.instrumentName("Wedding Organ"),
          Message.channel(.programChange(channel: .ch1, program: .init(clamp: 19))),
          Message.channel(.noteOn(channel: .ch1, note: .d5, velocity: .ff))
        ],
        120: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .ff)),
          Message.channel(.noteOn(channel: .ch1, note: .d5, velocity: .off))
        ],
        240: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .off)),
          Message.channel(.noteOn(channel: .ch1, note: .a5, velocity: .ff)),
        ],
        360: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .ff)),
          Message.channel(.noteOn(channel: .ch1, note: .a5, velocity: .off)),
        ],
        480: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .off)),
          Message.channel(.noteOn(channel: .ch1, note: .g5, velocity: .ff)),
        ],
        600: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .ff)),
          Message.channel(.noteOn(channel: .ch1, note: .g5, velocity: .off)),
        ],
        720: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .off)),
          Message.channel(.noteOn(channel: .ch1, note: .f5, velocity: .ff)),
        ],
        840: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .ff)),
          Message.channel(.noteOn(channel: .ch1, note: .f5, velocity: .off)),
        ],
        960: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .off)),
          Message.channel(.noteOn(channel: .ch1, note: .e5, velocity: .ff)),
        ],
        1080: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .ff)),
          Message.channel(.noteOn(channel: .ch1, note: .e5, velocity: .off)),
        ],
        1200: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .off)),
          Message.channel(.noteOn(channel: .ch1, note: .f5, velocity: .ff)),
        ],
        1320: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .ff)),
          Message.channel(.noteOn(channel: .ch1, note: .f5, velocity: .off)),
        ],
        1440: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .off)),
          Message.channel(.noteOn(channel: .ch1, note: .e5, velocity: .ff)),
        ],
        1560: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .ff)),
          Message.channel(.noteOn(channel: .ch1, note: .e5, velocity: .off)),
        ],
        1680: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .off)),
          Message.channel(.noteOn(channel: .ch1, note: .d5, velocity: .ff)),
        ],
        1800: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .ff)),
          Message.channel(.noteOn(channel: .ch1, note: .d5, velocity: .off)),
        ],
        1920: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .off)),
          Message.channel(.noteOn(channel: .ch1, note: .e5, velocity: .ff)),
        ],
        2040: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .ff)),
          Message.channel(.noteOn(channel: .ch1, note: .e5, velocity: .off)),
        ],
        2160: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .off)),
          Message.channel(.noteOn(channel: .ch1, note: .f5, velocity: .ff)),
        ],
        2280: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .ff)),
          Message.channel(.noteOn(channel: .ch1, note: .f5, velocity: .off)),
        ],
        2400: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .off)),
          Message.channel(.noteOn(channel: .ch1, note: .g5, velocity: .ff)),
        ],
        2520: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .ff)),
          Message.channel(.noteOn(channel: .ch1, note: .g5, velocity: .off)),
        ],
        2640: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .off)),
          Message.channel(.noteOn(channel: .ch1, note: .f5, velocity: .ff)),
        ],
        2760: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .ff)),
          Message.channel(.noteOn(channel: .ch1, note: .f5, velocity: .off)),
        ],
        2880: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .off)),
          Message.channel(.noteOn(channel: .ch1, note: .e5, velocity: .ff)),
        ],
        3000: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .ff)),
          Message.channel(.noteOn(channel: .ch1, note: .e5, velocity: .off)),
        ],
        3120: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .off)),
          Message.channel(.noteOn(channel: .ch1, note: .c5, velocity: .ff)),
        ],
        3240: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .ff)),
          Message.channel(.noteOn(channel: .ch1, note: .c5, velocity: .off)),
        ],
        3360: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .off)),
          Message.channel(.noteOn(channel: .ch1, note: .e5, velocity: .ff)),
        ],
        3480: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .ff)),
          Message.channel(.noteOn(channel: .ch1, note: .e5, velocity: .off)),
        ],
        3600: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .off)),
          Message.channel(.noteOn(channel: .ch1, note: .d5, velocity: .ff)),
        ],
        3720: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .ff)),
          Message.channel(.noteOn(channel: .ch1, note: .d5, velocity: .off)),
        ],
        3840: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .off)),
          Message.channel(.noteOn(channel: .ch1, note: .d5, velocity: .ff)),
        ],
        3960: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .ff)),
          Message.channel(.noteOn(channel: .ch1, note: .d5, velocity: .off)),
        ],
        4080: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .off)),
          Message.channel(.noteOn(channel: .ch1, note: .a5, velocity: .ff)),
        ],
        4200: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .ff)),
          Message.channel(.noteOn(channel: .ch1, note: .a5, velocity: .off)),
        ],
        4320: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .off)),
          Message.channel(.noteOn(channel: .ch1, note: .g5, velocity: .ff)),
        ],
        4440: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .ff)),
          Message.channel(.noteOn(channel: .ch1, note: .g5, velocity: .off)),
        ],
        4560: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .off)),
          Message.channel(.noteOn(channel: .ch1, note: .f5, velocity: .ff)),
        ],
        4680: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .ff)),
          Message.channel(.noteOn(channel: .ch1, note: .f5, velocity: .off)),
        ],
        4800: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .off)),
          Message.channel(.noteOn(channel: .ch1, note: .e5, velocity: .ff)),
        ],
        4920: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .ff)),
          Message.channel(.noteOn(channel: .ch1, note: .e5, velocity: .off)),
        ],
        5040: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .off)),
          Message.channel(.noteOn(channel: .ch1, note: .f5, velocity: .ff)),
        ],
        5160: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .ff)),
          Message.channel(.noteOn(channel: .ch1, note: .f5, velocity: .off)),
        ],
        5280: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .off)),
          Message.channel(.noteOn(channel: .ch1, note: .e5, velocity: .ff)),
        ],
        5400: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .ff)),
          Message.channel(.noteOn(channel: .ch1, note: .e5, velocity: .off)),
        ],
        5520: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .off)),
          Message.channel(.noteOn(channel: .ch1, note: .d5, velocity: .ff)),
        ],
        5640: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .ff)),
          Message.channel(.noteOn(channel: .ch1, note: .d5, velocity: .off)),
        ],
        5760: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .off)),
          Message.channel(.noteOn(channel: .ch1, note: .e5, velocity: .ff)),
        ],
        5880: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .ff)),
          Message.channel(.noteOn(channel: .ch1, note: .e5, velocity: .off)),
        ],
        6000: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .off)),
          Message.channel(.noteOn(channel: .ch1, note: .f5, velocity: .ff)),
        ],
        6120: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .ff)),
          Message.channel(.noteOn(channel: .ch1, note: .f5, velocity: .off)),
        ],
        6240: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .off)),
          Message.channel(.noteOn(channel: .ch1, note: .g5, velocity: .ff)),
        ],
        6360: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .ff)),
          Message.channel(.noteOn(channel: .ch1, note: .g5, velocity: .off)),
        ],
        6480: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .off)),
          Message.channel(.noteOn(channel: .ch1, note: .f5, velocity: .ff)),
        ],
        6600: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .ff)),
          Message.channel(.noteOn(channel: .ch1, note: .f5, velocity: .off)),
        ],
        6720: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .off)),
          Message.channel(.noteOn(channel: .ch1, note: .e5, velocity: .ff)),
        ],
        6840: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .ff)),
          Message.channel(.noteOn(channel: .ch1, note: .e5, velocity: .off)),
        ],
        6960: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .off)),
          Message.channel(.noteOn(channel: .ch1, note: .c5, velocity: .ff)),
        ],
        7080: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .ff)),
          Message.channel(.noteOn(channel: .ch1, note: .c5, velocity: .off)),
        ],
        7200: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .off)),
          Message.channel(.noteOn(channel: .ch1, note: .e5, velocity: .ff)),
        ],
        7320: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .ff)),
          Message.channel(.noteOn(channel: .ch1, note: .e5, velocity: .off)),
        ],
        7440: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .off)),
          Message.channel(.noteOn(channel: .ch1, note: .d5, velocity: .ff)),
        ],
        7560: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .ff)),
          Message.channel(.noteOn(channel: .ch1, note: .d5, velocity: .off)),
        ],
        7680: [
          Message.channel(.noteOn(channel: .ch1, note: .a4, velocity: .off)),
          MetaEvent.endOfTrack
        ]
    ])
    let output = Data([
      0x4D, 0x54, 0x72, 0x6B, 0x00, 0x00, 0x01, 0xB3, 0x00, 0xFF, 0x20, 0x01, 0x00, 0x00, 0xFF, 0x03, 0x11, 0x4F, 0x70, 0x65, 0x6E, 0x69, 0x6E, 0x67, 0x20, 0x41, 0x72, 0x70, 0x65, 0x67, 0x67, 0x69, 0x6F, 0x73, 0x00, 0xFF, 0x04, 0x0D, 0x57, 0x65, 0x64, 0x64, 0x69, 0x6E, 0x67, 0x20, 0x4F, 0x72, 0x67, 0x61, 0x6E, 0x00, 0xC0, 0x13, 0x00, 0x90, 0x4A, 0x70, 0x78, 0x45, 0x70, 0x00, 0x4A, 0x00, 0x78, 0x45, 0x00, 0x00, 0x51, 0x70, 0x78, 0x45, 0x70, 0x00, 0x51, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4F, 0x70, 0x78, 0x45, 0x70, 0x00, 0x4F, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4D, 0x70, 0x78, 0x45, 0x70, 0x00, 0x4D, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x70, 0x78, 0x45, 0x70, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4D, 0x70, 0x78, 0x45, 0x70, 0x00, 0x4D, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x70, 0x78, 0x45, 0x70, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4A, 0x70, 0x78, 0x45, 0x70, 0x00, 0x4A, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x70, 0x78, 0x45, 0x70, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4D, 0x70, 0x78, 0x45, 0x70, 0x00, 0x4D, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4F, 0x70, 0x78, 0x45, 0x70, 0x00, 0x4F, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4D, 0x70, 0x78, 0x45, 0x70, 0x00, 0x4D, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x70, 0x78, 0x45, 0x70, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x48, 0x70, 0x78, 0x45, 0x70, 0x00, 0x48, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x70, 0x78, 0x45, 0x70, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4A, 0x70, 0x78, 0x45, 0x70, 0x00, 0x4A, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4A, 0x70, 0x78, 0x45, 0x70, 0x00, 0x4A, 0x00, 0x78, 0x45, 0x00, 0x00, 0x51, 0x70, 0x78, 0x45, 0x70, 0x00, 0x51, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4F, 0x70, 0x78, 0x45, 0x70, 0x00, 0x4F, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4D, 0x70, 0x78, 0x45, 0x70, 0x00, 0x4D, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x70, 0x78, 0x45, 0x70, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4D, 0x70, 0x78, 0x45, 0x70, 0x00, 0x4D, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x70, 0x78, 0x45, 0x70, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4A, 0x70, 0x78, 0x45, 0x70, 0x00, 0x4A, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x70, 0x78, 0x45, 0x70, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4D, 0x70, 0x78, 0x45, 0x70, 0x00, 0x4D, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4F, 0x70, 0x78, 0x45, 0x70, 0x00, 0x4F, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4D, 0x70, 0x78, 0x45, 0x70, 0x00, 0x4D, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x70, 0x78, 0x45, 0x70, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x48, 0x70, 0x78, 0x45, 0x70, 0x00, 0x48, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4C, 0x70, 0x78, 0x45, 0x70, 0x00, 0x4C, 0x00, 0x78, 0x45, 0x00, 0x00, 0x4A, 0x70, 0x78, 0x45, 0x70, 0x00, 0x4A, 0x00, 0x78, 0x45, 0x00, 0x00, 0xFF, 0x2F, 0x00])
    XCTAssertEqual(subject.data, output)
  }
}
