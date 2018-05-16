import Foundation

extension _MessagePackEncoder {
    class SingleValueContainer: SingleValueEncodingContainer {
        private var storage: Data = Data()
        
        fileprivate var canEncodeNewValue = true
        fileprivate func checkCanEncode(value: Any?) throws {
            guard self.canEncodeNewValue else {
                let context = EncodingError.Context(codingPath: self.codingPath, debugDescription: "Attempt to encode value through single value container when previously value already encoded.")
                throw EncodingError.invalidValue(value as Any, context)
            }
        }
        
        var codingPath: [CodingKey]
        var userInfo: [CodingUserInfoKey: Any]
        
        init(codingPath: [CodingKey], userInfo: [CodingUserInfoKey : Any]) {
            self.codingPath = codingPath
            self.userInfo = userInfo
        }
        
        // MARK -
        
        func encodeNil() throws {
            try checkCanEncode(value: nil)
            defer { self.canEncodeNewValue = false }
            
            self.storage.append(0xc0)
        }
        
        func encode(_ value: Bool) throws {
            try checkCanEncode(value: nil)
            defer { self.canEncodeNewValue = false }
            
            switch value {
            case false:
                self.storage.append(0xc2)
            case true:
                self.storage.append(0xc3)
            }
        }
        
        func encode(_ value: String) throws {
            try checkCanEncode(value: nil)
            defer { self.canEncodeNewValue = false }
            
            guard let data = value.data(using: .utf8) else {
                let context = EncodingError.Context(codingPath: self.codingPath, debugDescription: "Cannot encode string using UTF-8 encoding.")
                throw EncodingError.invalidValue(value, context)
            }
            
            let length = data.count
            if let uint8 = UInt8(exactly: length) {
                if (uint8 <= 31) {
                    self.storage.append(0xa0 + uint8)
                } else {
                    self.storage.append(0xd9)
                    self.storage.append(contentsOf: uint8.bytes)
                }
            } else if let uint16 = UInt16(exactly: length) {
                self.storage.append(0xda)
                self.storage.append(contentsOf: uint16.bytes)
            } else if let uint32 = UInt32(exactly: length) {
                self.storage.append(0xdb)
                self.storage.append(contentsOf: uint32.bytes)
            } else {
                let context = EncodingError.Context(codingPath: self.codingPath, debugDescription: "Cannot encode string with length \(length).")
                throw EncodingError.invalidValue(value, context)
            }
            
            self.storage.append(data)
        }
        
        func encode(_ value: Double) throws {
            try checkCanEncode(value: nil)
            defer { self.canEncodeNewValue = false }
            
            self.storage.append(0xcb)
            self.storage.append(contentsOf: value.bytes)
        }
        
        func encode(_ value: Float) throws {
            try checkCanEncode(value: nil)
            defer { self.canEncodeNewValue = false }
            
            self.storage.append(0xca)
            self.storage.append(contentsOf: value.bytes)
        }
        
        func encode(_ value: Int) throws {
            try checkCanEncode(value: nil)
            defer { self.canEncodeNewValue = false }
            
            if let int8 = Int8(exactly: value) {
                if (int8 >= 0 && int8 <= 127) {
                    self.storage.append(UInt8(int8))
                } else if (int8 < 0 && int8 >= -31) {
                    self.storage.append(0xe0 + (0x1f & UInt8(truncatingIfNeeded: int8)))
                } else {
                    try encode(int8)
                }
            } else if let int16 = Int16(exactly: value) {
                try encode(int16)
            } else if let int32 = Int32(exactly: value) {
                try encode(int32)
            } else if let int64 = Int64(exactly: value) {
                try encode(int64)
            } else {
                let context = EncodingError.Context(codingPath: self.codingPath, debugDescription: "Cannot encode integer \(value).")
                throw EncodingError.invalidValue(value, context)
            }
        }
        
        func encode(_ value: Int8) throws {
            try checkCanEncode(value: nil)
            defer { self.canEncodeNewValue = false }
            
            self.storage.append(0xd0)
            self.storage.append(contentsOf: value.bytes)
        }
        
