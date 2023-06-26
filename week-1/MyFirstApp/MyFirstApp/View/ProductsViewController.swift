//
//
//import UIKit
//
//class ProductsViewController: UIViewController {
//
//    @IBOutlet weak var ProductViewCollection: UICollectionView!
//
//    var ProductsArrey :[Product] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        ProductsArrey = ProductsModel.shared.getProductsByCategory()
//        ProductViewCollection.reloadData()
//
//        ProductViewCollection.dataSource = self
//        ProductViewCollection.delegate = self
//
//    }
//}
//
//extension ProductsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return ProductsArrey.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "product", for: indexPath) as! ProductCollectionViewCell
//
//        // Configure the cell with the corresponding todo
//        cell.setup(product: ProductsArrey[indexPath.item])
//        return cell
//    }
//}
