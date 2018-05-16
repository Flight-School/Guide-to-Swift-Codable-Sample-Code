public protocol FuelPrice {
    var type: Fuel { get }
    var pricePerLiter: Double { get }
    var currency: String { get }
}
