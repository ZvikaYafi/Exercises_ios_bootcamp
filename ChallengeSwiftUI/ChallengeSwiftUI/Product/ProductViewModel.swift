
import Foundation

class ProductViewModel: ObservableObject {
    
    
    @Published var products : [Product]?
    @Published var categories : [String]?
    
    func getProductsFromServices() async {
            do {
                let fetchedProducts = try await ProductApi.shared.getAllProducts()
                DispatchQueue.main.async {
                    self.products = fetchedProducts
                    self.categories = self.getUniqueCategories()
                }
            } catch {
                // Handle error
            }
    }
    
    func getProductByCategory(category: String) -> [Product] {
        guard let products = products else {return []}
        return products.filter { $0.category == category }
    }

    
    func getUniqueCategories() -> [String] {
        guard let products = products else { return [] }
        
        var uniqueCategories: [String] = []
        for product in products {
            if !uniqueCategories.contains(product.category) {
                uniqueCategories.append(product.category)
            }
        }
        return uniqueCategories
    }

}

