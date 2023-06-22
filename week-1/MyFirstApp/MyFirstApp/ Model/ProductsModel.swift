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
    
    func getAllProducts(completion: @escaping ([Product]) -> Void) {
        guard let url = URL(string: productsURL) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if let token = istoken {
            
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            let session = URLSession(configuration: .default)

        } else {
            print("token invalid")
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error:", error)
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let products = try decoder.decode([Product].self, from: data)
                    self.allProducts = products
                    completion(products)
                } catch {
                    print("Error decoding JSON data:", error)
                }
            } else {
                print("No data received")
            }
        }
        
        task.resume()
    }
    
    func getProductsByCategory() -> [Product] {
        
        let filteredProducts = self.allProducts.filter { $0.category == category }
        return filteredProducts
    }

}
