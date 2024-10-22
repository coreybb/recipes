protocol RecipeRepository {
    
    func fetchRecipes() async throws -> [Recipe]
}


extension RecipeRepository where Self: NetworkServicing {
    
    func fetchRecipes() async throws -> [Recipe] {
        let endpoint = EmptyDataRecipesEndpoint()
        let response: RecipesResponse = try await networkingService.request(endpoint)
        print(response.recipes)
        return response.recipes
    }
}
