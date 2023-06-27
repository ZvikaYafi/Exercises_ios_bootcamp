
import Foundation
import UIKit

class ProductViewModel {
    
    var products : [Product] = []
    var categories : [String] = []
    
    func getProductsFromServices () async throws {
        try await products = ProductApi.shared.getAllProducts()
        categories = getAllCategoryTypes()
    }
    
    func getCountOfCategories() -> Int {
        return categories.count
    }
    
    func getCategoryText(index: Int) -> String {
        return categories[index]
    }
    
    func getAllCategoryTypes() -> [String] {
        let uniqueCategories = Set(products.map { $0.category })
        return Array(uniqueCategories)
    }
}

