protocol RecipesRepository {
    
    func fetchRecipes() async throws -> [Recipe]
}


final actor RecipesRemoteRepository: RecipesRepository {
    
    
    //  MARK: - Private Properties
    private let networkingService: NetworkingService
    
    
    //  MARK: - Initialization
    
    init(networkingService: NetworkingService) {
        self.networkingService = networkingService
    }
    
    
    
    //  MARK: - Internal API
    func fetchRecipes() async throws -> [Recipe] {
        let response: RecipesResponse = try await networkingService.request(RecipesEndpoint())
        return response.recipes
    }
}
