public struct SearchResponse: Decodable {
    public let results: [SearchResult]
    
    public var nonExplicitResults: [SearchResult] {
        return self.results.filter { (result) in
            result.trackExplicitness != .explicit
        }
    }
}
