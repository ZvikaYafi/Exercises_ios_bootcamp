//
//  ProductCollectionViewCell.swift
//  MyFirstApp
//
//  Created by Zvika-Yafi on 22/06/2023.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    func setup(product: Product) {
        productTitle.text = product.title
       
    }
}
