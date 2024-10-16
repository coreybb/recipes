import Foundation

/// Defines the group of endpoints related to recipes.
struct RecipesEndpointGroup: EndpointGroup {
    static let baseURL = URL(string: ConfigurationConstant.apiBaseURL.value)!
}


/// Represents the main endpoint for fetching recipes.
struct RecipesEndpoint: GroupedEndpoint {
    typealias Group = RecipesEndpointGroup
    let path = RecipesEndpointPath.recipes.rawValue
}


/// Represents an endpoint that returns malformed recipe data.
/// This endpoint is intended for testing purposes only.
struct MalformedRecipesEndpoint: GroupedEndpoint {
    typealias Group = RecipesEndpointGroup
    let path = RecipesEndpointPath.malformed.rawValue
}


/// Represents an endpoint that returns an empty recipe dataset.
/// This endpoint is intended for testing purposes only.
struct EmptyDataRecipesEndpoint: GroupedEndpoint {
    typealias Group = RecipesEndpointGroup
    let path = RecipesEndpointPath.empty.rawValue
}


/// Defines the specific paths for different recipe endpoints.
fileprivate enum RecipesEndpointPath: String {
    
    /// Path for fetching valid recipe data
    case recipes = "recipes.json"
    
    /// Path for fetching malformed recipe data (for testing purposes)
    case malformed = "recipes-malformed.json"
    
    /// Path for fetching an empty recipe dataset (for testing purposes)
    case empty = "recipes-empty.json"
}
