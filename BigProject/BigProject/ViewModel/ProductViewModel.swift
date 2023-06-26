import Foundation

class ProductsViewModel {
    
    static let shared = ProductsViewModel()
    
    var products : [Product] = []
    var istoken: String?
    var category: String?
    var productsURL = "https://balink.onlink.dev/products"
    
    
    
    func getAllProducts() async throws {
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

extension ProductsViewModel {
    
    func getCountproducts () -> Int {
        return products.count
    }

    func getProductsByCategory(index : Int) -> String {
        let category = self.products[index].category
        return category
    }
    
    
}
