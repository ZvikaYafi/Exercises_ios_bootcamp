
import Foundation

struct Post: Codable, Identifiable {
    let userId, id: Int?
    let title, body: String?
}
