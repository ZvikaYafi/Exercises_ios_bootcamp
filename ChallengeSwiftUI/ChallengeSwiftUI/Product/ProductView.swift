import SwiftUI

struct ProductView: View{
    
    @Binding var category: String
    
    @StateObject var productsVM = ProductViewModel()
    
    var body: some View {
        
        
        Text(category)
            .font(.custom("Pacifico-Regular", size: 30))
            .fontWeight(.bold)
            .padding(.vertical, 20)
        
        let products = productsVM.products
        // List of products
        List(products) { product in
            CustomProductView(product: product)
        } .onAppear {
            Task {
                do {
                    await productsVM.getProductsFromServices(category: category)
                }
            }
        }
        
    }
       
}
