protocol RecipeRepository {
    
    func fetchRecipes() async throws -> [Recipe]
}


extension RecipeRepository where Self: NetworkServicing {
    
    func fetchRecipes() async throws -> [Recipe] {
        let response: RecipesResponse = try await networkingService.request(RecipesEndpoint())
        return response.recipes
    }
}
