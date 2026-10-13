import Foundation

struct Talk: Codable, Identifiable {
    var id: UUID = UUID()
    
    let title: String
    let author: String
    let calling: String
    let subject: String
    let paragraphs: [[String]]
    
//    // Exclude 'id' from JSON decoding since it's generated locally
    enum CodingKeys: String, CodingKey {
        case title, author, calling, subject, paragraphs
    }
}
