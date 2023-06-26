import UIKit

class HomeScreenViewController: UIViewController {
    
    var userName: String = ""
    var productsArrey : [Product] = []
    @IBOutlet weak var categoryTable: UITableView!
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        self.title = "Welcome \(userName)"
        Task {
            
            await setupUI()
            
        }
        
    }
    
    
    func setupUI() async {
        
        categoryTable.delegate = self
        categoryTable.dataSource = self
        
        await ProductsModel.shared.getAllProducts() { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let Producst) :
                    self.productsArrey = Producst
                    
                case .failure(let error):
                    print(error)
                }
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





