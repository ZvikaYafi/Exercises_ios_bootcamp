import Foundation

class CategoryViewModel: ObservableObject {
    
    @Published var categories: [String]?
    
    func getCategoryFromServices() async throws {
        
        do {
            let fetchedCategory = try await CategoryApi.shared.getAllCategpry()
            DispatchQueue.main.async {
                self.categories = fetchedCategory
            }
        } catch {
          throw error
        }
    }

    func getDefaultArrayLength() -> Int {
        let defaultArray = UserDefaults.standard.array(forKey: "FavoriteProducts") as? [Int] ?? []
        return defaultArray.count
    }
    
 
}
