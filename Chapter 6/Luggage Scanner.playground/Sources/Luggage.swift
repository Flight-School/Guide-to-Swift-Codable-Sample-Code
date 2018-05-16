
import Foundation
import CoreData

@objc(Luggage)
public final class Luggage: NSManagedObject {
    @NSManaged public var identifier: UUID
    @NSManaged public var weight: Float
    
    @NSManaged public var departedAt: NSDate?
    @NSManaged public var arrivedAt: NSDate?
    
    @NSManaged public var owner: Passenger?
}

extension Luggage {
    public static func fetch(with identifier: UUID, from context: NSManagedObjectContext) throws -> Luggage? {
        var luggage: Luggage? = nil
        context.performAndWait {
            let fetchRequest = NSFetchRequest<Luggage>(entityName: "Luggage")
            fetchRequest.predicate = NSPredicate(format: "identifier == %@", identifier as CVarArg)
            fetchRequest.fetchLimit = 1
            if let results = try? context.fetch(fetchRequest) {
                luggage = results.first
            }
        }
        
        return luggage
    }
}

extension Luggage: Decodable {
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case weight
        case owner
    }
    
    public convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else {
            fatalError("Missing context or invalid context")
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Luggage", in: context) else {
            fatalError("Unknown entity Luggage in context")
        }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.identifier = try container.decode(UUID.self, forKey: .identifier)
        self.weight = try container.decode(Float.self, forKey: .weight)
        self.owner = try container.decodeIfPresent(Passenger.self, forKey: .owner)
    }
}
