import Foundation

struct Recipe: Hashable {
    let cuisine: Cuisine
    let name: String
    let photoURLLarge: String
    let photoURLSmall: String
    let sourceURL: String?
    let id: String
    let youtubeURL: String?
}


//  MARK: - Custom Deserialization
extension Recipe: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case sourceURL = "source_url"
        case id = "uuid"
        case youtubeURL = "youtube_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // The 'name' field may contain malformed Unicode characters
        // (e.g., "CrÃ¨me BrÃ»lÃ©e" instead of "Crème Brûlée").
        // To fix this, we:
        // 1. Decode the raw string as-is
        // 2. Attempt to re-encode it as ISO-8859-1 (Latin1) and then decode as UTF-8
        let rawName = try container.decode(String.self, forKey: .name)
        name = String(data: rawName.data(using: .isoLatin1) ?? Data(), encoding: .utf8) ?? rawName
        
        // Otherwise decode as normal
        cuisine = try container.decode(Cuisine.self, forKey: .cuisine)
        photoURLLarge = try container.decode(String.self, forKey: .photoURLLarge)
        photoURLSmall = try container.decode(String.self, forKey: .photoURLSmall)
        sourceURL = try container.decodeIfPresent(String.self, forKey: .sourceURL)
        id = try container.decode(String.self, forKey: .id)
        youtubeURL = try container.decodeIfPresent(String.self, forKey: .youtubeURL)
    }
}
