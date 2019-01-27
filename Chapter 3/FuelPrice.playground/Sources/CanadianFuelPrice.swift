import Foundation

public struct CanadianFuelPrice: Decodable {
    public let type: Fuel
    
    /// CAD / liter
    public let price: Decimal
}

extension CanadianFuelPrice: FuelPrice {
    public var pricePerLiter: Decimal {
        return self.price
    }

    public var currency: String {
        return "CAD"
    }
}

extension CanadianFuelPrice: CustomStringConvertible {}
