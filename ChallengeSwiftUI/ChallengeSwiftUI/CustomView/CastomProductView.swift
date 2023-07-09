
import SwiftUI

struct CustomProductView: View {
    
    var product: Product
    var isFav: Bool
    var action: () -> Void
    
    
    var body: some View {
        HStack(spacing: 16) {
            VStack {
                if let firstImageURLString = product.images.first,
                   let firstImageURL = URL(string: firstImageURLString) {
                    AsyncImage(url: firstImageURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120, height: 120)
                    } placeholder: {
                        ProgressView()
                    }
                    .padding(.bottom, 10)
                }
                Button(action: action) {
                    Image(systemName: isFav ? "star.fill" : "star")
                        .font(.system(size: 24))
                        .foregroundColor(isFav ? .yellow : .primary)
                }
                .buttonStyle(PlainButtonStyle()) // only click on button
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(product.title.capitalized)
                    .font(.headline)
                    .foregroundColor(.blue)
                
                Text(product.description.capitalized)
                    .font(.subheadline)
                
                Text("Price: $\(product.price)")
                    .font(.subheadline)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}
 

