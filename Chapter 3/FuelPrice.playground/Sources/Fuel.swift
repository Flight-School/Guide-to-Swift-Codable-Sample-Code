public enum Fuel: String, Decodable {
    case jetA = "Jet A"
    case jetB = "Jet B"
    case oneHundredLowLead = "100LL"
}

extension Fuel: CustomStringConvertible {
    public var description: String {
        return self.rawValue
    }
}
