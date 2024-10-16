final actor DefaultRecipesRemoteRepository: RecipesRepository, NetworkServicing {
    let networkingService: NetworkingService
    
    init(networkingService: NetworkingService) {
        self.networkingService = networkingService
    }
}
