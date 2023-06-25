import UIKit

class HomeScreenViewController: UIViewController {
    
    var userName: String = ""
    var productsArrey : [Product] = []
    @IBOutlet weak var categoryTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryTable.delegate = self
        categoryTable.dataSource = self
        
        self.title = "Welcome \(userName)"
        
        ProductsModel.shared.getAllProducts() { products in
            DispatchQueue.main.async {
                self.productsArrey = products
                self.categoryTable.reloadData()
            }
        }
    }
    }  

extension HomeScreenViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getAllCategoryTypes(products: productsArrey).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "category", for: indexPath)
        cell.textLabel?.text = getAllCategoryTypes(products: productsArrey)[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCategory = getAllCategoryTypes(products: productsArrey)[indexPath.row]
        
        ProductsModel.shared.category = selectedCategory
        
        self.performSegue(withIdentifier: "goByCategory", sender: self)
    }
}

func getAllCategoryTypes(products: [Product]) -> [String] {
    var allCategory: [String] = []
    
    for product in products {
        if !allCategory.contains(product.category) {
            allCategory.append(product.category)
        }
    }
    return allCategory
}



