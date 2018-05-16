import UIKit
import CoreData
import CoreImage
import PlaygroundSupport

let context = mainContext()

try! Passenger.insertSampleRecords(into: context)

let scanner = LuggageTagScanner()

let tagsAtDeparture = [#imageLiteral(resourceName: "tag.png")]

// Departure
do {
    for image in tagsAtDeparture {
        try scanner.scan(image: image, at: .origin, in: context)
    }
    
    try context.save()
} catch {
    fatalError("\(error)")
}

DispatchQueue.main.asyncAfter(deadline: .now() + 100.0) {
    do {
        for image in tagsAtDeparture {
            try scanner.scan(image: image, at: .destination, in: context)
        }
        
        try context.save()
    } catch {
        fatalError("\(error)")
    }
}

let viewController = ViewController()
let navigationController = UINavigationController(rootViewController: viewController)
PlaygroundPage.current.liveView = navigationController
