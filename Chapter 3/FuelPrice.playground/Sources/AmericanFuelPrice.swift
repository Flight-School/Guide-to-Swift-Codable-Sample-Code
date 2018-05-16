public struct AmericanFuelPrice: Decodable {
    public let fuel: Fuel
    
    /// USD / gallon
    public let price: Double
}

extension AmericanFuelPrice: FuelPrice {
    public var type: Fuel {
        return self.fuel
    }

    public var pricePerLiter: Double {
        return self.price /
                3.78541
    }

    public var currency: String {
        return "USD"
    }
}
