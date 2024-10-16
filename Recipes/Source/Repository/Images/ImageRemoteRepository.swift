import UIKit

protocol ImageRemoteRepository: ImageRepository {
    
    func getImage(forURL url: URL) async throws -> UIImage
}


final actor DefaultImageRemoteRepository: ImageRemoteRepository {
    
    func getImage(forURL url: URL) async throws -> UIImage {
        let (data, _) = try await URLSession(
            configuration: URLSessionConfiguration.default
        )
            .data(from: url)
        
        guard let image = UIImage(data: data) else {
            throw ImageError.invalidData
        }
        
        return image
    }
}
