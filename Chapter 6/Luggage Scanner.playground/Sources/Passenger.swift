
import Foundation
import CoreData

@objc(Passenger)
public final class Passenger: NSManagedObject {
    @NSManaged public var givenName: String
    @NSManaged public var familyName: String
    
    @NSManaged public var luggage: NSSet?
}

extension Passenger: Decodable {
    public convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else {
            fatalError("Missing context or invalid context")
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Passenger", in: context) else {
            fatalError("Unknown entity Passenger in context")
        }
        
        self.init(entity: entity, insertInto: context)
        
        var container = try decoder.unkeyedContainer()
        self.givenName = try container.decode(String.self)
        self.familyName = try container.decode(String.self)
    }
}

extension Passenger {
    public static func insertSampleRecords(into context: NSManagedObjectContext) throws {
        let fetchRequest = NSFetchRequest<Passenger>(entityName: "Passenger")
        guard try context.count(for: fetchRequest) == 0 else {
            return
        }
        
        let names: [[String]] = [
            ["J", "LEE"],
            ["D", "MEN"],
            ["L", "MEN"],
            ["A", "THO"],
            ["A", "ZMU"],
            ["D", "ZMU"]
        ]
        
        for name in names {
            guard let givenName = name.first, let familyName = name.last else {
                continue
            }
            
            let passenger = Passenger(entity: Passenger.entity(), insertInto: context)
            passenger.givenName = givenName
            passenger.familyName = familyName
        }
        
        try context.save()
    }
}
