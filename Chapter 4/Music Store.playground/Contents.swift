import Foundation
import UIKit
import PlaygroundSupport

let viewController = MasterViewController()
let navigationController = UINavigationController(rootViewController: viewController)

viewController.search(for: Music.self, with: <#artist#>)

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = navigationController
