import UIKit

class HomeScreenViewController: UIViewController {
    
    var userName: String = ""
    var productsArray : [Product] = []
    @IBOutlet weak var categoryTable: UITableView!
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        self.title = "Welcome \(userName)"
        
        categoryTable.delegate = self
        categoryTable.dataSource = self
    }

}

extension HomeScreenViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductViewModel.shared.getAllCategoryTypes().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return ProductViewModel.shared.getCell(tableView, didSelectRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCategory =  ProductViewModel.shared.getAllCategoryTypes()[indexPath.row]
        
        ProductViewModel.shared.category = selectedCategory
        
        self.performSegue(withIdentifier: "goByCategory", sender: self)
    }
}







