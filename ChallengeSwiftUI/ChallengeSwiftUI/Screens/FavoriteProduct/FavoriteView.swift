import SwiftUI

struct FavoriteView: View {
    
    @StateObject private var favoritesVM = FavoritesViewModel()
    
    var body: some View {
        VStack {
            Text("Favorite Products")
                .font(.custom("Pacifico-Regular", size: 30))
                .fontWeight(.bold)
                .padding(.vertical, 5)
            
            VStack {
                if favoritesVM.favoriteProducts.isEmpty {
                    EmptyFavoritesView()
                } else {
                    FavoriteListView(favoriteProducts: favoritesVM.favoriteProducts)
                }
            }
        }
        
        .onAppear {
            Task {
                await favoritesVM.getProductsFromServices()
            }
        }
    }
}


struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}


struct FavoriteListView: View {
    var favoriteProducts: [Product]
    
    var body: some View {
        List(favoriteProducts, id: \.id) { product in
            CustomProductView(product: product)
            
        }
    }
}

struct EmptyFavoritesView: View {
    var body: some View {
        Text("No favorite products")
            .font(.headline)
            .foregroundColor(.gray)
    }
}
