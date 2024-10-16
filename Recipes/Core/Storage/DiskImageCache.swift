import UIKit.UIImage
import CommonCrypto


actor DiskImageCache {
    
    
    //  MARK: - Private Properties
    private let fileManager: FileManager
    private let cacheDirectoryURL: URL
    
    
    
    //  MARK: - Init
    init() throws {
        self.fileManager = FileManager.default
        let cachesDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        self.cacheDirectoryURL = cachesDirectory[0].appendingPathComponent("RECIPES_IMAGE_CACHE")
        
        try fileManager.createDirectory(
            at: cacheDirectoryURL,
            withIntermediateDirectories: true
        )
    }
    
    
    
    // MARK: - Internal API
    func save(image: UIImage, fileName: String) async throws {
        guard let data = image.pngData() else {
            throw ImageError.serialization
        }
        
        try data.write(to: url(forFileName: fileName))
    }
    
    
    func getImage(fileName: String) async throws -> UIImage {
        let fileURL = url(forFileName: fileName)
        
        guard fileManager.fileExists(atPath: fileURL.path) else {
            throw ImageError.imageNotFound
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            
            guard let image = UIImage(data: data) else {
                throw ImageError.deserialization
            }
            
            return image
            
        } catch {
            throw ImageError.fileReadError
        }
    }
    
    
    
    //  MARK: - Private API
    private func url(forFileName fileName: String) -> URL {
        cacheDirectoryURL.appendingPathComponent(fileName.asSHA256)
    }
}





//  MARK: - SHA256 Extension
fileprivate extension String {
    
    var asSHA256: String {
        let data = Data(utf8)
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA256($0.baseAddress, CC_LONG(data.count), &hash)
        }
        return hash.map {
            String(format: "%02x", $0)
        }
        .joined()
    }
}
