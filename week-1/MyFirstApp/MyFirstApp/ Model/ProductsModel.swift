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
    
    func getAllProducts(completion: @escaping (Result<[Product], Error>) -> Void) async {
        if let url = URL(string: productsURL) {
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            if let token = istoken {
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            } else {
                completion(.failure("token invalid" as! Error))
            }
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request)  { (data, response, error) in
                
                if let error = error {
                    completion(.failure(error))
                }
                if let safeData = data {
                    let parsedProducts = self.parseJSON(productsData: safeData)
                    self.allProducts = parsedProducts
                    completion(.success(parsedProducts))
                }else {
                    completion(.failure("error json" as! Error))
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(productsData: Data) -> [Product] {
        let decoder = JSONDecoder()
        do {
            let products = try decoder.decode([Product].self, from: productsData)
            return products
        } catch {
            print()
            return []
        }
    }
    
    func getProductsByCategory() -> [Product] {
        let filteredProducts = self.allProducts.filter { $0.category == category }
        return filteredProducts
    }
    
}
