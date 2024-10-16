import UIKit.UIImage

protocol ImageRepository {
    
/// Asynchronously fetches an image from a given URL.
///
/// - Parameter url: The URL of the image to fetch.
/// - Returns: A UIImage object representing the fetched image.
/// - Throws: An error if the image cannot be fetched or processed.
    func getImage(forURL url: URL) async throws -> UIImage
}


enum ImageError: Error {
    
    /// Indicates that the data received is not valid image data
    case invalidData
    
    /// Indicates that the requested image could not be found
    case imageNotFound
    
    /// Indicates an error occurred during the serialization process
    case serialization
    
    /// Indicates an error occurred while reading an image file
    case fileReadError
    
    /// Indicates an error occurred during the deserialization process
    case deserialization
}
