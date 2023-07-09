import SwiftUI

struct ProductView: View{
    
    @Binding var category: String
    
    @StateObject var productsVM = ProductViewModel()
    @StateObject private var favoritesVM = FavoritesViewModel()

    
    var body: some View {
        
        let products = productsVM.products
        // List of products
        List(products) { product in
            CustomProductView(product: product,
                              isFav: favoritesVM.isFavorite(productID: product.id),
                              action: {
                favoritesVM.toggleFavorite(productID: product.id)
                favoritesVM.refreshProducts()
            })
        }
        .toolbar {
            ToolbarItemGroup(placement: .principal) {
                Text(category.capitalized)
                    .bold()
            }
        }
        .onAppear {
            Task {
                do {
                    await productsVM.getProductsFromServices(category: category)
                }
            }
        }
        
    }
    
}
