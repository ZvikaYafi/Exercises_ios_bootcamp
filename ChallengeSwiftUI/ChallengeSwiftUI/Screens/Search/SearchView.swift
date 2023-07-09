import SwiftUI


struct SearchView: View {
    
    @StateObject var searchVM = SearchViewModel()
    @StateObject var favoritesVM = FavoritesViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                
                SearchBarView(searchText: $searchText)
                
                List(searchVM.products.filter { searchText.isEmpty || $0.title.localizedCaseInsensitiveContains(searchText) }, id: \.id) { product in
                    CustomProductView(product: product,
                                      isFav: favoritesVM.isFavorite(productID: product.id),
                                      action: {
                        favoritesVM.toggleFavorite(productID: product.id)
                        favoritesVM.refreshProducts()
                    })
                }
            }
            .onAppear {
                Task {
                    await searchVM.getProductsFromServices()
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

struct SearchBarView: View {
    @Binding var searchText: String
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                
                TextField("Search", text: $searchText)
                    .focused($isTextFieldFocused)
                    .foregroundColor(.primary)
                
                Button(action: {
                    self.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .opacity(searchText.isEmpty ? 0 : 1)
                }
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .foregroundColor(.secondary)
            .background(Color(.tertiarySystemFill))
            .cornerRadius(10.0)
            
            if !searchText.isEmpty {
                Button("Cancel") {
                    self.searchText = ""
                    isTextFieldFocused = false
                    UIApplication.shared.dismissKeyboard() // Dismiss the keyboard
                }
                .foregroundColor(Color(.systemBlue))
            }
        }
        .padding(.horizontal)
    }
}

extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
