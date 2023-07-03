//
//  ProductView.swift
//  ChallengeSwiftUI
//
//  Created by Zvika-Yafi on 03/07/2023.
//

import SwiftUI

struct CustomProductView: View {
    var product: Product
    
    @StateObject private var productsVM = ProductViewModel()
    
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
                Button(action: {
                    productsVM.toggleFavorite(productID: product.id)
                    productsVM.refreshProducts(category: product.category)
                }) {
                    Image(systemName: productsVM.isFavorite(productID: product.id) ? "star.fill" : "star")
                        .font(.system(size: 24))
                        .foregroundColor(productsVM.isFavorite(productID: product.id) ? .yellow : .primary)
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
}
