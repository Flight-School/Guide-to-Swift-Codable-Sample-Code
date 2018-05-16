public struct CanadianFuelPrice: Decodable {
    public let type: Fuel
    
    /// CAD / liter
    public let price: Double
}

extension CanadianFuelPrice: FuelPrice {
    public var pricePerLiter: Double {
        return self.price
    }

    public var currency: String {
        return "CAD"
    }
}
