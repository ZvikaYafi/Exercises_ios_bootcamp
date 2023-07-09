import SwiftUI

struct FavoriteView: View {
    
    @StateObject private var favoritesVM = FavoritesViewModel()
    
    var body: some View {
        VStack {
            title("Favorite Products")
            VStack {
                if favoritesVM.favoriteProducts.isEmpty {
                    EmptyFavoritesView()
                } else {
                    getFavoriteListView(for: favoritesVM.favoriteProducts)
                }
            }
        }
        .onAppear {
            Task {
                await favoritesVM.getProductsFromServices()
            }
        }
    }
    
    @ViewBuilder
    private func getFavoriteListView(for favoriteProducts: [Product]) -> some View {
        
        List(favoriteProducts, id: \.id) { product in
            CustomProductView(product: product,
                              isFav: favoritesVM.isFavorite(productID: product.id),
                              action: {
                favoritesVM.toggleFavorite(productID: product.id)
                favoritesVM.refreshProducts()
            })
        }
    }
    
    @ViewBuilder
    private func title(_ title: String) -> some View {
        Text(title)
            .font(.custom("Pacifico-Regular", size: 30))
            .fontWeight(.bold)
            .padding(.vertical, 5)
    }
}


struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}

struct EmptyFavoritesView: View {
    var body: some View {
        Text("No favorite products")
            .font(.headline)
            .foregroundColor(.gray)
    }
}
