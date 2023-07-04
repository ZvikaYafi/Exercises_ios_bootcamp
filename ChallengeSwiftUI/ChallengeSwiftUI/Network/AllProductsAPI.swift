
import Foundation

class AllProductApi {
    
    static var shared = AllProductApi()

    
    var token = UserDefaults.standard.object(forKey: "AuthToken") as? String

    func getProducts() async throws -> [Product] {
        if let url = URL(string: "https://balink.onlink.dev/products" ) {
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            if let token = token {
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            } else {
                throw URLError(.userAuthenticationRequired)
            }
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let res = response as? HTTPURLResponse ,
               res.statusCode == 200 {
                
                let parsedProducts = try self.parseJSON(productsData: data)
                
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
