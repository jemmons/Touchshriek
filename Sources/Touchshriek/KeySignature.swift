import Foundation
import Ramona



public enum KeySignature: MultibyteConvertible {
  case cFlatMaj
  case gFlatMaj
  case dFlatMaj
  case aFlatMaj
  case eFlatMaj
  case bFlatMaj
  case fMaj
  case cMaj
  case gMaj
  case dMaj
  case aMaj
  case eMaj
  case bMaj
  case fSharpMaj
  case cSharpMaj
  
  case aFlatMin
  case eFlatMin
  case bFlatMin
  case fMin
  case cMin
  case gMin
  case dMin
  case aMin
  case eMin
  case bMin
  case fSharpMin
  case cSharpMin
  case gSharpMin
  case dSharpMin
  case aSharpMin
  
  
  public var data: Data {
    switch self {
    case .cFlatMaj: return Data([0xF9, 0x00])
    case .gFlatMaj: return Data([0xFA, 0x00])
    case .dFlatMaj: return Data([0xFB, 0x00])
    case .aFlatMaj: return Data([0xFC, 0x00])
    case .eFlatMaj: return Data([0xFD, 0x00])
    case .bFlatMaj: return Data([0xFE, 0x00])
    case .fMaj: return Data([0xFF, 0x00])
    case .cMaj: return Data([0x00, 0x00])
    case .gMaj: return Data([0x01, 0x00])
    case .dMaj: return Data([0x02, 0x00])
    case .aMaj: return Data([0x03, 0x00])
    case .eMaj: return Data([0x04, 0x00])
    case .bMaj: return Data([0x05, 0x00])
    case .fSharpMaj: return Data([0x06, 0x00])
    case .cSharpMaj: return Data([0x07, 0x00])
    case .aFlatMin: return Data([0xF9, 0x01])
    case .eFlatMin: return Data([0xFA, 0x01])
    case .bFlatMin: return Data([0xFB, 0x01])
    case .fMin: return Data([0xFC, 0x01])
    case .cMin: return Data([0xFD, 0x01])
    case .gMin: return Data([0xFE, 0x01])
    case .dMin: return Data([0xFF, 0x01])
    case .aMin: return Data([0x00, 0x01])
    case .eMin: return Data([0x01, 0x01])
    case .bMin: return Data([0x02, 0x01])
    case .fSharpMin: return Data([0x03, 0x01])
    case .cSharpMin: return Data([0x04, 0x01])
    case .gSharpMin: return Data([0x05, 0x01])
    case .dSharpMin: return Data([0x06, 0x01])
    case .aSharpMin: return Data([0x07, 0x01])
    }
  }
}
