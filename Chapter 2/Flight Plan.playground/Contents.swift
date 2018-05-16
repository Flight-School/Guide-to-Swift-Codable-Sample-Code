import Foundation

let json = """
{
    "aircraft": {
        "identification": "NA12345",
        "color": "Blue/White"
    },
    "route": ["KTTD", "KHIO"],
    "departure_time": {
        "proposed": "2018-04-20T15:07:24-07:00",
        "actual": "2018-04-20T15:07:24-07:00"
    },
    "flight_rules": "IFR",
    "remarks": null
}
""".data(using: .utf8)!

var decoder = JSONDecoder()
decoder.dateDecodingStrategy = .iso8601

let plan = try! decoder.decode(FlightPlan.self, from: json)
print(plan.aircraft.identification)
print(plan.actualDepartureDate!)
