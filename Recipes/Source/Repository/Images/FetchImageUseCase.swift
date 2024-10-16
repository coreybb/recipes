import UIKit.UIImage


protocol FetchImageUseCase {
    func execute(forURL url: URL) async throws -> UIImage
}


final actor DefaultFetchImageUseCase: FetchImageUseCase {
    
    
    //  MARK: - Private Properties
    private let remoteRepository: ImageRemoteRepository
    private let localRepository: ImageLocalRepository
    
    
    
    //  MARK: - Init
    init(
        remoteRepository: ImageRemoteRepository,
        localRepository: ImageLocalRepository
    ) {
        self.remoteRepository = remoteRepository
        self.localRepository = localRepository
    }
    
    
    
    //  MARK: - Internal API
    func execute(forURL url: URL) async throws -> UIImage {
        do {
            return try await localRepository.getImage(forURL: url)
            
        } catch {
            let image = try await remoteRepository.getImage(forURL: url)
            try await localRepository.saveImage(image, forURL: url)
            return image
        }
    }
}
