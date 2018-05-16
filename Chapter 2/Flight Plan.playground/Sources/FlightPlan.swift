import Foundation

public struct FlightPlan: Codable {    
    public var aircraft: Aircraft
    
    public var route: [String]
    
    public var flightRules: FlightRules
    
    private var departureDates: [String: Date]
    
    public var proposedDepartureDate: Date? {
        return departureDates["proposed"]
    }
    
    public var actualDepartureDate: Date? {
        return departureDates["actual"]
    }
    
    public var remarks: String?
    
    private enum CodingKeys: String, CodingKey {
        case aircraft
        case flightRules = "flight_rules"
        case route
        case departureDates = "departure_time"
        case remarks
    }
}
