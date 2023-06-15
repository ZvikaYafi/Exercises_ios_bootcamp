import UIKit

class HViewController: UIViewController , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text=historyArray[indexPath.row]
        
return cell
    }
    

    @IBOutlet weak var historyTable: UITableView!
    
    var historyArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "History"
        print(historyArray)
        // Use the historyArray as needed, such as populating the table view
        // ...
    }
   

}
