import Foundation

class FavoritesViewModel: ObservableObject {
    
    @Published var favoriteProducts: [Product] = []
    
    
    func getProductsFromServices() async {
        
        do {
            let fetchedProducts = try await FavoriteApi.shared.getProductsFavorite()
            DispatchQueue.main.async {
                self.favoriteProducts = fetchedProducts
            }
        } catch {
            // Handle error
        }
    }
    
    
}
