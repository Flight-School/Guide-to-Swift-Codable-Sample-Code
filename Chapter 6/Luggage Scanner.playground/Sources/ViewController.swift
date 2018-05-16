import UIKit
import CoreData

public class ViewController : UITableViewController {
    lazy var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Passenger")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "familyName", ascending: true), NSSortDescriptor(key: "givenName", ascending: true)]
        fetchRequest.relationshipKeyPathsForPrefetching = ["Luggage"]
        
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: mainContext(), sectionNameKeyPath: nil, cacheName: nil)
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Passengers"
        
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
        
        self.tableView.reloadData()
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections!.count
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let passenger = self.fetchedResultsController.object(at: indexPath) as! Passenger
        
        cell.textLabel?.text = "\(passenger.givenName)/\(passenger.familyName)"
        cell.detailTextLabel?.text = "Bags: \(passenger.luggage?.count ?? 0)"
        
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.fetchedResultsController.sections![section].name
    }
    
    public override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.fetchedResultsController.sectionIndexTitles
    }
    
    public override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return self.fetchedResultsController.section(forSectionIndexTitle: title, at: index)
    }
}
