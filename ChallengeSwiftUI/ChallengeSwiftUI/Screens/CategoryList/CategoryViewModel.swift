

import Foundation

class CategoryViewModel: ObservableObject {
    
    @Published var categories : [String]?
    
    
    func getProductsFromServices() async {
        do {
            let fetchedCategory = try await CategoryApi.shared.getAllCategpry()
            DispatchQueue.main.async {
                self.categories = fetchedCategory
            }
        } catch {
            // Handle error
        }
    }


    func getDefaultArrayLength() -> Int {
        let defaultArray = UserDefaults.standard.array(forKey: "FavoriteProducts") as? [Int] ?? []
        return defaultArray.count
    }
    
    
}
