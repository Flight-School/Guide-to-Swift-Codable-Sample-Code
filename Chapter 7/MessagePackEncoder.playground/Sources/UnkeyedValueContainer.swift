import Foundation

extension _MessagePackEncoder {
    class UnkeyedContainer {
        struct Index: CodingKey {
            var intValue: Int?
            
            var stringValue: String {
                return "\(self.intValue!)"
            }
            
            init?(intValue: Int) {
                self.intValue = intValue
            }
            
            init?(stringValue: String) {
                return nil
            }
        }
        
        private var storage: [MessagePackEncodingContainer] = []
        
        var count: Int {
            return storage.count
        }
        
        var codingPath: [CodingKey]
        
        var nestedCodingPath: [CodingKey] {
            return self.codingPath + [Index(intValue: self.count)!]
        }
        
        var userInfo: [CodingUserInfoKey: Any]
        
        init(codingPath: [CodingKey], userInfo: [CodingUserInfoKey : Any]) {
            self.codingPath = codingPath
            self.userInfo = userInfo
        }
    }
}

extension _MessagePackEncoder.UnkeyedContainer: UnkeyedEncodingContainer {
    func encodeNil() throws {
        var container = self.nestedSingleValueContainer()
        try container.encodeNil()
    }
    
    func encode<T>(_ value: T) throws where T : Encodable {
        var container = self.nestedSingleValueContainer()
        try container.encode(value)
    }
    
    private func nestedSingleValueContainer() -> SingleValueEncodingContainer {
        return _MessagePackEncoder.SingleValueContainer(codingPath: self.nestedCodingPath, userInfo: self.userInfo)
    }
    
    func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
        let container = _MessagePackEncoder.KeyedContainer<NestedKey>(codingPath: self.nestedCodingPath, userInfo: self.userInfo)
        self.storage.append(container)
        
        return KeyedEncodingContainer(container)
    }
    
    func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        let container = _MessagePackEncoder.UnkeyedContainer(codingPath: self.nestedCodingPath, userInfo: self.userInfo)
        self.storage.append(container)
        
        return container
    }
    
    func superEncoder() -> Encoder {
        fatalError("Unimplemented")
    }
}

extension _MessagePackEncoder.UnkeyedContainer: MessagePackEncodingContainer {
    var data: Data {
        var data = Data()
        
        let length = storage.count
        if let uint16 = UInt16(exactly: length) {
            if uint16 <= 15 {
                data.append(UInt8(0x90 + uint16))
            } else {
                data.append(0xdc)
                data.append(contentsOf: uint16.bytes)
            }
        } else if let uint32 = UInt32(exactly: length) {
            data.append(0xdc)
            data.append(contentsOf: uint32.bytes)
        } else {
            fatalError()
        }
        
        for container in storage {
            data.append(container.data)
        }
        
        return data
    }
}
