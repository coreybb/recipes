protocol RecipesRepository {
    
    func fetchRecipes() async throws -> [Recipe]
}


extension RecipesRepository where Self: NetworkServicing {
    
    func fetchRecipes() async throws -> [Recipe] {
        let response: RecipesResponse = try await networkingService.request(RecipesEndpoint())
        return response.recipes
    }
}
