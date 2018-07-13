import Foundation

public struct Order: Codable {
    private(set) var seat: String
    
    public struct LineItem: Codable {
        var item: Item
        var count: Int
        
        var price: Int {
            return item.unitPrice * count
        }
    }
    private(set) var lineItems: [LineItem]
    
    public let creationDate: Date = Date()
    
    public var totalPrice: Int {
        return lineItems.map{ $0.price }.reduce(0, +)
        
        // long-form
        // var totalPrice = 0
        // for lineItem in lineItems {
        //     totalPrice += lineItem.price
        // }
        // return totalPrice
    }
    
    public init(seat: String, itemCounts: [Item: Int]) {
        self.seat = seat
        self.lineItems = itemCounts.compactMap{ $1 > 0 ? LineItem(item: $0, count: $1) : nil }
        
        // long-form
        // var lineItems: [LineItem] = []
        // for (item, count) in itemCounts {
        //    let lineItem = LineItem(item: item, count: count)
        //    lineItems.append(lineItem)
        // }
    }
}
