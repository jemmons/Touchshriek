import Foundation
import Ramona



public enum KeySignature: MultibyteConvertible {
  public enum Error: LocalizedError {
    case unrecognized
    public var errorDescription: String? {
      switch self {
      case .unrecognized: return "Unrecognized key signature."
      }
    }
  }
  
  
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
  
  
  public init(data: Data) throws {
    switch data {
    case Self.cFlatMaj.data: self = .cFlatMaj
    case Self.gFlatMaj.data: self = .gFlatMaj
    case Self.dFlatMaj.data: self = .dFlatMaj
    case Self.aFlatMaj.data: self = .aFlatMaj
    case Self.eFlatMaj.data: self = .eFlatMaj
    case Self.bFlatMaj.data: self = .bFlatMaj
    case Self.fMaj.data: self = .fMaj
    case Self.cMaj.data: self = .cMaj
    case Self.gMaj.data: self = .gMaj
    case Self.dMaj.data: self = .dMaj
    case Self.aMaj.data: self = .aMaj
    case Self.eMaj.data: self = .eMaj
    case Self.bMaj.data: self = .bMaj
    case Self.fSharpMaj.data: self = .fSharpMaj
    case Self.cSharpMaj.data: self = .cSharpMaj
    case Self.aFlatMin.data: self = .aFlatMin
    case Self.eFlatMin.data: self = .eFlatMin
    case Self.bFlatMin.data: self = .bFlatMin
    case Self.fMin.data: self = .fMin
    case Self.cMin.data: self = .cMin
    case Self.gMin.data: self = .gMin
    case Self.dMin.data: self = .dMin
    case Self.aMin.data: self = .aMin
    case Self.eMin.data: self = .eMin
    case Self.bMin.data: self = .bMin
    case Self.fSharpMin.data: self = .fSharpMin
    case Self.cSharpMin.data: self = .cSharpMin
    case Self.gSharpMin.data: self = .gSharpMin
    case Self.dSharpMin.data: self = .dSharpMin
    case Self.aSharpMin.data: self = .aSharpMin
    default:
      throw Error.unrecognized
    }
  }
  
  
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
