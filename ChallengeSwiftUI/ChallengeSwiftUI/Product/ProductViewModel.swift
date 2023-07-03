
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
    
}
