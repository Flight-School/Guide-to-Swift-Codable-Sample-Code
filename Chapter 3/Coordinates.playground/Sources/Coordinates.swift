import Foundation

public struct Coordinate: Decodable {
    public var latitude: Double
    public var longitude: Double
    public var elevation: Double?
    
    private enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case elevation
    }
    
    public init(from decoder: Decoder) throws {
        if let container =
            try? decoder.container(keyedBy: CodingKeys.self)
        {
            self.latitude =
                try container.decode(Double.self, forKey: .latitude)
            self.longitude =
                try container.decode(Double.self, forKey: .longitude)
            self.elevation =
                try container.decodeIfPresent(Double.self,
                                              forKey: .elevation)
        } else if var container = try? decoder.unkeyedContainer() {
            self.longitude = try container.decode(Double.self)
            self.latitude = try container.decode(Double.self)
            self.elevation = try container.decodeIfPresent(Double.self)
        } else if let container = try? decoder.singleValueContainer() {
            let string = try container.decode(String.self)
            
            let scanner = Scanner(string: string)
            scanner.charactersToBeSkipped = CharacterSet(charactersIn: "[ ,]")

            var longitude = Double()
            var latitude = Double()
            
            
            guard scanner.scanDouble(&longitude),
                  scanner.scanDouble(&latitude)
                else {
                    throw DecodingError.dataCorruptedError(
                        in: container,
                        debugDescription: "Invalid coordinate string"
                    )
            }
            
            self.latitude = latitude
            self.longitude = longitude
            self.elevation = nil
        } else {
            let context = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Unable to decode Coordinate")
            throw DecodingError.dataCorrupted(context)
        }
    }
}
