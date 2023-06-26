import UIKit

class HomeScreenViewController: UIViewController {
    
    var userName: String = ""
    var productsArray : [Product] = []
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
        
        do {
            productsArray = try await ProductsModel.shared.getAllProducts()
        } catch {
            handleError(error)
        }
    }
    
    func handleError(_ error: Error) {
        if let urlError = error as? URLError {
            switch urlError.code {
            case .userAuthenticationRequired:
                print("User authentication is required")
            case .badServerResponse:
                print("Bad server response")
            case .badURL:
                print("Bad URL")
            default:
                print("An error occurred: \(urlError.localizedDescription)")
            }
        } else {
            print("An error occurred: \(error.localizedDescription)")
        }
    }
}

extension HomeScreenViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getAllCategoryTypes(products: productsArray).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "category", for: indexPath)
        cell.textLabel?.text = getAllCategoryTypes(products: productsArray)[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCategory = getAllCategoryTypes(products: productsArray)[indexPath.row]
        
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





