import Foundation

public struct SearchResult: Decodable {
    /// The name of the track, song, video, TV episode, and so on.
    public let trackName: String?
    
    /// The explicitness of the track.
    public let trackExplicitness: Explicitness?
    
    /// An iTunes Store URL for the content.
    public let trackViewURL: URL?
    
    /// A URL referencing the 30-second preview file for the content associated with the returned media type.
    /// - Note: This is available when media type is track.
    public let previewURL: URL?
    
    /// The name of the artist, and so on.
    public let artistName: String?
    
    /// The name of the album, TV season, audiobook, and so on.
    public let collectionName: String?
    
    /// A URL for the artwork associated with the returned media type,
    private let artworkURL100: URL?
    
    func artworkURL(size dimension: Int = 100) -> URL? {
        guard dimension > 0, dimension != 100,
            var url = self.artworkURL100 else {
                return self.artworkURL100
        }
        
        url.deleteLastPathComponent()
        url.appendPathComponent("\(dimension)x\(dimension)bb.jpg")
        
        return url
    }
    
    private enum CodingKeys: String, CodingKey {
        case trackName
        case trackExplicitness
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artistName
        case collectionName
        case artworkURL100 = "artworkUrl100"
    }
}
