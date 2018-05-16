import Foundation

public struct Pixel {
    public var red: UInt8
    public var green: UInt8
    public var blue: UInt8

    public init(red: UInt8, green: UInt8, blue: UInt8) {
        self.red = red
        self.green = green
        self.blue = blue
    }
}

extension Pixel: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch encoder.userInfo[.colorEncodingStrategy]
            as? ColorEncodingStrategy
        {
        case let .hexadecimal(hash)?:
            try container.encode(
                (hash ? "#" : "") +
                    String(format: "%02X%02X%02X", red, green, blue)
            )
        default:
            try container.encode(
                String(format: "rgb(%d, %d, %d)", red, green, blue)
            )
        }
    }
}
