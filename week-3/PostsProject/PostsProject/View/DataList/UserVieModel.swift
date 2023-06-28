import Foundation


class UserViewModel: ObservableObject {
    // Define a class named `UserViewModel` that conforms to `ObservableObject`
    
    @Published var user: User?
    
    // Define a method named `getUser` that takes a `userId` parameter of type `Int`
    func getUser(userId: Int) {
        
        // Call the `fetchUser` method from the `UserApi` shared instance with the `userId` parameter
        UserApi.shared.fetchUser(userId: userId) { result in
            
            switch result {
                
                // If the API call is successful, extract the `user` object from the result
            case .success(let user):
                
                DispatchQueue.main.async {
                    self.user = user
                }
                // If the API call fails, extract the `error` object from the result and print it
            case .failure(let error):
                
                print(error)
            }
        }
    }
}
