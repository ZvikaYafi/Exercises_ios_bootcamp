import Foundation

struct Product: Codable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String
    let category: String
    let thumbnail: String
    let images: [String]
}

class ProductsModel {
    
    static let shared = ProductsModel()
    
    var allProducts : [Product] = []
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
                self.allProducts = parsedProducts
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
    
    
    func getProductsByCategory() -> [Product] {
        let filteredProducts = self.allProducts.filter { $0.category == category }
        return filteredProducts
    }
    
}
