import Foundation

public class MessagePackEncoder {
    public init() {
        
    }
    
    public func encode(_ value: Encodable) throws -> Data {
        let encoder = _MessagePackEncoder()
        try value.encode(to: encoder)
        return encoder.data
    }
}
