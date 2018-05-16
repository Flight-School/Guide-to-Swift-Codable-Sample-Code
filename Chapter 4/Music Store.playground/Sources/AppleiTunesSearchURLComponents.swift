import Foundation

public protocol MediaType {
    associatedtype Entity: RawRepresentable where Entity.RawValue == String
    associatedtype Attribute: RawRepresentable where Attribute.RawValue == String
}

public enum Movie: MediaType {
    public enum Entity: String {
        case movie
        case artist = "movieArtist"
    }
    
    public enum Attribute: String {
        case actor = "actorTerm"
        case genre = "genreIndex"
        case artist = "artistTerm"
        case shortFilm = "shortFilmTerm"
        case producer = "producerTerm"
        case ratingTerm = "ratingTerm"
        case director = "directorTerm"
        case releaseYear = "releaseYearTerm"
        case featureFilm = "featureFilmTerm"
        case movieArtist = "movieArtistTerm"
        case movie = "movieTerm"
        case ratingIndex = "ratingIndex"
        case description = "descriptionTerm"
    }
}

public struct Podcast: MediaType {
    public enum Entity: String {
        case podcast
        case author = "podcastAuthor"
    }
    
    public enum Attribute: String {
        case title = "titleTerm"
        case language = "languageTerm"
        case author = "authorTerm"
        case genre = "genreIndex"
        case artist = "artistTerm"
        case rating = "ratingIndex"
        case keywords = "keywordsTerm"
        case description = "descriptionTerm"
    }
}

public struct Music: MediaType {
    public enum Entity: String {
        case artist = "musicArtist"
        case track = "musicTrack"
        case album
        case musicVideo
        case mix
        case song
    }
    
    public enum Attribute: String {
        case mix = "mixTerm"
        case genre = "genreIndex"
        case artist = "artistTerm"
        case composer = "composerTerm"
        case album = "albumTerm"
        case rating = "ratingIndex"
        case song = "songTerm"
    }
}

public struct MusicVideo: MediaType {
    public enum Entity: String {
        case musicVideo
        case artist = "musicArtist"
    }
    
    public enum Attribute: String {
        case genre = "genreIndex"
        case artist = "artistTerm"
        case album = "albumTerm"
        case rating = "ratingIndex"
        case song = "songTerm"
    }
}

public struct AudioBook: MediaType {
    public enum Entity: String {
        case audiobook
        case author = "audiobookAuthor"
    }
    
    public enum Attribute: String {
        case title = "titleTerm"
        case author = "authorTerm"
        case genre = "genreIndex"
        case rating = "ratingIndex"
    }
}

public struct ShortFilm: MediaType {
    public enum Entity: String {
        case shortFilm
        case artist = "shortFilmArtist"
    }
    
    public enum Attribute: String {
        case genre = "genreIndex"
        case artist = "artistTerm"
        case shortFilm = "shortFilmTerm"
        case rating = "ratingIndex"
        case description = "descriptionTerm"
    }
}

struct TVShow: MediaType {
    enum Entity: String {
        case episode = "tvEpisode"
        case season = "tvSeason"
    }
    
    enum Attribute: String {
        case genre = "genreIndex"
        case episode = "tvEpisodeTerm"
        case show = "showTerm"
        case season = "tvSeasonTerm"
        case rating = "ratingIndex"
        case description = "descriptionTerm"
    }
}

struct Software: MediaType {
    enum Entity: String {
        case software
        case iPadSoftware
        case macSoftware
    }
    
    enum Attribute: String {
        case softwareDeveloper
    }
}

struct EBook: MediaType {
    enum Entity: String {
        case ebook
    }
    
    // FIXME: Speculative
    enum Attribute: String {
        case title = "titleTerm"
        case author = "authorTerm"
        case genre = "genreIndex"
        case rating = "ratingIndex"
    }
}

struct All: MediaType {
    enum Entity: String {
        case movie
        case album
        case artist = "allArtist"
        case podcast
        case musicVideo
        case mix
        case audiobook
        case tvSeason
        case track = "allTrack"
    }
    
    enum Attribute: String {
        case actor = "actorTerm"
        case language = "languageTerm"
        case allArtist = "allArtistTerm"
        case episode = "tvEpisodeTerm"
        case shortFilm = "shortFilmTerm"
        case director = "directorTerm"
        case releaseYear = "releaseYearTerm"
        case title = "titleTerm"
        case featureFilm = "featureFilmTerm"
        case ratingIndex = "ratingIndex"
        case keywords = "keywordsTerm"
        case description = "descriptionTerm"
        case author = "authorTerm"
        case genre = "genreIndex"
        case mix = "mixTerm"
        case track = "allTrackTerm"
        case artist = "artistTerm"
        case composer = "composerTerm"
        case season = "tvSeasonTerm"
        case producer = "producerTerm"
        case ratingTerm = "ratingTerm"
        case song = "songTerm"
        case movieArtist = "movieArtistTerm"
        case show = "showTerm"
        case movie = "movieTerm"
        case album = "albumTerm"
    }
}

public struct AppleiTunesSearchURLComponents<Media: MediaType> {
    private let scheme = "https"
    private let host = "itunes.apple.com"
    private let path = "/search"
    
    /**
     The URL-encoded text string you want to search for. For example: jack+johnson.
     */
    public var term: String
    
