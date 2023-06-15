import UIKit


class HomeScreenViewController: UIViewController, UITableViewDataSource {
    let products = [
        "iPhone 13"
        ,"MacBook Pro",
        "Apple Watch Series 7",
        "AirPods Pro",
        "iPhone 13"
        ,"MacBook Pro",
        "Apple Watch Series 7",
        "AirPods Pro",  "iPhone 13"
        ,"MacBook Pro",
        "Apple Watch Series 7",
        "AirPods Pro",
        "iPhone 13",
        "MacBook Pro",
        "Apple Watch Series 7",
        "AirPods Pro",
        "iPhone 13"
        ,"MacBook Pro",
        "Apple Watch Series 7",
        "AirPods Pro",
        "iPhone 13"
        ,"MacBook Pro",
        "Apple Watch Series 7",
        "AirPods Pro",  "iPhone 13"
        ,"MacBook Pro",
        "Apple Watch Series 7",
        "AirPods Pro",
        "iPhone 13",
        "MacBook Pro",
        "Apple Watch Series 7",
        "AirPods Pro"
    ]
        
    var userName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Welcome \(userName)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = products[indexPath.row]
        return cell
    }
    
}
