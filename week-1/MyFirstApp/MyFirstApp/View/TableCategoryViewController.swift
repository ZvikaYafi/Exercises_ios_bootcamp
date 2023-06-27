import UIKit

class TableCategoryViewController: UIViewController {
    
    var userName: String = ""
    
    
    @IBOutlet weak var categoryTable: UITableView!
    
    var productViewModel = ProductViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Welcome \(userName)"
        
        categoryTable.delegate = self
        categoryTable.dataSource = self
        
        Task {
            try await productViewModel.getProductsFromServices()
            categoryTable.reloadData()
        }
    }
}

extension TableCategoryViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productViewModel.getCountOfCategories()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "category", for: indexPath)
        cell.textLabel?.text = productViewModel.getCategoryText(index: indexPath.row)
        return cell
        
    }
}







