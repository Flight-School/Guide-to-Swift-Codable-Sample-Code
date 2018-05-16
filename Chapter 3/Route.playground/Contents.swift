import Foundation

let json = """
{
    "points": ["KSQL", "KWVI"],
    "KSQL": {
        "code": "KSQL",
        "name": "San Carlos Airport"
    },
    "KWVI": {
        "code": "KWVI",
        "name": "Watsonville Municipal Airport"
    }
}
""".data(using: .utf8)!

let decoder = JSONDecoder()
let route = try decoder.decode(Route.self, from: json)
print(route.points.map{ $0.code })
