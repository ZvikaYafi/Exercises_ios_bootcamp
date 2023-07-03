//
//  ProductView.swift
//  ChallengeSwiftUI
//
//  Created by Zvika-Yafi on 03/07/2023.
//

import SwiftUI

struct CustomProductView: View {
    var product: Product
    
    @StateObject private var favoriteVM = FavoritesViewModel()
    
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
                    favoriteVM.toggleFavorite(productID: product.id)
                    favoriteVM.refreshProducts()
                }) {
                    Image(systemName: favoriteVM.isFavorite(productID: product.id) ? "star.fill" : "star")
                        .font(.system(size: 24))
                        .foregroundColor(favoriteVM.isFavorite(productID: product.id) ? .yellow : .primary)
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
 

