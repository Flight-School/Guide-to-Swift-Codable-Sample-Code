import Foundation

let americanJSON = """
[
    {
        "fuel": "100LL",
        "price": 5.60
    },
    {
        "fuel": "Jet A",
        "price": 4.10
    }
]
""".data(using: .utf8)!

let canadianJSON = """
{
    "fuels": [
        {
            "type": "100LL",
            "price": 2.54
        },
        {
            "type": "Jet A",
            "price": 3.14,
        },
        {
            "type": "Jet B",
            "price": 3.03
        }
    ]
}
""".data(using: .utf8)!

let decoder = JSONDecoder()
let usPrices = try! decoder.decode([AmericanFuelPrice].self, from: americanJSON)
let caPrices = try! decoder.decode([String: [CanadianFuelPrice]].self, from: canadianJSON)

var prices: [FuelPrice] = []
prices.append(contentsOf: usPrices)
prices.append(contentsOf: caPrices["fuels"]! as [FuelPrice])

print(prices)
