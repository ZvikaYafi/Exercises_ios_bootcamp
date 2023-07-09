
import Foundation

class SearchViewModel: ObservableObject {
    
    @Published var products : [Product] = []
    
    
    func getProductsFromServices() async {
        do {
            let fetchedCategory = try await AllProductApi.shared.getProducts()
            DispatchQueue.main.async {
                self.products = fetchedCategory
            }
        } catch {
            // Handle error
        }
    }
}
