import Foundation
import CoreData

private let container: NSPersistentContainer = {
    guard let url = Bundle.main.url(forResource: "BaggageCheck", withExtension: ".mom") else {
        fatalError("BaggageCheck.mom missing from main bundle")
    }
    
    guard let model = NSManagedObjectModel(contentsOf: url) else {
        fatalError("Invalid managed object model file")
    }
    
    let container = NSPersistentContainer(name: "BaggageCheck", managedObjectModel: model)
    container.loadPersistentStores { (_, error) in
        if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    return container
}()

public func mainContext() -> NSManagedObjectContext {
    let context = container.viewContext
    context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    
    return context
}
