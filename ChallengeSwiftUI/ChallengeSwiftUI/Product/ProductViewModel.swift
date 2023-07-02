
import Foundation

class ProductViewModel: ObservableObject {
    
    @Published var products : [Product]?
    @Published var categories : [String]?
    
    
    // Checks if the product is in the favorites, if so removes if not adds
    func toggleFavorite(productID: Int) {
        isFavorite(productID: productID) ?
        removeFavoriteProduct(productID: productID) :
        saveFavoriteProduct(productID: productID)
    }
    
    // Refresh products when user adds to favorites
    func refreshProducts(category: String){
        self.products = getProductByCategory(category: category)
    }
    
    
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
    
    // Filter the products by categories
    func getProductByCategory(category: String) -> [Product] {
        guard let products = products else {return []}
        return products.filter { $0.category == category }
    }
    
    
    // Returns a list of categories
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
    
    // Saves a product in favorites
    func saveFavoriteProduct(productID: Int) {
        var selectedProductIDs = UserDefaults.standard.array(forKey: "FavoriteProducts") as? [Int] ?? []
        selectedProductIDs.append(productID)
        UserDefaults.standard.set(selectedProductIDs, forKey: "FavoriteProducts")
    }
    
    // returns up the product is in favorites or not
    func isFavorite(productID: Int) -> Bool {
        let selectedProductIDs = UserDefaults.standard.array(forKey: "FavoriteProducts") as? [Int] ?? []
        if selectedProductIDs.contains(productID){
            return true
        }
        return false
    }
    
    // Removes a product in favorites
     func removeFavoriteProduct(productID: Int) {
        var selectedProductIDs = UserDefaults.standard.array(forKey: "FavoriteProducts") as? [Int] ?? []
        if let index = selectedProductIDs.firstIndex(of: productID) {
            selectedProductIDs.remove(at: index)
            UserDefaults.standard.set(selectedProductIDs, forKey: "FavoriteProducts")
        }
    }
    
}
