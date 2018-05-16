public struct Plane: Codable {
    public var manufacturer: String
    public var model: String
    public var seats: Int
    
    /* Conformance to Decodable and Encodable is automatically synthesized,
       so this code isn't necessary.
     */
    
    /*
    private enum CodingKeys: String, CodingKey {
        case manufacturer
        case model
        case seats
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.manufacturer = try container.decode(String.self, forKey: .manufacturer)
        self.model = try container.decode(String.self, forKey: .model)
        self.seats = try container.decode(Int.self, forKey: .seats)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.manufacturer, forKey: .manufacturer)
        try container.encode(self.model, forKey: .model)
        try container.encode(self.seats, forKey: .seats)
    }
    */
}
