
import Foundation

class ProductViewModel: ObservableObject {
    
    @Published var products : [Product] = []
    
    func getProductsFromServices(category: String) async {
          do {
              let fetchedProducts = try await ProductApi.shared.getProductsByCategory(category: category)
              DispatchQueue.main.async {
                  self.products = fetchedProducts
              }
          } catch {
              // Handle error
          }
      }
    
    
    // Checks if the product is in the favorites, if so removes if not adds
    func toggleFavorite(productID: Int) {
        isFavorite(productID: productID) ?
        removeFavoriteProduct(productID: productID) :
        saveFavoriteProduct(productID: productID)
    }
    
    // Refresh products when user adds to favorites
    func refreshProducts(category: String){
        self.products = products
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
