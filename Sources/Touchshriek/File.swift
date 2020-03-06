import Foundation



public struct File {
  enum Error: LocalizedError {
    case incompleteChunk, noChunksFound, trackCountMismatch
    var errorDescription: String? {
      switch self {
      case .incompleteChunk: return "We ran out of file before we ran out of chunk."
      case .noChunksFound: return "No chunks were found in this file."
      case .trackCountMismatch: return "The header does not agree with actual number of tracks found."
      }
    }
  }
  public let header: Header
  public let tracks: [Track]
  
  
  public init(data: Data) throws {
    let chunks = try Helper.parseChunks(from: data)
    guard let headerChunk = chunks.first else {
      throw Error.noChunksFound
    }
    
    header = try Header(chunk: headerChunk)
    tracks = try chunks.dropFirst().map(Track.init(chunk:))
    
    guard header.trackCount == tracks.count else {
      print(header.trackCount)
      print(tracks.count)
      throw Error.trackCountMismatch
    }
  }
}



private enum Helper {
  static func parseChunks(from data: Data) throws -> [Chunk] {
    var buf = data
    var chunks = [Chunk]()
    
    while !buf.isEmpty {
      let (newChunk, newBuf) = try takeFirstChunk(from: buf)
      chunks.append(newChunk)
      buf = newBuf
    }
    
    return chunks
  }
  
  
  private static func takeFirstChunk(from data: Data) throws -> (Chunk, Data) {
    guard data.count >= 8 else {
      throw File.Error.incompleteChunk
    }

    let chunkType = try Chunk.ChunkType(data: data.prefix(4))
    let length: UInt32 = try data.dropFirst(4).parse()
    guard data.count >= 8 + length else {
      throw File.Error.incompleteChunk
    }
    
    return (Chunk(type: chunkType, body: data.dropFirst(8).prefix(Int(length))), data.dropFirst(8 + Int(length)))
  }
}
