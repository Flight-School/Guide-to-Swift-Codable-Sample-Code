public struct Item: Codable, Hashable, Equatable {
    public var name: String
    public var unitPrice: Int
    
    public static let peanuts = Item(name: "Peanuts", unitPrice: 200)
    public static let crackers = Item(name: "Crackers", unitPrice: 300)
    public static let popcorn = Item(name: "Popcorn", unitPrice: 400)
}
