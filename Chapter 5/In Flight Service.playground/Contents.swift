import UIKit
import PlaygroundSupport
import XCPlayground

guard let url = Bundle.main.url(forResource: "Inventory", withExtension: ".plist") else {
    fatalError("Inventory.plist missing from main bundle")
}

let inventory: [Item]
do {
    let data = try Data(contentsOf: url)
    
    let decoder = PropertyListDecoder()
    let plist = try decoder.decode([String: [Item]].self, from: data)
    inventory = plist["items"]!
} catch {
    fatalError("Cannot load inventory \(error)")
}


var orders: [Order]
let decoder = PropertyListDecoder()
if let data = UserDefaults.standard.value(forKey: "orders") as? Data,
    let savedOrders = try? decoder.decode([Order].self, from: data) {
    orders = savedOrders
} else {
    orders = []
}


let viewController = OrderSelectionViewController()
let navigationController = UINavigationController(rootViewController: viewController)

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = navigationController
