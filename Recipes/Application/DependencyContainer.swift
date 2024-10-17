import Foundation

final class DependencyContainer {
    let networkingService: NetworkingService
    let fetchImageUseCase: FetchImageUseCase
    let recipesRepository: RecipeRepository
    
    init() {
        let noCacheConfig = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: noCacheConfig)
        self.networkingService = NetworkingService(networkClient: session)
        
        let imageRemoteRepository = DefaultImageRemoteRepository(networkingService: networkingService)
        let imageLocalRepository = DefaultImageLocalRepository()
        self.fetchImageUseCase = DefaultFetchImageUseCase(
            remoteRepository: imageRemoteRepository,
            localRepository: imageLocalRepository
        )
        
        self.recipesRepository = DefaultRecipesRemoteRepository(networkingService: networkingService)
    }
}
