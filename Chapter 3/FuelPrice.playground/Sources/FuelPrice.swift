import Foundation

public protocol FuelPrice {
    var type: Fuel { get }
    var pricePerLiter: Decimal { get }
    var currency: String { get }
}

extension FuelPrice {
    public var description: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyISOCode
        formatter.currencyCode = self.currency

        return "\(type.rawValue): \(formatter.string(from: self.pricePerLiter as NSNumber)!)"
    }
}
