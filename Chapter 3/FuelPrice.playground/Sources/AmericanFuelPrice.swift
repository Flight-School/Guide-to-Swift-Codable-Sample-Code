import Foundation

public struct AmericanFuelPrice: Decodable {
    public let fuel: Fuel
    
    /// USD / gallon
    public let price: Decimal
}

extension AmericanFuelPrice: FuelPrice {
    public var type: Fuel {
        return self.fuel
    }

    public var pricePerLiter: Decimal {
        return self.price /
                3.78541
    }

    public var currency: String {
        return "USD"
    }
}

extension AmericanFuelPrice: CustomStringConvertible {}
