struct Recipe: Hashable {
    let cuisine: Cuisine
    let name: String
    let photoURLLarge: String
    let photoURLSmall: String
    let sourceURL: String?
    let id: String
    let youtubeURL: String?
}


//  MARK: - Decodable Conformance
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
}
