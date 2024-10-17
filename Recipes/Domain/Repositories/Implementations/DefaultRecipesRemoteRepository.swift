final actor DefaultRecipesRemoteRepository: RecipeRepository, NetworkServicing {
    let networkingService: NetworkingService
    
    init(networkingService: NetworkingService) {
        self.networkingService = networkingService
    }
}
