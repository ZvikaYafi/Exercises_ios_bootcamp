import Foundation


class FavoriteApi {
    static let shared = FavoriteApi()
    
    var token = UserDefaults.standard.object(forKey: "AuthToken") as? String

    func getProductsFavorite() async throws -> [Product] {
        guard let url = URL(string: "https://balink.onlink.dev/products/ids") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        guard let token = token else {
            throw URLError(.userAuthenticationRequired)
        }
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let products = ["products": UserDefaults.standard.array(forKey: "FavoriteProducts") as? [Int] ?? []]
        
        do {
            request.httpBody = try JSONEncoder().encode(products)
        } catch {
            throw error
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let res = response as? HTTPURLResponse, res.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            return try parseJSON(productsData: data)
        } catch {
            throw error
        }
    }
    
    func parseJSON(productsData: Data) throws -> [Product] {
        return try JSONDecoder().decode([Product].self, from: productsData)
    }
}
