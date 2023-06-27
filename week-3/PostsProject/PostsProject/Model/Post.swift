

import Foundation

//struct Post: Codable ,Identifiable{
//
//    let id: Int
//    let userId: ?
//    let title: String
//    let body: String
//}



// MARK: - WelcomeElement
struct Post: Codable, Identifiable {
    let userID, id: Int?
    let title, body: String?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