        func encode(_ value: Int16) throws {
            try checkCanEncode(value: nil)
            defer { self.canEncodeNewValue = false }
            
            self.storage.append(0xd1)
            self.storage.append(contentsOf: value.bytes)
        }
        
        func encode(_ value: Int32) throws {
            try checkCanEncode(value: nil)
            defer { self.canEncodeNewValue = false }
            
            self.storage.append(0xd2)
            self.storage.append(contentsOf: value.bytes)
        }
        
        func encode(_ value: Int64) throws {
            try checkCanEncode(value: nil)
            defer { self.canEncodeNewValue = false }
            
            self.storage.append(0xd3)
            self.storage.append(contentsOf: value.bytes)
        }
        
        func encode(_ value: UInt) throws {
            try checkCanEncode(value: nil)
            defer { self.canEncodeNewValue = false }
            
            if let uint8 = UInt8(exactly: value) {
                if (uint8 <= 127) {
                    self.storage.append(uint8)
                } else {
                    try encode(uint8)
                }
            } else if let uint16 = UInt16(exactly: value) {
                try encode(uint16)
            } else if let uint32 = UInt32(exactly: value) {
                try encode(uint32)
            } else if let uint64 = UInt64(exactly: value) {
                try encode(uint64)
            } else {
                let context = EncodingError.Context(codingPath: self.codingPath, debugDescription: "Cannot encode unsigned integer \(value).")
                throw EncodingError.invalidValue(value, context)
            }
        }
        
        func encode(_ value: UInt8) throws {
            try checkCanEncode(value: nil)
            defer { self.canEncodeNewValue = false }
            
            self.storage.append(0xcc)
            self.storage.append(contentsOf: value.bytes)
        }
        
        func encode(_ value: UInt16) throws {
            try checkCanEncode(value: nil)
            defer { self.canEncodeNewValue = false }
            
            self.storage.append(0xcd)
            self.storage.append(contentsOf: value.bytes)
        }
        
        func encode(_ value: UInt32) throws {
            try checkCanEncode(value: nil)
            defer { self.canEncodeNewValue = false }
            
            self.storage.append(0xce)
            self.storage.append(contentsOf: value.bytes)
        }
        
        func encode(_ value: UInt64) throws {
            try checkCanEncode(value: nil)
            defer { self.canEncodeNewValue = false }
            
            self.storage.append(0xcf)
            self.storage.append(contentsOf: value.bytes)
        }
        
        func encode(_ value: Date) throws {
            try checkCanEncode(value: nil)
            defer { self.canEncodeNewValue = false }
            
            self.storage.append(0xd6)
            try encode(-1 as Int)
            try encode(UInt32(value.timeIntervalSince1970.rounded(.down)))
        }
        
        func encode(_ value: Data) throws {
            let length = value.count
            if let uint8 = UInt8(exactly: length) {
                self.storage.append(0xc4)
                try encode(uint8)
                self.storage.append(value)
            } else if let uint16 = UInt16(exactly: length) {
                self.storage.append(0xc5)
                try encode(uint16)
                self.storage.append(value)
            } else if let uint32 = UInt32(exactly: length) {
                self.storage.append(0xc6)
                try encode(uint32)
                self.storage.append(value)
            } else {
                let context = EncodingError.Context(codingPath: self.codingPath, debugDescription: "Cannot encode data of length \(value.count).")
                throw EncodingError.invalidValue(value, context)
            }
        }
        
        func encode<T>(_ value: T) throws where T : Encodable {
            try checkCanEncode(value: nil)
            defer { self.canEncodeNewValue = false }
            
            let encoder = _MessagePackEncoder()
            try value.encode(to: encoder)
            self.storage.append(encoder.data)
        }
    }
}

extension _MessagePackEncoder.SingleValueContainer: MessagePackEncodingContainer {
    var data: Data {
        return storage
    }
}
