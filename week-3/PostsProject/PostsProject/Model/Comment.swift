import Foundation

struct Comment: Codable,Identifiable {
    let postId, id: Int?
    let name, email, body: String?
    
}
