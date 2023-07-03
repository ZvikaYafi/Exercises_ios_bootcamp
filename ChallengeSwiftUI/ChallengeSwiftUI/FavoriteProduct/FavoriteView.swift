import SwiftUI

struct FavoriteView: View {
    
    @StateObject private var favoritesVM = FavoritesViewModel()
    
    var body: some View {
        VStack {
            Text("favorite products")
                .font(.custom("Pacifico-Regular", size: 30))
                .fontWeight(.bold)
                .padding(.vertical, 5)

            if favoritesVM.favoriteProducts.isEmpty {
                Text("No favorite products")
                    .font(.headline)
                    .foregroundColor(.gray)
            } else {
                List(favoritesVM.favoriteProducts, id: \.id) { product in
                    CustomProductView(product: product)
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
