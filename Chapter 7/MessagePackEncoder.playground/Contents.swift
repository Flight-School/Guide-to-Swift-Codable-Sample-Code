import Foundation

struct Plane: Codable {
    var manufacturer: String
    var model: String
    var seats: Int
}

let plane = Plane(manufacturer: "Cirrus",
                  model: "SR22",
                  seats: 4)

let encoder = MessagePackEncoder()
let data = try! encoder.encode(plane)

print(data.map { String(format:"%02X", $0) })
