import Foundation


struct RecipesEndpointGroup: EndpointGroup {
    static var baseURL: URL = URL(string: ConfigurationConstant.apiBaseURL.value)!
}

struct RecipesAPI: GroupedEndpoint {
    typealias Group = RecipesEndpointGroup
    let path = RecipesEndpoint.recipes.rawValue
}

struct MalformedRecipesAPI: GroupedEndpoint {
    typealias Group = RecipesEndpointGroup
    let path = RecipesEndpoint.malformed.rawValue
}

struct EmptyDataRecipesAPI: GroupedEndpoint {
    typealias Group = RecipesEndpointGroup
    let path = RecipesEndpoint.empty.rawValue
}


fileprivate enum RecipesEndpoint: String {
    case recipes = "recipes.json"
    case malformed = "recipes-malformed.json"
    case empty = "recipes-empty.json"
}
