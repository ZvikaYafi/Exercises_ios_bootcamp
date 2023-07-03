
import Foundation


class CategoryApi {
    
    
    var token = UserDefaults.standard.object(forKey: "AuthToken") as? String

    static var shared = CategoryApi()


    func getAllCategpry() async throws -> [String] {
        
        if let url = URL(string: "https://balink.onlink.dev/categories") {
            
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
                
                let parsedCategory = try self.parseJSON(categoryData: data)
                                
                return parsedCategory
            }
            throw URLError(.badServerResponse)
        }
        throw URLError(.badURL)
    }
    
    
    func parseJSON(categoryData: Data) throws -> [String] {
        let decoder = JSONDecoder()
        return try decoder.decode([String].self, from: categoryData)
        
    }
}



