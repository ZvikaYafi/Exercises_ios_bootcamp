
import Foundation
import UIKit

class ProductViewModel {
    
    static let shared = ProductViewModel()
    
    var products : [Product] = []
    var istoken: String?
    var category: String?
    var productsURL = "https://balink.onlink.dev/products"
    
    
    
    func getAllProducts() async throws -> [Product] {
        if let url = URL(string: productsURL) {
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            if let token = istoken {
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            } else {
                throw URLError(.userAuthenticationRequired)
            }
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let res = response as? HTTPURLResponse ,
               res.statusCode == 200 {
                
                let parsedProducts = try self.parseJSON(productsData: data)
                self.products = parsedProducts
                return parsedProducts
            }
            throw URLError(.badServerResponse)
        }
        throw URLError(.badURL)
    }
    
    func parseJSON(productsData: Data) throws -> [Product] {
        let decoder = JSONDecoder()
        return try decoder.decode([Product].self, from: productsData)
        
    }
    
}

extension ProductViewModel {
    
    func getCountproducts () -> Int {
        return products.count
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
    
    func getCell(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> UITableViewCell {  
        let cell = tableView.dequeueReusableCell(withIdentifier: "category", for: indexPath)
        cell.textLabel?.text = getAllCategoryTypes()[indexPath.row]
        return cell
        
    }
    
}
