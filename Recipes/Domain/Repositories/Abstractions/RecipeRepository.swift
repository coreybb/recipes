protocol RecipeRepository {
    
    func fetchRecipes() async throws -> [Recipe]
}


extension RecipeRepository where Self: NetworkServicing {
    
    func fetchRecipes() async throws -> [Recipe] {
        let endpoint = RecipesEndpoint()
        let response: RecipesResponse = try await networkingService.request(endpoint)
        return response.recipes
    }
}
