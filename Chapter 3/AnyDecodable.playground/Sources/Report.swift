public struct Report: Decodable {
    public var title: String
    public var body: String
    public var metadata: [String: AnyDecodable]
}