    /**
     The search uses the default store front for the specified country. For example: US. The default is US.
     
     The language, English or Japanese, you want to use when returning search results. Specify the language using the five-letter codename. For example: en_us.The default is en_us (English).
     */
    public var locale: Locale {
        willSet {
            precondition(newValue.regionCode != nil, "locale must have region code")
        }
    }
    
    /**
     The type of results you want returned, relative to the specified media type. For example: movieArtist for a movie media type search. The default is the track entity associated with the specified media type.
     */
    public var entity: Media.Entity?
    
    /**
     The attribute you want to search for in the stores, relative to the specified media type. For example, if you want to search for an artist by name specify entity=allArtist&attribute=allArtistTerm. In this example, if you search for term=maroon, iTunes returns “Maroon 5” in the search results, instead of all artists who have ever recorded a song with the word “maroon” in the title.
     The default is all attributes associated with the specified media type.
     */
    public var attribute: Media.Attribute?
    
    /**
     The name of the Javascript callback function you want to use when returning search results to your website. For example: wsSearchCB.
     */
    public var callback: String?
    
    /**
     The number of search results you want the iTunes Store to return. For example: 25.The default is 50.
     */
    public var limit: Int? {
        willSet {
            precondition((1...200).contains(newValue ?? 50), "limit must be between 1 and 200")
        }
    }
    
    /**
     The search result key version you want to receive back from your search.The default is 2.
     */
    public var version: Version?
    
    public enum Version: Int, Codable {
        case v1 = 1
        case v2 = 2
    }
    
    /**
     A flag indicating whether or not you want to include explicit content in your search results.The default is Yes.
     */
    public var explicit: Bool?
    
    // MARK: -
    
    private func encode<T: RawRepresentable>(_ value: T?) -> String? where T.RawValue == String {
        return value?.rawValue
    }
    
    private func encode<T: RawRepresentable>(_ value: T?) -> String? where T.RawValue == Int {
        return encode(value?.rawValue)
    }
    
    private func encode(_ value: Locale?) -> (country: String, language: String?)? {
        guard let locale = value, let country = locale.regionCode else {
            return nil
        }
        
        if let language = locale.languageCode {
            return (country, "\(language)_\(country)".lowercased())
        } else {
            return (country, nil)
        }
    }
    
    private func encode(_ value: Int?) -> String? {
        if let value = value {
            return "\(value)"
        } else {
            return nil
        }
    }
    
    private func encode(_ value: Bool?) -> String? {
        switch value {
        case true?:
            return "Yes"
        case false?:
            return "No"
        default:
            return nil
        }
    }
    
    // MARK: -
    
    public init(term: String,
         locale: Locale = Locale.current,
         entity: Media.Entity? = nil,
         attribute: Media.Attribute? = nil,
         callback: String? = nil,
         limit: Int? = nil,
         version: Version? = nil,
         explicit: Bool? = nil)
    {
        self.term = term
        self.locale = locale
        self.entity = entity
        self.attribute = attribute
        self.callback = callback
        self.limit = limit
        self.version = version
        self.explicit = explicit
    }
    
    // MARK: -
    
    public var url: URL? {
        return self.components.url
    }
    
    fileprivate var components: URLComponents {
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.host
        components.path = self.path
        components.queryItems = self.queryItems
        
        return components
    }
    
    fileprivate var queryItems: [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        
        let termQueryItem = URLQueryItem(name: "term", value: self.term)
        queryItems.append(termQueryItem)
        
        if case let (country, _)? = encode(self.locale) {
            let queryItem = URLQueryItem(name: "country", value: country)
            queryItems.append(queryItem)
        }
        
        if let entity = encode(self.entity) {
            let queryItem = URLQueryItem(name: "entity", value: entity)
            queryItems.append(queryItem)
        }
        
        if let attribute = encode(self.attribute) {
            let queryItem = URLQueryItem(name: "attribute", value: attribute)
            queryItems.append(queryItem)
        }
        
        if let callback = self.callback {
            let queryItem = URLQueryItem(name: "callback", value: callback)
            queryItems.append(queryItem)
        }
        
        if let limit = encode(self.limit) {
            let queryItem = URLQueryItem(name: "limit", value: limit)
            queryItems.append(queryItem)
        }
        
        if case let (_, language)? = encode(self.locale) {
            let queryItem = URLQueryItem(name: "lang", value: language)
            queryItems.append(queryItem)
        }
        
        if let version = encode(self.version) {
            let queryItem = URLQueryItem(name: "version", value: version)
            queryItems.append(queryItem)
        }
        
        if let explicit = encode(self.explicit) {
            let queryItem = URLQueryItem(name: "explicit", value: explicit)
            queryItems.append(queryItem)
        }
        
        return queryItems
    }
}

// You can also create a lookup request to search for content in the stores based on iTunes IDs, UPCs/ EANs, and All Music Guide (AMG) IDs. ID-based lookups are faster and contain fewer false-positive results.
// TODO
//struct AppleiTunesLookupURLComponents {
//    init(id: Int, entity: MediaType.Entity? = nil, limit: Int? = nil) {
//
//    }
//}

extension AppleiTunesSearchURLComponents.Version: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self.init(rawValue: value)!
    }
}

extension AppleiTunesSearchURLComponents: CustomStringConvertible {
    public var description: String {
        return url?.absoluteString ?? ""
    }
}
