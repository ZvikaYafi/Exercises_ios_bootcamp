//
//  ProductsViewController.swift
//  MyFirstApp
//
//  Created by Zvika-Yafi on 22/06/2023.
//

import UIKit

class ProductsViewController: UIViewController {
    
    @IBOutlet weak var ProductViewCollection: UICollectionView!
    
    var ProductsArrey :[Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProductsArrey = ProductsModel.shared.getProductsByCategory()
        ProductViewCollection.reloadData()
        
        ProductViewCollection.dataSource = self
        ProductViewCollection.delegate = self
        
    }
    

 

}
extension ProductsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProductsArrey.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "product", for: indexPath) as! ProductCollectionViewCell

        // Configure the cell with the corresponding todo
        cell.setup(product: ProductsArrey[indexPath.item])
        return cell
    }

    // Setting the appropriate height and width for each cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let collectionViewWidth = collectionView.bounds.width
//
//        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
//            return CGSize(width: 0, height: 0)
//        }
//
//        let spaceBetweenCells = flowLayout.minimumInteritemSpacing
//        let adjustedWidth = collectionViewWidth - spaceBetweenCells
//
//        let width: CGFloat = adjustedWidth / 2
//        let height: CGFloat = 150
        
        return CGSize(width: 350, height: 200)
    }
}
