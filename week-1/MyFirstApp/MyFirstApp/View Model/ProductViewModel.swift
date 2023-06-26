
import Foundation
import UIKit

class ProductViewModel {
    
    var products : [Product] = []
    var categories : [String] = []
    
    func getProductsFromServices () async throws {
        
        try await products = ProductApi.shared.getAllProducts()
        categories = getAllCategoryTypes()
    }
}

extension ProductViewModel {
    
    func countRow() -> Int {
        return categories.count
    }
    
    func getText(index: Int) -> String {
        return categories[index]
    }
    
    func getAllCategoryTypes() -> [String] {
        var allCategory: [String] = []
        
        for product in products {
            if !allCategory.contains(product.category) {
                allCategory.append(product.category)
            }
        }
        return allCategory
    }
    
    
}
