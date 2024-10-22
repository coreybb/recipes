enum SortParameter: Int, CaseIterable {
    case name = 0
    case cuisine = 1
    
    var description: String {
        switch self {
        case .name:
            "Name"
        case .cuisine:
            "Cuisine"
        }
    }
}
