import SwiftUI

struct ProductView: View{
    
    @Binding var category: String
    
    @StateObject var productsVM = ProductViewModel()
    
    var body: some View {
        
        let products = productsVM.products
        // List of products
        List(products) { product in
            CustomProductView(product: product)
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
