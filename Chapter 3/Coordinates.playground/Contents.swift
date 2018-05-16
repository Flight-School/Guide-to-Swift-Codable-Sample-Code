import Foundation

let json = """
{
    "coordinates": [
        {
            "latitude": 37.332,
            "longitude": -122.011
        },
        [-122.011, 37.332],
        "37.332, -122.011"
    ]
}
""".data(using: .utf8)!

let decoder = JSONDecoder()

let coordinates = try! decoder.decode([String: [Coordinate]].self, from: json)["coordinates"]
print(coordinates!)
