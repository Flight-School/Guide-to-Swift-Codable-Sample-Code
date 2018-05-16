extension FixedWidthInteger {
    init(bytes: [UInt8]) {
        self = bytes.withUnsafeBufferPointer {
            $0.baseAddress!.withMemoryRebound(to: Self.self, capacity: 1) {
                $0.pointee
            }
        }
    }
    
    var bytes: [UInt8] {
        let capacity = MemoryLayout<Self>.size
        var mutableValue = self.bigEndian
        return withUnsafePointer(to: &mutableValue) {
            return $0.withMemoryRebound(to: UInt8.self, capacity: capacity) {
                return Array(UnsafeBufferPointer(start: $0, count: capacity))
            }
        }
    }
}

extension Float {
    var bytes: [UInt8] {
        return self.bitPattern.bytes
    }
}

extension Double {
    var bytes: [UInt8] {
        return self.bitPattern.bytes
    }
}
