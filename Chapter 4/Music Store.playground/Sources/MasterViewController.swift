import UIKit

public class MasterViewController: UITableViewController {
    var results: [SearchResult] = []
    var dataTask: URLSessionDataTask? = nil

    lazy var activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .white)

    public func search<T>(for type: T.Type, with term: String) where T: MediaType {
        let components = AppleiTunesSearchURLComponents<T>(term: term)
        guard let url = components.url else {
            fatalError("Error creating URL")
        }

        self.dataTask?.cancel()
        self.title = term

        self.dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            self.activityIndicatorView.stopAnimating()

            guard let data = data else {
                fatalError()
            }

            let decoder = JSONDecoder()
            let searchResponse = try! decoder.decode(SearchResponse.self, from: data)

            self.results = searchResponse.results

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

        self.activityIndicatorView.startAnimating()
        self.dataTask?.resume()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.activityIndicatorView)
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")

        let result = self.results[indexPath.row]
        cell.textLabel!.text = result.trackName
        cell.detailTextLabel!.text = result.collectionName

        return cell
    }
}
