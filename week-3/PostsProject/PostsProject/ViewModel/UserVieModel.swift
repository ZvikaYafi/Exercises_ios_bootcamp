import Foundation

class UserViewModel: ObservableObject {
    
    @Published var user :User?
    
    func getUser(userId: Int) {
        UserApi.shared.fetchUser(userId: userId){ result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.user = user
                }
                print(user)
            case .failure(let error):
                print(error)
            }
        }
    }
}

