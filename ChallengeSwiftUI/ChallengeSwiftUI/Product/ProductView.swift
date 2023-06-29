import SwiftUI

struct ProductView: View {
    
    @Binding var category: String
    @ObservedObject var productsVM : ProductViewModel
    
    var body: some View {
        let products = productsVM.getProductByCategory(category: category)
        
        List(products) { product in
            HStack(spacing: 16) {
                if let firstImageURLString = product.images.first,
                   let firstImageURL = URL(string: firstImageURLString) {
                    AsyncImage(url: firstImageURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 120)
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(product.title)
                        .font(.headline)
                        .foregroundColor(.blue)
                    
                    Text(product.description)
                        .font(.subheadline)
                    
                    Text("Price: $\(product.price)")
                        .font(.subheadline)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
        }
        .padding()
    }
}


struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(category: .constant("Your Category"),productsVM: ProductViewModel())
    }
}
